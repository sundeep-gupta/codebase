package interfaces;
public class Demerger{
	private byte[] mergedData,first,second;
	public Demerger(byte[] mergedData){
		this.mergedData = mergedData;
		demerge();
	}
	protected void demerge(){
		
		int len = mergedData[0]&0xff;

		first = new byte[len];
		second = new byte[mergedData.length - len - 1];

		System.arraycopy(mergedData,1,first,0,first.length);
		System.arraycopy(mergedData,first.length+1,second,0,second.length);
	}
	public byte[] getFirst(){
		return first;
	}
	public byte[] getSecond(){
		return second;
	}
}