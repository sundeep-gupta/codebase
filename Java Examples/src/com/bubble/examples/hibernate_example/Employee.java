package com.hibernate_example;

import javax.persistence.Entity;
import javax.persistence.Id;
/*
 * Putting the annotation 'Entity' means telling the Hibernate
 * that we want to create the table 'Employee' if it does not already
 * exist in database
 */
@Entity
public class Employee {
	private int empId;
	private String empName;
	//  putting 'Id' annotation menas that empId will be primary key
	// Q... how to set combi of multiple fields as primary key
	@Id
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
}
