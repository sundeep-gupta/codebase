package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.awt.image.BufferedImage;
import java.awt.image.DataBuffer;
import java.awt.image.Raster;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;

import javax.imageio.ImageIO;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.log4j.Logger;
import org.apache.tools.ant.taskdefs.condition.FilesMatch;

/** Image related Utilities.
 * @author pjames
 *
 */
public class ImageUtils {

	
	/** Method to compare two images by bytecode.
	 * @param Image1
	 * @param Image2
	 * @return boolean result. True-->The Images are same. False-->Images are not the same.
	 */
public static boolean compareTwoImages(String Image1, String Image2) throws Exception{
		boolean isSame = false;
		//try { 
		BufferedImage bi1 = ImageIO.read(new File(Image1)); 
		BufferedImage bi2 = ImageIO.read(new File(Image2));
		Raster r1 = bi1.getData();
		DataBuffer db1 = r1.getDataBuffer();
		int size1 = db1.getSize(); 
		Raster r2 = bi2.getData(); 
		DataBuffer db2 = r2.getDataBuffer(); 
		int size2 = db2.getSize();
		if (size1 == size2) { 
			isSame = true;
			for (int i = 0; i < size1; i++ ) 
			{ 
				if ((db1.getElem(i))!= (db2.getElem(i))) { 
					isSame = false; break;
				}
			}
		}
//		if (isSame) { 
//			return isSame;
//		} else {
//			return isSame;
//		}
//		} catch (MalformedURLException e) { e.printStackTrace(); } catch (IOException e) { e.printStackTrace(); }
//		
		return isSame;
	}

       private static String generateHash(final String filePath) {
        MessageDigest digest;
        try {
            digest = MessageDigest.getInstance("MD5");
        } catch (final NoSuchAlgorithmException e) {
            throw new RuntimeException("No MD5 hashing for content check: " + e.toString());
        }
       
        final File f = new File(filePath);
        InputStream is;
        try {
            is = new FileInputStream(f);
        } catch (final FileNotFoundException e) {
            throw new RuntimeException(e.toString());
        }

        final byte[] buffer = new byte[8192];
        int read = 0;
        String output = null;
        try {
            while ((read = is.read(buffer)) > 0) {
                digest.update(buffer, 0, read);
            }
            final byte[] md5sum = digest.digest();
            final BigInteger bigInt = new BigInteger(1, md5sum);
            output = bigInt.toString(16);
        } catch (final IOException e) {
            throw new RuntimeException("Unable to process file for MD5", e);
        } finally {
            try {
                is.close();
            } catch (final IOException e) {
                throw new RuntimeException("Unable to close input stream for MD5 calculation", e);
            }
        }
        return (output);
    }
       public static boolean filesIdenticalCheck(final String filePath1, final String filePath2) {
           // content check
           final String hash1 = generateHash(filePath1);
           final String hash2 = generateHash(filePath2);

           if (!hash1.equals(hash2)) {
               //logger.debug("Comparison fail: '" + filePath1 + "' vs. '" + filePath2 + "'");
              // logger.debug("  (" + hash1 + " vs. " + hash2 + ")");
               return (false);
           }

           // if we get here, files must be identical
           return (true);
       }
}
