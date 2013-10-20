package com.ironmountain.connected.pages;


import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;


public class GryphonHomePage extends WebDriverPage {

	
	protected String HOME_PAGE_REF = "HomePage.";
	protected String REPORTS_PAGE_REF = "ReportsPage.";
	
	public GryphonHomePage () throws Exception {
		super();
	}
	
	/**
	 * @throws Exception
	 */
	public void selectReportsPage () throws Exception {
		String loc = getLocator(HOME_PAGE_REF+"Reports");
		clickAndWaitForPageLoad((findElement(getDriver(), By.xpath(loc))),20);
	}

	/**
	 * @throws Exception
	 */
	public void selectHomePage() throws Exception {
		String loc = getLocator(HOME_PAGE_REF+"Home");
		clickAndWaitForPageLoad((findElement(getDriver(), By.xpath(loc))), 20);
	}
	
	/**
	 * @throws Exception
	 */
	public void selectAssetReportsOverView() throws Exception {
		List<WebElement> wli = null ;
		List<WebElement> tli = null;
		ArrayList<String> nodeli = null;
		String loc = null;
		loc = getLocator(REPORTS_PAGE_REF+"TreeNode");
		wli = getDriver().findElements(By.xpath(loc));
		for (int i=1; i<7; i++){
			loc = getLocator(REPORTS_PAGE_REF+"UnOrderedList");
			String nodetxt = (wli.get(i)).findElement(By.xpath(loc+"/div/li["+i+"]/div/a/span")).getText();
			if (nodetxt.contains("Asset Reports")){
				String imgtxt = getDriver().findElement(By.xpath(loc+"/div/li["+i+"]/div/img")).getAttribute("class");
				System.out.println(imgtxt);
				if (imgtxt.contains("x-tree-elbow-plus")){
					clickAndWaitForPageLoad(getDriver().findElement(By.xpath("//ul[@class='x-tree-root-ct x-tree-lines']/div/li["+i+"]/div/img[@class='x-tree-ec-icon x-tree-elbow-plus']")), 10);
				} 
				tli = getDriver().findElements(By.xpath(loc+"/div/li["+i+"]/ul/li[@class='x-tree-node']"));
				for (int j=1; j<tli.size(); j++){
					String nodeeletxt = (tli.get(j)).findElement(By.xpath(loc+"/div/li["+i+"]/ul/li[@class='x-tree-node']["+i+"]")).getText();
					if (nodeeletxt.contains("Overview of Computers")){
						clickAndWaitForPageLoad((tli.get(j)).findElement(By.xpath(loc+"/div/li["+i+"]/ul/li[@class='x-tree-node']["+i+"]")), 20);
					}
				}
				break;
			}
		}	
	}
	
	/**
	 * @throws Exception
	 */
	public void selectGridEleUnderAssetReportsOverviewandSelectViewByFileClasses() throws Exception {
		List<WebElement> gli = null;
		String loc = null;
		loc = getLocator(REPORTS_PAGE_REF+"Grid");
		gli = getDriver().findElements(By.xpath(loc));	
		System.out.println(getDriver().findElement(By.xpath(loc + "/div[2]")).getText());
		rightClick(getDriver().findElement(By.xpath(loc + "/div[2]")));
		clickAndWaitForPageLoad(findElement(getDriver(), By.linkText("View by File Classes")), 20);	
		}
	
	/**
	 * @return
	 */
	public boolean verifyHomePageText(){
		String res = findElement(getDriver(), By.id("ContentBody")).getText();
		if (res.contains("GryphonHomePageText")){
			return true;		
		} else
			return false;
	}
	
	/**
	 * @return
	 */
	public boolean verifyTitle(){
		String res = getTitle();
		String logintitle = getLocator("GryphonLoginPageTitle");
		if (res.contains(logintitle)){
			return true;		
		} else
			return false;
	}
	
	
	/**
	 * @return
	 * @throws Exception
	 */
	public boolean verifyViewByClassesTabisPresent() throws Exception {
		boolean res = false;
		List<WebElement> tli = null;
		tli = getDriver().findElements(By.xpath("//ul[@class='x-tab-strip x-tab-strip-top']"));
		for (int i =1; i<=tli.size(); i++) {
			String cls = findElement(getDriver(), By.xpath("//ul[@class='x-tab-strip x-tab-strip-top']/li["+i+"]")).getAttribute("class");
			if (cls.contains("x-tab-strip-active")){
				String txt = findElement(getDriver(), By.xpath("//ul[@class='x-tab-strip x-tab-strip-top']/li["+i+"]")).getText();
				if (txt.contains("File Classes by Computer")){
					res = true;
				} else {
					res = false;
				}
			}
		}
		return res;
	}
	
	
}
