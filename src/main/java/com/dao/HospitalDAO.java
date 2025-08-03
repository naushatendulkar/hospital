package com.dao;

import java.sql.*;
import com.model.Patient;
import java.util.List;
import java.util.ArrayList;
public class HospitalDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/hospital_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    
    // Get database connection
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Attempting to connect to database..."); // Debug log
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Database connection successful!"); // Debug log
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
            throw new SQLException("Database driver not found", e);
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            System.err.println("URL: " + URL);
            System.err.println("Username: " + USERNAME);
            throw e;
        }
    }
    
    // Add new patient
    public boolean addPatient(Patient patient) {
        String sql = "INSERT INTO Patients (PatientID, PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, patient.getPatientID());
            pstmt.setString(2, patient.getPatientName());
            pstmt.setInt(3, patient.getAge());
            pstmt.setString(4, patient.getGender());
            pstmt.setDate(5, patient.getAdmissionDate());
            pstmt.setString(6, patient.getAilment());
            pstmt.setString(7, patient.getAssignedDoctor());
            
            int result = pstmt.executeUpdate();
            System.out.println("Insert result: " + result); // Debug log
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("SQL Error in addPatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("General Error in addPatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if patient ID already exists
    public boolean patientExists(int patientID) {
        String sql = "SELECT COUNT(*) FROM Patients WHERE PatientID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, patientID);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get patient by ID
    public Patient getPatientById(int patientID) {
        String sql = "SELECT * FROM Patients WHERE PatientID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, patientID);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setPatientName(rs.getString("PatientName"));
                patient.setAge(rs.getInt("Age"));
                patient.setGender(rs.getString("Gender"));
                patient.setAdmissionDate(rs.getDate("AdmissionDate"));
                patient.setAilment(rs.getString("Ailment"));
                patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
                return patient;
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error in getPatientById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Update patient information
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE Patients SET PatientName=?, Age=?, Gender=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, patient.getPatientName());
            pstmt.setInt(2, patient.getAge());
            pstmt.setString(3, patient.getGender());
            pstmt.setDate(4, patient.getAdmissionDate());
            pstmt.setString(5, patient.getAilment());
            pstmt.setString(6, patient.getAssignedDoctor());
            pstmt.setInt(7, patient.getPatientID());
            
            int result = pstmt.executeUpdate();
            System.out.println("Update result: " + result); // Debug log
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("SQL Error in updatePatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("General Error in updatePatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public boolean deletePatient(int patientID) {
        String sql = "DELETE FROM Patients WHERE PatientID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, patientID);
            
            int result = pstmt.executeUpdate();
            System.out.println("Delete result: " + result); // Debug log
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("SQL Error in deletePatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("General Error in deletePatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients ORDER BY PatientID";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setPatientName(rs.getString("PatientName"));
                patient.setAge(rs.getInt("Age"));
                patient.setGender(rs.getString("Gender"));
                patient.setAdmissionDate(rs.getDate("AdmissionDate"));
                patient.setAilment(rs.getString("Ailment"));
                patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
                patients.add(patient);
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error in getAllPatients: " + e.getMessage());
            e.printStackTrace();
        }
        return patients;
    }
    
    // Get patients by date range
    public List<Patient> getPatientsByDateRange(Date startDate, Date endDate) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE AdmissionDate >= ? AND AdmissionDate <= ? ORDER BY AdmissionDate";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setPatientName(rs.getString("PatientName"));
                patient.setAge(rs.getInt("Age"));
                patient.setGender(rs.getString("Gender"));
                patient.setAdmissionDate(rs.getDate("AdmissionDate"));
                patient.setAilment(rs.getString("Ailment"));
                patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
                patients.add(patient);
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error in getPatientsByDateRange: " + e.getMessage());
            e.printStackTrace();
        }
        return patients;
    }
    
    // Get patients by ailment
    public List<Patient> getPatientsByAilment(String ailment) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE Ailment LIKE ? ORDER BY PatientName";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + ailment + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setPatientName(rs.getString("PatientName"));
                patient.setAge(rs.getInt("Age"));
                patient.setGender(rs.getString("Gender"));
                patient.setAdmissionDate(rs.getDate("AdmissionDate"));
                patient.setAilment(rs.getString("Ailment"));
                patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
                patients.add(patient);
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error in getPatientsByAilment: " + e.getMessage());
            e.printStackTrace();
        }
        return patients;
    }
    
    // Get patients by doctor
    public List<Patient> getPatientsByDoctor(String doctor) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE AssignedDoctor LIKE ? ORDER BY PatientName";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + doctor + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setPatientName(rs.getString("PatientName"));
                patient.setAge(rs.getInt("Age"));
                patient.setGender(rs.getString("Gender"));
                patient.setAdmissionDate(rs.getDate("AdmissionDate"));
                patient.setAilment(rs.getString("Ailment"));
                patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
                patients.add(patient);
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error in getPatientsByDoctor: " + e.getMessage());
            e.printStackTrace();
        }
        return patients;
    }

}