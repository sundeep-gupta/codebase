package com.ironmountain.pageobject.pageobjectrunner.utils.testng;

import java.lang.reflect.Method;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.log4j.Logger;
import org.testng.IMethodInstance;
import org.testng.IMethodInterceptor;
import org.testng.ITestContext;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;


public class ExecutionInterceptor implements IMethodInterceptor {

	private static Logger logger = Logger
			.getLogger("com.imd.connected.webuitest.utils.testng.ExecutionInterceptor");

	public List<IMethodInstance> intercept(List<IMethodInstance> methods,
			ITestContext context) {
		Collections.sort(methods, new Prioritizer());
		return methods;
	}

	private int getExecutionPriority(IMethodInstance mi) {
		/*
		 * If no priority set then it should take as low priority
		 */
		int priority = 100;
		Method method = mi.getMethod().getMethod();
		logger.debug("Method for prioritization is: " + method);
		Class<?> cls = method.getDeclaringClass();
		SeleniumUITest classPriority = cls.getAnnotation(SeleniumUITest.class);
		if (classPriority != null) {
			priority = classPriority.priority();
		}
		logger.debug("Method level Priority is: " + priority);
		return priority;
	}
	
	class Prioritizer implements Comparator<IMethodInstance>{

		@Override
		public int compare(IMethodInstance m1, IMethodInstance m2) {
			return getExecutionPriority(m1) - getExecutionPriority(m2);
		}
		
	}


}
