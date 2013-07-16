package com.ironmountain.pageobject.webobjects.connected.actions.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.AddLDAPConfigPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.CreateAgentSettingsPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.CreateAgentVersionPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigCreatePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigSummaryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.ProfileAndWebSiteSettingsPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetGeneralPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetRulesPage;

/** Class to perform various supportcenter actions
 * @author pjames
 *
 */
/**
 * @author pjames
 *
 */

public class CreateSettings{
	
	static SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);


		
	/** Method to create Profile and WebSite Settings
	 * @param ProfileName
	 * @param Description
	 * @return
	 */
	public static SupportCenterHomePage createProfileAndWebSiteSettings(String ProfileName, String Description,String SupportInfo){
		ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
		profileAndWebSiteSettingsPage.typeName(ProfileName);
		profileAndWebSiteSettingsPage.typeDescription(Description);
		profileAndWebSiteSettingsPage.typeSupportInfo(SupportInfo);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.changeStatus("Company", "Read-Only");
		profileAndWebSiteSettingsPage.changeStatus("Department", "Hidden");
		profileAndWebSiteSettingsPage.changeStatus("Location", "Editable");
		//profileAndWebSiteSettingsPage.changeStatus("Employee ID", "Required");
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		return profileAndWebSiteSettingsPage.clickOnFinishBtn();
	}
	
	public static void createDefaultProfileAndWebSiteSettings(String ProfileName, String supportInfo){
		ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
		profileAndWebSiteSettingsPage.typeName(ProfileName);
		profileAndWebSiteSettingsPage.typeSupportInfo(supportInfo);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
	}
	
	public static void createProfileAndWebSiteSettingsWithCustomLogon(String ProfileName, String supportInfo, String CustomLogonURL){
		ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
		profileAndWebSiteSettingsPage.typeName(ProfileName);
		profileAndWebSiteSettingsPage.typeSupportInfo(supportInfo);
		profileAndWebSiteSettingsPage.clickOnCustomURL();
		profileAndWebSiteSettingsPage.typeCustomURL(CustomLogonURL);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
	}
	
	/** Over loaded Method to create Profile and WebSite Settings
	 * @param ProfileName
	 * @param Description
	 * @return
	 */
	public static SupportCenterHomePage createProfileAndWebSiteSettings(String ProfileName, String Description){
		ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
		profileAndWebSiteSettingsPage.typeName(ProfileName);
		profileAndWebSiteSettingsPage.typeDescription(Description);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.changeStatus("Company", "Read-Only");
		profileAndWebSiteSettingsPage.changeStatus("Department", "Hidden");
		profileAndWebSiteSettingsPage.changeStatus("Location", "Editable");
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		return profileAndWebSiteSettingsPage.clickOnFinishBtn();
	}
	
	/** Method to create Profile and WebSite Settings
	 * @param ProfileName
	 * @param Description
	 * @return
	 */
	public static SupportCenterHomePage createProfileAndWebSiteSettingswithCustomValues(String ProfileName, String Description,String SupportInfo, String CustomLabel, String DefValue, 
			String CompDefValue, String LocDefValue, String EmplDefValue){
		ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
		profileAndWebSiteSettingsPage.typeName(ProfileName);
		profileAndWebSiteSettingsPage.typeDescription(Description);
		profileAndWebSiteSettingsPage.typeSupportInfo(SupportInfo);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.changeStatus("Company", "Read-Only");
		profileAndWebSiteSettingsPage.typeCompanyDefValue(CompDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Department", "Hidden");
		profileAndWebSiteSettingsPage.changeStatus("Location", "Editable");
		profileAndWebSiteSettingsPage.typeLocationDefValue(LocDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Employee ID", "Required");
		profileAndWebSiteSettingsPage.typeEmployeeDefValue(EmplDefValue);	
		profileAndWebSiteSettingsPage.createCustom(CustomLabel, "Editable", DefValue);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		return profileAndWebSiteSettingsPage.clickOnFinishBtn();
	}
	
	
	/** Create Agent Versions
	 * @param Name
	 * @param Description
	 * @return
	 */
	public static SupportCenterHomePage createAgentVersions(String Name, String Description, String AgentVersion){
		CreateAgentVersionPage createAgentVersionPage = (CreateAgentVersionPage) PageFactory.getNewPage(CreateAgentVersionPage.class);
		createAgentVersionPage.typeName(Name);
		createAgentVersionPage.typeDescription(Description);
		createAgentVersionPage.select("agentfilesetid", AgentVersion);
		return createAgentVersionPage.clickOnCreateBtn();
	}
	
	/** Create Agent Settings
	 * @param Name
	 * @param Description
	 * @return
	 */
	public static SupportCenterHomePage createAgentSettings(String Name, String Description){
		CreateAgentSettingsPage createAgentSettingsPage = (CreateAgentSettingsPage) PageFactory.getNewPage(CreateAgentSettingsPage.class);
		createAgentSettingsPage.typeName(Name);
		createAgentSettingsPage.typeDescription(Description);
		createAgentSettingsPage.clickOnNextButton();
		createAgentSettingsPage.clickOnNextButton();
		createAgentSettingsPage.selectDataOnlyBackUp();
		createAgentSettingsPage.selectPassiveMode();
		//createAgentSettingsPage.selectDisableFilterDrivers();
		createAgentSettingsPage.clickOnNextButton();
		createAgentSettingsPage.selectDonotBackupAutomatically();
		return createAgentSettingsPage.clickOnFinishBtn();
	}
	
	/**
	 * This method will create a dummy of blank RuleSet
	 * 
	 * @param Name
	 * @param Description
	 * @return
	 */
	public static PCAgentCreateRuleSetGeneralPage createEmptyPCAgentRuleSettings(String Name, String Description){
		PCAgentCreateRuleSetGeneralPage pcAgentRulePage = (PCAgentCreateRuleSetGeneralPage) PageFactory.getNewPage(PCAgentCreateRuleSetGeneralPage.class);		
		pcAgentRulePage.typeRuleSetName(Name);
		pcAgentRulePage.typeRuleSetDescription(Description);
		PCAgentCreateRuleSetRulesPage rulesPage = pcAgentRulePage.clickOnNextButton();
		return rulesPage.clickOnFinishRuleSetsButton();
	}
		
	/**Create PC Configuration
	 * @param Name
	 * @param Description
	 * @param VersionName
	 * @param AgentSettingsName
	 * @return
	 */
	public static SupportCenterHomePage createPCConfiguration(String Name, String Description, String VersionName, String AgentSettingsName){
		PCAgentConfigCreatePage pcAgentConfigCreatePage = (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
		pcAgentConfigCreatePage.typeName(Name);
		pcAgentConfigCreatePage.typeDesc(Description);
		pcAgentConfigCreatePage.selectAgentVersion(VersionName);
		pcAgentConfigCreatePage.selectAgentSettings(AgentSettingsName);
		return pcAgentConfigCreatePage.clickOnCreateBtn();
	}	
	public static SupportCenterHomePage createPCConfiguration(String Name, String Description, String version, String agentSettings, String profileSettings, String agentRuleSet){
		PCAgentConfigCreatePage pcAgentConfigCreatePage = (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
		pcAgentConfigCreatePage.typeName(Name);
		pcAgentConfigCreatePage.typeDesc(Description);
		pcAgentConfigCreatePage.selectAgentVersion(version);
		pcAgentConfigCreatePage.selectAgentSettings(agentSettings);
		pcAgentConfigCreatePage.selectProfileAndWebSettings(profileSettings);
		pcAgentConfigCreatePage.selectAgentRuleSet(agentRuleSet);
		return pcAgentConfigCreatePage.clickOnCreateBtn();
	}
	public static SupportCenterHomePage createPCConfiguration(String Name, String Description, String version, String agentSettings, String agentRuleSet){
		PCAgentConfigCreatePage pcAgentConfigCreatePage = (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
		pcAgentConfigCreatePage.typeName(Name);
		pcAgentConfigCreatePage.typeDesc(Description);
		pcAgentConfigCreatePage.selectAgentVersion(version);
		pcAgentConfigCreatePage.selectAgentSettings(agentSettings);
		pcAgentConfigCreatePage.selectAgentRuleSet(agentRuleSet);
		return pcAgentConfigCreatePage.clickOnCreateBtn();
	}
	
	/**Uncheck the option Use Inherited Configuration Settings
	 * @return
	 */
	public static SupportCenterHomePage unCheckInheritedConfigSettings(){
		PCAgentConfigSummaryPage pcAgentConfigSummaryPage = (PCAgentConfigSummaryPage) PageFactory.getNewPage(PCAgentConfigSummaryPage.class);	
		try {
		pcAgentConfigSummaryPage.clickOnEditConfigOptions();
		}
		catch (Exception e)
		{
			System.out.println(e);
		}
		pcAgentConfigSummaryPage.refreshPage();
		pcAgentConfigSummaryPage.unCheckUseInheritedConfig();
		pcAgentConfigSummaryPage.clickOnSaveAndDeployBtn();
		return pcAgentConfigSummaryPage.clickOnOKBtn();
		
	}
	
	/**Configure the LDAP settings in enterprise directory page.
	 * @param LDAPUrl
	 * @param LogonDN
	 * @param ConnPassword
	 * @param UserClass
	 * @param LoginID
	 * @param UniqueID
	 * @param Email
	 */
	public static void configureLDAP(String LDAPUrl,String LogonDN,String ConnPassword,
			String UserClass,String LoginID,String UniqueID,String Email){
		AddLDAPConfigPage addLDAPConfigPage = (AddLDAPConfigPage) PageFactory.getNewPage(AddLDAPConfigPage.class);
		addLDAPConfigPage.typeDirectoryURL(LDAPUrl);
		addLDAPConfigPage.typeLogonDN(LogonDN);
		addLDAPConfigPage.typeConnPassword(ConnPassword);
		addLDAPConfigPage.typeUserClass(UserClass);
		addLDAPConfigPage.typeLoginID(LoginID);
		addLDAPConfigPage.typeUniqueID(UniqueID);
		addLDAPConfigPage.typeEmail(Email);
		addLDAPConfigPage.uncheckSSL();
		addLDAPConfigPage.clickOnSaveBtn();		
	}
	
	public static void enterProfileAddressFields(String AddressStatus, String Country, String AddressLine1, String AddressLine2, String AddressLine3, 
											String City, String State, String PostalCode){
		ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
		profileAndWebSiteSettingsPage.selectAddressStatus(AddressStatus);
		profileAndWebSiteSettingsPage.selectCountry(Country);
		profileAndWebSiteSettingsPage.typeAddLine1(AddressLine1);
		profileAndWebSiteSettingsPage.typeAddLine2(AddressLine2);
		profileAndWebSiteSettingsPage.typeAddLine3(AddressLine3);
		profileAndWebSiteSettingsPage.typeCity(City);
		profileAndWebSiteSettingsPage.selectState(State);
		profileAndWebSiteSettingsPage.typePostalCode(PostalCode);
		
	}
	
}
