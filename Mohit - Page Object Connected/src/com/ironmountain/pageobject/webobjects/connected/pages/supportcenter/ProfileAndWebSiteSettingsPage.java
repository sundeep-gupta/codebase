package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class ProfileAndWebSiteSettingsPage extends SeleniumPage {
	
	public ProfileAndWebSiteSettingsPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
	}
	
	public void typeName(String Name){
		type("SupportCenterPage.Name", Name);
	}
	public boolean verifyNameEditable(){
		return isEditable("SupportCenterPage.Name");
	}
	public void typeDescription(String Description){
		type("SupportCenterPage.Desc", Description);
	}
	public boolean verifyDescriptionEditable(){
		return isEditable("SupportCenterPage.Desc");
	}
	public void clickOnNextBtn(){
		click("SupportCenterPage.NextBtn");
	}
	public void typeSupportInfo(String SupportInfo){
		type("SupportCenterPage.SupportInfo", SupportInfo);
	}
	public void clickOnCustomURL(){
		check("ProfileAndWebSettingsPage.CustomURL");
	}
	public void typeCustomURL(String url){
		type("ProfileAndWebSettingsPage.CustomURLText", url);
	}
	public boolean verifySupportInfoEditable(){
		return isEditable("SupportCenterPage.SupportInfo");
	}
	public boolean verifyDefaultURLEditable(){
		return isEditable("ProfileAndWebSettingsPage.DefaultURL");
	}
	public boolean verifyCustomURLEditable(){
		return isEditable("ProfileAndWebSettingsPage.CustomURL");
	}
	public boolean verifyAddressStateEditable(){
		return isEditable("ProfileAndWebSettingsPage.AddressState");
	}
	public void selectAddressStatus(String AddStatus){
		select("ProfileAndWebSettingsPage.AddressState", AddStatus);
	}
	public boolean verifyCountryEditable(){
		return isEditable("ProfileAndWebSettingsPage.Country");
	}
	public void selectCountry(String Country){
		select("ProfileAndWebSettingsPage.Country", Country);
	}
	public boolean verifyAddLine1Editable(){
		return isEditable("ProfileAndWebSettingsPage.AddLine1");
	}
	public void typeAddLine1(String AddLine1){
		type("ProfileAndWebSettingsPage.AddLine1", AddLine1);
	}
	public boolean verifyAddLine2Editable(){
		return isEditable("ProfileAndWebSettingsPage.AddLine2");
	}
	public void typeAddLine2(String AddLine2){
		type("ProfileAndWebSettingsPage.AddLine2", AddLine2);
	}
	public boolean verifyAddLine3Editable(){
		return isEditable("ProfileAndWebSettingsPage.AddLine3");
	}
	public void typeAddLine3(String AddLine3){
		type("ProfileAndWebSettingsPage.AddLine3", AddLine3);
	}
	public boolean verifyCityEditable(){
		return isEditable("ProfileAndWebSettingsPage.City");
	}
	public void typeCity(String City){
		type("ProfileAndWebSettingsPage.City", City);
	}
	public boolean verifyStateEditable(){
		return selenium.isEditable("ProfileAndWebSettingsPage.State");
	}
	public void selectState(String State){
		select("ProfileAndWebSettingsPage.State", State);
	}
	public boolean verifyPostalCodeEditable(){
		return isEditable("ProfileAndWebSettingsPage.PostalCode");
	}
	public void typePostalCode(String Code){
		type("ProfileAndWebSettingsPage.PostalCode", Code);
	}
	public boolean verifyCompanyStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.CompanyStatus");
	}
	public boolean verifyDepartmentStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.DepartmentStatus");
	}
	public boolean verifyLocationStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.LocationStatus");
	}
	public boolean verifyMailStopStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.MailStopStatus");
	}
	public boolean verifyCostCenterStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.CostCenterStatus");
	}
	public boolean verifyEmployeeStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.EmployeeStatus");
	}
	public boolean verifyPhoneNumStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.PhoneNumStatus");
	}
	public boolean verifyExtnStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.ExtnStatus");
	}
	public boolean verifyCompanyDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.CompanyDef");
	}
	public boolean verifyDepartmentDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.DepartmentDef");
	}
	public boolean verifyLocationDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.LocationDef");
	}
	public boolean verifyMailStopDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.MailStopDef");
	}
	public void typeMailStopDefValue(String MailStopDefValue){
		type("ProfileAndWebSettingsPage.MailStopDef", MailStopDefValue);
	}
	public boolean verifyCostCenterDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.CostCenterDef");
	}
	public void typeCostCenterDefValue(String CostCenterDefValue){
		type("ProfileAndWebSettingsPage.CostCenterDef", CostCenterDefValue);
	}
	public boolean verifyEmployeeDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.EmployeeDef");
	}
	public boolean verifyPhoneNumDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.PhoneNumDef");
	}
	public void typePhoneNumDefValue(String PhoneNumDefValue){
		type("ProfileAndWebSettingsPage.PhoneNumDef", PhoneNumDefValue);
	}
	public boolean verifyExtnDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.ExtnDef");
	}
	public void typeExtnDefValue(String ExtnDefValue){
		type("ProfileAndWebSettingsPage.ExtnDef", ExtnDefValue);
	}
	public boolean verifyCustomDefEditable(){
		return isEditable("ProfileAndWebSettingsPage.CustomStatus");
	}
	public boolean verifyCustomStatusEditable(){
		return isEditable("ProfileAndWebSettingsPage.CustomDef");
	}
	public void changeStatus(String Field, String Status){
		String fieldLoc = null;
		if (Field.equalsIgnoreCase("Company")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.CompanyStatus");
		} else if (Field.equalsIgnoreCase("Department")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.DepartmentStatus");
		} else if (Field.equalsIgnoreCase("Location")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.LocationStatus");
		} else if (Field.equalsIgnoreCase("Employee ID")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.EmployeeStatus");
		} else if (Field.equalsIgnoreCase("Mail Stop")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.MailStopStatus");
		} else if (Field.equalsIgnoreCase("Cost Center")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.CostCenterStatus");
		} else if (Field.equalsIgnoreCase("Phone Number")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.PhoneNumStatus");
		} else if (Field.equalsIgnoreCase("Extension")){
			fieldLoc = getLocator("ProfileAndWebSettingsPage.ExtnStatus");
		}
		select(fieldLoc, "label="+Status);

	}
	public void createCustom(String CustomLabel, String Status, String DefValue){
		type("ProfileAndWebSettingsPage.CustomLabel", CustomLabel);
		select("ProfileAndWebSettingsPage.CustomStatus", "label="+Status);
		type("ProfileAndWebSettingsPage.CustomDef", DefValue);
	}
	
	public void typeCompanyDefValue(String CompDefValue){
		type("ProfileAndWebSettingsPage.CompanyDef", CompDefValue);
	}
	public void typeLocationDefValue(String LocDefValue){
		type("ProfileAndWebSettingsPage.LocationDef", LocDefValue);
	}
	public void typeDepartmentDefValue(String DepartDefValue){
		type("ProfileAndWebSettingsPage.DepartmentDef", DepartDefValue);
	}
	
	public void typeEmployeeDefValue(String EmplDefValue){
		type("ProfileAndWebSettingsPage.EmployeeDef", EmplDefValue);
	}
	public boolean verifyAgentMenuOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.AgentMenuOptionChkBox");
	}
	public boolean verifyPermitUserAsianOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.PermitUserAsianOptionChkBox");
	}
	public boolean verifyAllowEditProfOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.AllowEditProfChkBox");
	}
	public boolean verifyRequireAuthenOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.RequireAuthenChkBox");
	}
	public boolean verifyProhibitDownloadOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.ProhibitDownloadChkBox");
	}
	public boolean verifyShowServiceLicenseOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.ShowServiceLicenseChkBox");
	}
	public boolean verifyAllowOrderMediaOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.AllowOrderMediaChkBox");
	}
	public boolean verifyAllowRetrieveFilesOptionEditable(){
		return isEditable("ProfileAndWebSettingsPage.AllowRetrieveFilesChkBox");
	}
	public void checkAllowRetrieveFilesOption(){
		check("ProfileAndWebSettingsPage.AllowRetrieveFilesChkBox");
	}
	public void uncheckAllowRetrieveFilesOption(){
		unCheck("ProfileAndWebSettingsPage.AllowRetrieveFilesChkBox");
	}
	public void checkAllowOrderMediaOption(){
		check("ProfileAndWebSettingsPage.AllowOrderMediaChkBox");
	}
	public void uncheckAllowOrderMediaOption(){
		unCheck("ProfileAndWebSettingsPage.AllowOrderMediaChkBox");
	}
	public void checkShowServiceLicenseOption(){
		check("ProfileAndWebSettingsPage.ShowServiceLicenseChkBox");
	}
	public void uncheckShowServiceLicenseOption(){
		unCheck("ProfileAndWebSettingsPage.ShowServiceLicenseChkBox");
	}
	public void checkProhibitDownloadOption(){
		check("ProfileAndWebSettingsPage.ProhibitDownloadChkBox");
	}
	public void uncheckProhibitDownloadOption(){
		unCheck("ProfileAndWebSettingsPage.ProhibitDownloadChkBox");
	}
	public void checkRequireAuthenOption(){
		check("ProfileAndWebSettingsPage.RequireAuthenChkBox");
	}
	public void uncheckRequireAuthenOption(){
		unCheck("ProfileAndWebSettingsPage.RequireAuthenChkBox");
	}
	public void checkAllowEditProfOption(){
		check("ProfileAndWebSettingsPage.AllowEditProfChkBox");
	}
	public void uncheckAllowEditProfOption(){
		unCheck("ProfileAndWebSettingsPage.AllowEditProfChkBox");
	}
	public void checkAgentMenuOption(){
		check("ProfileAndWebSettingsPage.AgentMenuOptionChkBox");
	}
	public void uncheckAgentMenuOption(){
		unCheck("ProfileAndWebSettingsPage.AgentMenuOptionChkBox");
	}
	public void checkPermitUserAsianOption(){
		check("ProfileAndWebSettingsPage.PermitUserAsianOptionChkBox");
	}
	public void uncheckPermitUserAsianOption(){
		unCheck("ProfileAndWebSettingsPage.PermitUserAsianOptionChkBox");
	}
	public boolean verifyShowServiceLicenseOption(){
		return isChecked("ProfileAndWebSettingsPage.ShowServiceLicenseChkBox");
	}
	public boolean verifyAllowOrderMediaOption(){
		return isChecked("ProfileAndWebSettingsPage.AllowOrderMediaChkBox");
	}
	public boolean verifyAllowRetrieveFilesOption(){
		return isChecked("ProfileAndWebSettingsPage.AllowRetrieveFilesChkBox");
	}
	public boolean verifyProhibitDownloadOption(){
		return isChecked("ProfileAndWebSettingsPage.ProhibitDownloadChkBox");
	}
	public boolean verifyRequireAuthenOption(){
		return isChecked("ProfileAndWebSettingsPage.RequireAuthenChkBox");
	}
	public boolean verifyPermitUserAsianOption(){
		return isChecked("ProfileAndWebSettingsPage.PermitUserAsianOptionChkBox");
	}
	public boolean verifyAgentMenuOption(){
		return isChecked("ProfileAndWebSettingsPage.AgentMenuOptionChkBox");
	}
	public boolean verifyAllowEditProfOption(){
		return isChecked("ProfileAndWebSettingsPage.AllowEditProfChkBox");
	}
	public void clickOnBackBtn(){
		click("BackBtn");
	}
	public void clickOnLogOff(){
		selenium.click("//a[contains(@onclick,'Logout')]");
	}
	public SupportCenterHomePage clickOnFinishBtn(){
		click("SupportCenterPage.FinishBtn");
		return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}

	public void selectRelativeUptoAppHeader(){
		selenium.selectFrame("relative=up");
		selenium.selectFrame("relative=up");
		selenium.selectFrame("relative=up");
		selenium.selectFrame("AppHeader");
	}
	
	public void selectAppletView(){
	 	selectFrame("AppBody");
		selectFrame("NodeView");
		selectFrame("NodeHeader");
	}
	
	public void selectAppHeaderFrame()
	{
		selectFrame("AppHeader");
	}
	public void selectAppBodyFrame()
	{
		selectFrame("AppBody");
	}
	public void selectAppBodyTreeFrame()
	{
		selectAppBodyFrame();
		selectFrame("Tree");
	}
	public void selectAppBodyNodeViewFrame()
	{
		selectAppBodyFrame();
		selectFrame("NodeView");
	}
	public void selectAppBodyNodeViewNodeHeaderFrame()
	{
		selectAppBodyNodeViewFrame();
		selectFrame("NodeHeader");
	}
	public void selectAppBodyNodeViewNodeDetailsFrame()
	{
		selectAppBodyNodeViewFrame();
		selectFrame("NodeDetails");
	}
	public void selectNodeHeader(){
		selectFrame("NodeHeader");
	}
	public void selectNodeDetails(){
		selectFrame("NodeDetails");
	}
	
	public void clickOnUsageMenu(){
		click("ProfileAndWebsiteSetting.UsageMenu");
	}
	
	public boolean verifyProfileUsageText(String inputText){
		String text = getText("ProfileAndWebsiteSetting.UsageText");
		if (text.contains(inputText)){
			return true;
		} else return false;
	}
	
	public String getSelectedPWSLabel(String selectfield){
		String selectedval = null;
		if (selectfield.equalsIgnoreCase("Company")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.CompanyStatus");
		} else if (selectfield.equalsIgnoreCase("Department")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.DepartmentStatus");
		} else if (selectfield.equalsIgnoreCase("Location")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.LocationStatus");
		} else if (selectfield.equalsIgnoreCase("Employee ID")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.EmployeeStatus");
		} else if (selectfield.equalsIgnoreCase("Mail Stop")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.MailStopStatus");
		} else if (selectfield.equalsIgnoreCase("Cost Center")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.CostCenterStatus");
		} else if (selectfield.equalsIgnoreCase("Phone Number")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.PhoneNumStatus");
		} else if (selectfield.equalsIgnoreCase("Extension")){
			selectedval = getSelectedLabel("ProfileAndWebSettingsPage.ExtnStatus");
		}
		return selectedval;
		
	}
}
