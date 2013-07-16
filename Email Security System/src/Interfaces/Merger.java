package interfaces;
public class Merger{
	private byte[] first,second,mergedData;
	public Merger(byte[] first,byte[] second){
		this.first = first;
		this.second = second;
	}
	public byte[] merge(){
		mergedData = new byte[first.length+second.length+1];
		mergedData[0] = (byte)first.length;
		System.arraycopy(first,0,mergedData,1,first.length);
		System.arraycopy(second,0,mergedData,first.length+1,second.length);
		return mergedData;
	}
}