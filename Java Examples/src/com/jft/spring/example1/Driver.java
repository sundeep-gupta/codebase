package com.jft.spring.example1;
import com.jft.spring.example1.Car;
public class Driver {
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	Car car;
	public Driver() {
		System.out.println("Driver object created");
	}
}
