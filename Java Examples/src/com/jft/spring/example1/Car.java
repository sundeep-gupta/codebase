package com.jft.spring.example1;

public class Car {
	public Car() {
		System.out.println("Created Car Object");
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	String type;
	
}
