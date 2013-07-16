package com.ironmountain.pageobject.pageobjectrunner.utils.testng.reporting;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.ibm.staf.STAFException;
import com.ironmountain.digital.qa.automation.connected.qaStaf.qaSTAFFileService;
import com.ironmountain.digital.qa.automation.connected.qaStaf.qaSTAFPing;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

/*
 * @author pjames
 */
public class TestResultsFile {
	
	String QCmachine = PropertyPool.getProperty("qcmachine");//The machine where ARID tool runs to report results into QC
	//String sandBox = PropertyPool.getProperty("sandbox");
	String sandBox = FileUtils.getBaseDirectory();
	private String product = PropertyPool.getProperty("productname");
	private String version = PropertyPool.getProperty("productversion");
	private List<SetTestProperties> entries = new ArrayList<SetTestProperties>();
	/**
	 * Logger object.
	 */
	final private Logger logger					= Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.utils.testng.reporting.TestResultsFile");

	/**
	 * @param product
	 *            The product name. Should be consistent across tests
	 * @param version
	 *            The product version
	 */
	public TestResultsFile(String product, String version) {
		setProduct(product);
		setVersion(version);
	}

	/**
	 * Add a test result to the list in this collection
	 * 
	 * @param test
	 *            A full TestResultsFileTest object
	 * 
	 */
	public void addTest(SetTestProperties test) {
		entries.add(test);
	}

	/**
	 * Create a pre-initialized TestResultsFileTest.  Sets up the
	 * testpath, testset, test runname, testname and defaults the
	 * status to "NOTRUN" (skipped)
	 * @param testName
	 * @return the preinitialized TestResultsFileTest
	 */
	public SetTestProperties testFactory(String testName,String suiteName) {
		SetTestProperties t = new SetTestProperties();
		// Use product and product version and testname to
		// look up HPQC (or other) testpath, testset and
		// run(time)name
		t.setTestPath(this.lookUpTestPath(this.getProduct(), this.getVersion(), suiteName));
		t.setTestSet(this.lookUpTestSet(this.getProduct(), this.getVersion(), suiteName));
		// Pre-sets run name, but run name can be assigned at any time later
		t.setRunName(this.lookUpRunName(this.getProduct(), this.getVersion(), testName));
		testName = testName.replace(" ", "_");
		t.setTestName(testName);
		t.setStatus("NOTRUN");
		return t;
	}

	/**
	 * The runname held in the Test Case Management tool (HPQC) is a unique name
	 * for each run of the same test.  The lookup comes from a possible future convention
	 * of relating the product and version information to the generated run name.
	 * @param product
	 * @param version
	 * @param testName
	 * @return a new, unique run name.
	 */
	private String lookUpRunName(String product, String version, String testName) {
		SimpleDateFormat sdf = new SimpleDateFormat();
		String path = "" + testName.replace(" ", "_")+" "
						+ sdf.format(new Date()).replace(" ", "_").replace(":", "_");
		return path;
	}

	/**
	 * Look up a test path is used to create the TCM (HPQC) test path name from the
	 * product, version and test name.  May be changed in future to actually use
	 * this information to look up a the correct path for this test and product in
	 * a database.
	 * @param product
	 * @param version
	 * @param testName
	 * @return the HPQC test path for this test
	 */
	private String lookUpTestPath(String product, String version, String testName) {
		String path = "" + product.replace(" ", " ") + "\\" + version.replace(" ", " ") + "\\"
						+ testName.replace(" ", " ");
		return path;
	}

	/**
	 * Look up a test set is used to create the TCM (HPQC) test set name from the
	 * product, version and test name.  May be changed in future to actually use
	 * this information to look up a the correct set for this test and product in
	 * a database.
	 * @param product
	 * @param version
	 * @param testName
	 * @return the HPC test set for this test
	 */
	private String lookUpTestSet(String product, String version, String suiteName) {
		//String set = "" + product.replace(" ", "_") + "_" + version.replace(" ", "_") + "_"
		//				+ testName.replace(" ", "_");
		String set = suiteName.replace(" ","_");
	    return set;
	}

	/**
	 * @param product
	 */
	public void setProduct(String product) {
		this.product = product;
	}

	/**
	 * @return product
	 */
	public String getProduct() {
		return product;
	}

	/**
	 * @param version
	 */
	public void setVersion(String version) {
		this.version = version;
	}

	/**
	 * @return version
	 */
	public String getVersion() {
		return version;
	}
	
	
	/**
	 * @param QCmachine
	 */
	public void setQCmachine(String QCmachine) {
		this.QCmachine = QCmachine;
	}

	/**
	 * @return QCmachine
	 */
	public String getQCmachine() {
		return QCmachine;
	}
	
	/**
	 * @param QCmachine
	 */
	public void setsandBox(String sandBox) {
		this.sandBox = sandBox;
	}

	/**
	 * @return QCmachine
	 */
	public String getsandBox() {
		return sandBox;
	}
	

	public void copy(String outputFile) 
	{		
		final String destFile =sandBox+outputFile;
		logger.debug("About to copy the testresultsfile to QC Machine");
		try{
		final qaSTAFPing qaSTAFPingService = new qaSTAFPing();
		final boolean isServerPingable = qaSTAFPingService.ping(QCmachine);
		logger.info("Server Pingable =" + isServerPingable);
		if (!(isServerPingable)) {
			final String uniqueMessage = "FAIL: copy()- Server is not pingable.Please verify if the machine:  "+QCmachine+ ": is running and STAF is running :";
			logger.error(uniqueMessage);
			System.exit(1);
		}
		qaSTAFFileService srv = new qaSTAFFileService("FS");
		String srcfile = new File(outputFile).getAbsolutePath();
		srv.copyFile("localhost", srcfile, QCmachine,destFile);
		}catch (final STAFException e) {		
			logger.error(e.getMessage());
		}				
	}
}
