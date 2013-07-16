package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.thoughtworks.selenium.Selenium;

/** LDAP Configuration Page Object
 * @author pjames
 *
 */
public class AddLDAPConfigPage extends SeleniumPage {
	
	CommunityTable communityTable = null;
	
	public AddLDAPConfigPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
		communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
	}
	
	public void typeDirectoryURL(String LDAPUrl){
		type("LDAPCongigPage.URL", LDAPUrl);	
	}
	public void typeLogonDN(String LogonDN){
		type("LDAPCongigPage.LogonDN", LogonDN);	
	}
	public void typeConnPassword(String ConnPassword){
		type("LDAPCongigPage.ConnPassword", ConnPassword);	
	}
	public void typeUserClass(String UserClass){
		type("LDAPCongigPage.UserClass", UserClass);	
	}
	public void typeLoginID(String LoginID){
		type("LDAPCongigPage.LoginID", LoginID);	
	}
	public void typeUniqueID(String UniqueID){
		type("LDAPCongigPage.UniqueID", UniqueID);	
	}
	public void typeEmail(String Email){
		type("LDAPCongigPage.Email", Email);	
	}
	public void clickOnSaveBtn(){
		click("LDAPCongigPage.SaveBtn");
	}
	public void uncheckSSL(){
		String loc = getLocator("LDAPConfigPage.SSLBox");
		selenium.uncheck(loc);
	}
	

}
