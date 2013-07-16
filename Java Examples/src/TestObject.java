class TestObject{
	public static void main(String[] args){
		Object sb = new StringBuffer("kedar");
		System.out.println(sb);
		changeObj(sb);
		System.out.println(sb);
	}

	public static void changeObj(Object sb1){

		sb1 = ((StringBuffer)sb1).delete(0, ((StringBuffer)sb1).length());
		((StringBuffer)sb1).insert(0,"nath");
	}
}
