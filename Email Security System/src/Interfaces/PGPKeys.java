package interfaces;
import java.security.KeyPairGenerator;
import java.security.KeyPair;
import java.security.SecureRandom;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;

public class PGPKeys{
	private byte[] privateExponent,publicExponent,modulus;

	private PGPKeys(byte[] privateExponent, byte[] publicExponent,byte[] modulus){
		this.privateExponent = privateExponent;
		this.publicExponent = publicExponent;
		this.modulus = modulus;
	}
	public static PGPKeys generateKeys()throws NoSuchAlgorithmException{
		KeyPairGenerator kpg = KeyPairGenerator.getInstance("RSA");
		kpg.initialize(1024,new SecureRandom());

		KeyPair kp =  kpg.generateKeyPair();
		RSAPrivateKey rsaPrivate = (RSAPrivateKey)kp.getPrivate();
		RSAPublicKey rsaPublic = (RSAPublicKey) kp.getPublic();

		byte[] modulus = rsaPublic.getModulus().toByteArray();
		byte[] privateExponent = rsaPrivate.getPrivateExponent().toByteArray();
		byte[] publicExponent = rsaPublic.getPublicExponent().toByteArray();
		
		return new PGPKeys(privateExponent,publicExponent,modulus);
/*
 * public key = 1 byte representing the length of the modulus
 * followed by the modulus and remaining bytes of exponent
 */
/*
							
		pubKey = new byte[mod.length+pubExp.length+1];
		pubKey[0] = (byte)mod.length;
		System.arraycopy(mod,0,pubKey,1,mod.length);
		System.arraycopy(pubExp,0,pubKey,mod.length+1,pubExp.length);
*/
/*
 * private key = 1 byte representing the length of the modulus
 * followed by the modulus and remaining bytes of exponent
 */
/*
		priKey = new byte[mod.length+priExp.length+1];
		priKey[0] = (byte) mod.length;
		System.arraycopy(mod,0,priKey,1,mod.length);
		System.arraycopy(priExp,0,priKey,mod.length+1,priExp.length);
*/
	}
	public byte[] getPublicExponent(){
		return publicExponent;
	}
	public byte[] getPrivateExponent(){
		return privateExponent;
	}
	public byte[] getModulus(){
		return modulus;
	}
	public static void main(String[] arg)throws NoSuchAlgorithmException{
		PGPKeys pk = PGPKeys.generateKeys();
		System.out.println("Private Key:"+ new java.math.BigInteger(pk.getPrivateExponent()).toString(16));		
	}
}