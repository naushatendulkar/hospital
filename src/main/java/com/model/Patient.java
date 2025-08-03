package com.model;



	import java.sql.Date;

	public class Patient {
	    private int patientID;
	    private String patientName;
	    private int age;
	    private String gender;
	    private Date admissionDate;
	    private String ailment;
	    private String assignedDoctor;
	    
	    // Default constructor
	    public Patient() {}
	    
	    // Parameterized constructor
	    public Patient(int patientID, String patientName, int age, String gender, 
	                  Date admissionDate, String ailment, String assignedDoctor) {
	        this.patientID = patientID;
	        this.patientName = patientName;
	        this.age = age;
	        this.gender = gender;
	        this.admissionDate = admissionDate;
	        this.ailment = ailment;
	        this.assignedDoctor = assignedDoctor;
	    }
	    
	    // Getters and Setters
	    public int getPatientID() {
	        return patientID;
	    }
	    
	    public void setPatientID(int patientID) {
	        this.patientID = patientID;
	    }
	    
	    public String getPatientName() {
	        return patientName;
	    }
	    
	    public void setPatientName(String patientName) {
	        this.patientName = patientName;
	    }
	    
	    public int getAge() {
	        return age;
	    }
	    
	    public void setAge(int age) {
	        this.age = age;
	    }
	    
	    public String getGender() {
	        return gender;
	    }
	    
	    public void setGender(String gender) {
	        this.gender = gender;
	    }
	    
	    public Date getAdmissionDate() {
	        return admissionDate;
	    }
	    
	    public void setAdmissionDate(Date admissionDate) {
	        this.admissionDate = admissionDate;
	    }
	    
	    public String getAilment() {
	        return ailment;
	    }
	    
	    public void setAilment(String ailment) {
	        this.ailment = ailment;
	    }
	    
	    public String getAssignedDoctor() {
	        return assignedDoctor;
	    }
	    
	    public void setAssignedDoctor(String assignedDoctor) {
	        this.assignedDoctor = assignedDoctor;
	    }
	    
	    @Override
	    public String toString() {
	        return "Patient{" +
	                "patientID=" + patientID +
	                ", patientName='" + patientName + '\'' +
	                ", age=" + age +
	                ", gender='" + gender + '\'' +
	                ", admissionDate=" + admissionDate +
	                ", ailment='" + ailment + '\'' +
	                ", assignedDoctor='" + assignedDoctor + '\'' +
	                '}';
	    }
	}

