<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Patient - Hospital Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #d32f2f;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .btn {
            padding: 12px 25px;
            margin: 10px 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-search {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-danger {
            background-color: #d32f2f;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.8;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        
        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .alert-info {
            background-color: #cce7ff;
            border: 1px solid #b8daff;
            color: #0c5460;
        }
        
        .patient-details {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid #dee2e6;
        }
        
        .patient-details h3 {
            color: #d32f2f;
            margin-top: 0;
        }
        
        .detail-row {
            margin-bottom: 10px;
        }
        
        .detail-label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }
        
        .navigation {
            text-align: center;
            margin-top: 30px;
        }
        
        .warning-box {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🗑️ Delete Patient Record</h1>
        
        <!-- Success Message -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <strong>Success!</strong> <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <strong>Error!</strong> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <!-- Search Form -->
        <% if (request.getAttribute("found") == null || !(Boolean)request.getAttribute("found")) { %>
            <form method="post" action="DeletePatientServlet">
                <input type="hidden" name="action" value="search">
                
                <div class="form-group">
                    <label for="patientID">Enter Patient ID to Delete:</label>
                    <input type="number" id="patientID" name="patientID" required 
                           placeholder="Enter Patient ID">
                </div>
                
                <button type="submit" class="btn btn-search">🔍 Find Patient</button>
            </form>
        <% } %>
        
        <!-- Patient Details and Delete Confirmation -->
        <% 
        Boolean found = (Boolean) request.getAttribute("found");
        if (found != null && found) {
            Patient patient = (Patient) request.getAttribute("patient");
        %>
            <div class="patient-details">
                <h3>⚠️ Patient Details - Confirm Deletion</h3>
                
                <div class="detail-row">
                    <span class="detail-label">Patient ID:</span>
                    <%= patient.getPatientID() %>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Name:</span>
                    <%= patient.getPatientName() %>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Age:</span>
                    <%= patient.getAge() %> years
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Gender:</span>
                    <%= patient.getGender() %>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Admission Date:</span>
                    <%= patient.getAdmissionDate() %>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Ailment:</span>
                    <%= patient.getAilment() %>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Assigned Doctor:</span>
                    <%= patient.getAssignedDoctor() %>
                </div>
            </div>
            
            <div class="warning-box">
                <strong>⚠️ Warning:</strong> This action cannot be undone. The patient record will be permanently deleted from the system.
            </div>
            
            <form method="post" action="DeletePatientServlet" style="display: inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="patientID" value="<%= patient.getPatientID() %>">
                <button type="submit" class="btn btn-danger" 
                        onclick="return confirm('Are you sure you want to delete this patient record? This action cannot be undone.')">
                    🗑️ Delete Patient
                </button>
            </form>
            
            <a href="patientdelete.jsp" class="btn btn-secondary">🔍 Search Another Patient</a>
        <% } %>
        
        <div class="navigation">
            <a href="index.jsp" class="btn btn-secondary">🏠 Back to Home</a>
            <a href="patientdisplay.jsp" class="btn btn-secondary">👥 View All Patients</a>
        </div>
    </div>
</body>
</html>
