package com.ironmountain.pageobject.pageobjectrunner.utils.testng.reporting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;


import org.apache.log4j.Logger;
import org.testng.IReporter;
import org.testng.ISuite;
import org.testng.ISuiteResult;
import org.testng.ITestContext;
import org.testng.ITestResult;
import org.testng.xml.XmlSuite;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;


/**
 * @author pjames
 *
 */
public class IRMReporter implements IReporter{
	private static final Logger logger = Logger.getLogger(IRMReporter.class.getName());
	static boolean reportResults=false;

	private static HashMap<String, String> elementPool = new HashMap<String, String>();
	private static String PRODUCT_NAME = PropertyPool.getProperty("productname");
	private static String PRODUCT_VERSION = PropertyPool.getProperty("productversion");
	

	public void  generateReport(List<XmlSuite> xmlSuites, List<ISuite> suites, String output) {

		for (int i = 0; i < xmlSuites.size(); i++) {
			XmlSuite xmlSuite = xmlSuites.get(i);
			ISuite suite = suites.get(i);
			String suiteName = xmlSuite.getName();
			String outputFile = xmlSuite.getParameter("outputfile");
			PRODUCT_NAME = PRODUCT_NAME == null ? "ProductName parameter missing" : PRODUCT_NAME;
			PRODUCT_VERSION = PRODUCT_VERSION == null ? "ProductVersion parameter missing" : PRODUCT_VERSION;
			outputFile = outputFile == null ? "TestResults_" + suiteName.replace(" ", "_") + ".xml" : outputFile;
			TestResultsFile trf = new TestResultsFile(PRODUCT_NAME, PRODUCT_VERSION);
			XMLForHPQC.createSampleXml(outputFile);
			for (ISuiteResult result : suite.getResults().values()) {
				ITestContext tc = result.getTestContext();
				String testName = tc.getName();
				logger.debug("Test: " + testName);
				Set<ITestResult> passedTests = tc.getPassedTests().getAllResults();
				Set<ITestResult> failedTests = tc.getFailedTests().getAllResults();
				Set<ITestResult> skippedTests = tc.getSkippedTests().getAllResults();
				for (ITestResult r : passedTests) {
					SetTestProperties t = trf.testFactory(testName,suiteName);
					updateElementPool("PASSED", t, r, elementPool);
					XMLForHPQC.updateElementPool(outputFile, elementPool);
				}
				for (ITestResult r : failedTests) {
					SetTestProperties t = trf.testFactory(testName,suiteName);
					updateElementPool("FAILED", t, r, elementPool);
					XMLForHPQC.updateElementPool(outputFile, elementPool);
				}
				for (ITestResult r : skippedTests) {
					logger.debug("Skipped Test: " + testName);
					SetTestProperties t = trf.testFactory(testName,suiteName);
					updateElementPool("SKIPPED", t, r, elementPool);
					XMLForHPQC.updateElementPool(outputFile, elementPool);
				}
				setReportResults(true);

				if(reportResults){
					System.out.println(outputFile);
					//trf.copy(outputFile);
				}
			}
		}
	}

	private ITestResult setTestResultInfo(String status, SetTestProperties t, ITestResult r) {
		t.setStatus(status);
		t.setStartTime(r.getStartMillis());
		t.setStopTime(r.getEndMillis());
		t.setHost(t.getHost());
		Object[] params = r.getParameters();
		if (params.length > 0) {
			String parameterLine = "\n\tTestNG parameters:\n";
			for (Object s : params) {
				parameterLine = parameterLine + "\t" + s.toString() + "\n";
			}
			t.setResultDetail(parameterLine);
		}

		return r;
	}


	public static void setReportResults(boolean b){
		reportResults=b;
	}

	public  Map<String, String> updateElementPool(String Status, SetTestProperties t, ITestResult r, Map<String, String> ep){
		setTestResultInfo(Status, t, r);
		ep.put("host", t.getHost());
		ep.put("testpath", t.getTestPath());
		ep.put("testname", t.getTestName());
		ep.put("testset",  t.getTestSet());
		ep.put("runname", t.getRunName());
		ep.put("status", t.getStatus());
		ep.put("starttime", t.getStartTime());
		ep.put("stoptime", t.getStopTime());
		ep.put("platform", t.getOSname());
		ep.put("osversion", t.getOSversion());
		ep.put("resultdetail", t.getResultDetail());
		return ep;
	}

}


