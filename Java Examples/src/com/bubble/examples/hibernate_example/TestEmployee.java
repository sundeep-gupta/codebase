package com.hibernate_example;

import org.hibernate.cfg.Configuration;
import org.hibernate.tool.hbm2ddl.SchemaExport;

public class TestEmployee {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Configuration config = new Configuration();
		config.addAnnotatedClass(Employee.class);
		// reads the hibernate.cfg.xml and configure (understands)
		config.configure("hibernate.cfg.xml");
		// first true - print to the log file
		// second true - means print in database (run the queries)
		new SchemaExport(config).create(true, true);
	}

}
