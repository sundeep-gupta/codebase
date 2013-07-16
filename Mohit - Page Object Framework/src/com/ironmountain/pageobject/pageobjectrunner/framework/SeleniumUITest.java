package com.ironmountain.pageobject.pageobjectrunner.framework;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface SeleniumUITest {
	
	/**
	 * This represents the class or method priority
	 * 
	 * @return
	 */
	int priority() default 100;
	String HPQCID() default "No ID Found";
	String[] defectIds() default "No Defects Associated";
	boolean skipAllTestsIfFail() default false;
	boolean resetSkipAllTestsIfFail() default false;	
}
