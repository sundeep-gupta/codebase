import java.util.*;

class CalendarMonthWeek{
	public static void main(String[] args){
		GregorianCalendar gc = new GregorianCalendar();
		gc.add(Calendar.DAY_OF_MONTH, -gc.get(Calendar.DAY_OF_WEEK));
		System.out.println(gc.get(Calendar.DAY_OF_MONTH) + "-" + gc.get(Calendar.MONTH) + "-" + gc.get(Calendar.YEAR));
		gc.add(Calendar.DAY_OF_MONTH, -6);
		System.out.println(gc.get(Calendar.DAY_OF_MONTH) + "-" + gc.get(Calendar.MONTH) + "-" + gc.get(Calendar.YEAR));
	}
}
