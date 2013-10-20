package com.ironmountain.pageobject.webobjects.connected.tests.amws;

import java.util.ArrayList;
import java.util.Collections;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm1Page;

public class OrderMediaVerifyUtils {

	
	/**
	 * This method will verify the backup dates list, note that there is no navigation defined.. 
	 * So make sure that the verification happens when the user is in OrderCdOrDvdForm1Page
	 * 
	 * @param avilableBackupDates
	 * @throws Exception
	 */
	public static void verifyAvailableBackupDates(ArrayList<String> avilableBackupDates, boolean isVerifyAvilabelNumber) throws Exception{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = (OrderCdOrDvdForm1Page) PageFactory.getNewPage(OrderCdOrDvdForm1Page.class);
		ArrayList<String> list = orderCdorDvdForm1Page.getAllBackupdates();
		Collections.sort(list);
		Collections.sort(avilableBackupDates);
		if(isVerifyAvilabelNumber){
			if(list.size()!= avilableBackupDates.size()){
				Asserter.assertEquals(list.size(), avilableBackupDates.size(),"The number fo backup dates listed are not correct.");
			}
		}		
		else{
			for(String avlDate:avilableBackupDates){
				boolean found = false;
				for(String selDate:list){
					if(avlDate.contains(selDate)){
						found = true;
						break;
					}
				}
				if(!found){
					Asserter.fail("The backup date given " + avlDate + " is not found in the drop down");
				}				
			}
		}				
	}
	public static void verifyAvailableBackupDates(ArrayList<String> avilableBackupDates, boolean isVerifyAvilabelNumber, boolean isPresent) throws Exception{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = (OrderCdOrDvdForm1Page) PageFactory.getNewPage(OrderCdOrDvdForm1Page.class);
		ArrayList<String> list = orderCdorDvdForm1Page.getAllBackupdates();
		Collections.sort(list);
		Collections.sort(avilableBackupDates);
		if(isVerifyAvilabelNumber){
			if(list.size()!= avilableBackupDates.size()){
				Asserter.assertEquals(list.size(), avilableBackupDates.size(),"The number fo backup dates listed are not correct.");
			}
		}		
		else{
			for(String avlDate:avilableBackupDates){
				boolean found = false;
				for(String selDate:list){
					if(avlDate.contains(selDate)){
						found = true;
						break;
					}
				}
				if(!found && isPresent){
					Asserter.fail("The backup date given'" + avlDate + "' is not found in the drop down");
				}
				else if(found && !isPresent){
					Asserter.fail("The backup date given'" + avlDate + "' is found in the drop down");
				}
			}
		}				
	}
	
		
}
