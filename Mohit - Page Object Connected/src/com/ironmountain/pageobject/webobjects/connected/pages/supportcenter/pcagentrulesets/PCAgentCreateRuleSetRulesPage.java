package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

public class PCAgentCreateRuleSetRulesPage extends PCAgentRuleSetsPage {

	public PCAgentCreateRuleSetRulesPage(Selenium sel) {
		selenium = sel;
	}

	public PCAgentCreateRuleSetGeneralPage clickOnFinishRuleSetsButton(){
		click("FinishBtn");
		waitForSeconds(3);
		return (PCAgentCreateRuleSetGeneralPage) PageFactory.getNewPage(PCAgentCreateRuleSetGeneralPage.class);
	}
	public PCAgentCreateRuleSetGeneralPage clickOnCancelButton(){
		click("CancelBtn");
		waitForSeconds(3);
		return (PCAgentCreateRuleSetGeneralPage) PageFactory.getNewPage(PCAgentCreateRuleSetGeneralPage.class);
	}
	public PCAgentCreateRuleSetGeneralPage clickOnBackButton(){
		click("CancelBtn");
		waitForSeconds(3);
		return (PCAgentCreateRuleSetGeneralPage) PageFactory.getNewPage(PCAgentCreateRuleSetGeneralPage.class);
	}
	
	public void setAgentRule(String agentRule){
				
		type("RulesBlob", agentRule);	
		type("RulesBlobModifed", "1");
		getEval("{this.browserbot.getCurrentWindow().document.TheForm.SetRulesToApplet();}");
		System.out.println(getText("RulesBlob"));
		System.out.println(getValue("RulesBlobModifed"));
		
//parent.AppBody.NodeView.NodeDetails.
		
		//String jScript = "{vare cells = document.getElementsByTagName('object'); for (var i = 0; i < cells.length; i++) { var id = cells[i].getAttribute('id'); if ( id == 'RulesApplet' ) { } } }" ;
		//System.out.println( "applet is : "+ getEval(jScript));

		//String js = "this.browserbot.getCurrentWindow().document.getElementsByName('" + agentRule + "')" ;
		String js = "this.browserbot.getCurrentWindow().document.getElementsByName('RulesApplet').setRules('" + agentRule + "')";
		//String js = "this.browserbot.getCurrentWindow().document.SetRulesToApplet()";

		System.out.println("Evaluation: "+ getEval(js));
		
//		System.out.println(getText("RulesBlob"));
//		String js1 = "document.getElementById(\"RulesApplet\");";
//		System.out.println("Evaluating Applet: ");
//		System.out.print(getEval(js1));
//		System.out.println("document.applets[\"RulesApplet\"].setRules(document.TheForm.RulesBlob.value);");
//		System.out.println(getEval("document.applets['RulesApplet'].setRules(document.TheForm.RulesBlob.value);"));
//		String srp = "<SCRIPT language=\"JavaScript\"> document.applets.RulesApplet.setRules(document.TheForm.RulesBlob.value)} </SCRIPT> ";
//		System.out.println(srp);
//		selenium.getEval(srp);
//		getEval("document.TheForm.RulesApplet.setRules(document.TheForm.RulesBlob.value);");
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
