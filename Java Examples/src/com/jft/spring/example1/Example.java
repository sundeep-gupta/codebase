package com.jft.spring.example1;

import java.util.logging.Logger;

import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;

public class Example {
	 static Logger logger = Logger.getLogger("Example.class");
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("Loading xml file");
		logger.warning("Test warning");
		XmlBeanFactory bf = new XmlBeanFactory(new ClassPathResource("springConfig.xml"));
		System.out.println("XML file loading completed.");
		Driver gs = (Driver) bf.getBean("driver");
		System.out.println(gs.getCar().getType());

	}

}
