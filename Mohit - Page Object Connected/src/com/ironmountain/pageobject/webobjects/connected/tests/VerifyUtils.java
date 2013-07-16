package com.ironmountain.pageobject.webobjects.connected.tests;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;

public class VerifyUtils {

	
	/**
	 * This method helps to verify a list of texts in the page.
	 * Its useful when the user will pass the list of texts as a Single parameter from testNG suite.
	 * the String should be comma separated list of Strings/Texts.
	 * 
	 * @param page
	 * @param commaSeparatedTexts
	 */
	public static void verifyTextsInPage(SeleniumPage page, String commaSeparatedTexts)
	{
		ArrayList<String> list = StringUtils.toStringArrayList(commaSeparatedTexts);
		for(String text:list){
			page.isTextPresentFailOnNotFound(text);
		}
	}

	public static void verifyStringsInaList(String[] stringList,
			ArrayList<String> list, boolean isPresent) throws Exception {

		Collections.sort(list);
		Arrays.sort(stringList);
		for (String string : stringList) {
			boolean found = false;
			for (String listString : list) {
				if (string.contains(listString)) {
					found = true;
					break;
				}
			}
			if (!found && isPresent) {
				Asserter.fail("The String given'" + string
						+ "' is not found in List");
			} else if (found && !isPresent) {
				Asserter.fail("The String given'" + string
						+ "' is found in List");
			}
		}
	}			
	
}
