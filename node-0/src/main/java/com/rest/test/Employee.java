package com.rest.test;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Employee { 
 private String name = ""; 
 private int age = 0; 
 private String department = ""; 
 private Address address = null; 
 private double wage = 0;
 
 public String getName() {
  return name;
 }
 public void setName(String name) {
  this.name = name;
 }
 public int getAge() {
  return age;
 }
 public void setAge(int age) {
  this.age = age;
 }
 public String getDepartment() {
  return department;
 }
 public void setDeparment(String department) {
  this.department = department;
 }
 public Address getAddress() {
  return address;
 }
 public void setAddress(Address address) {
  this.address = address;
 } 
 public double getWage() {
  return wage;
 }
 public void setWage(double wage) {
  this.wage = wage;
 }
 @Override
 public String toString() {
  return "Employee [name=" + name + ", age=" + age + ", department="
    + department + ", address=" + address + ", wage=" + wage
    + "]";
 } 
}
