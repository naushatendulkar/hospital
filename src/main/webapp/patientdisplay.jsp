<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Patients - Hospital Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2196F3;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .stats {
            background-color: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
            color: #1976d2;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        
        th {
            background-color: #2196F3;
            color: white;
            font-weight: bold;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        
        .alert-info {
            background-color: #cce7ff;
            border: 1px solid #b8daff;
            color: #0c5460;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
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
        
        .btn-primary {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.8;
        }
        
        .navigation {
            text-align: center;
            margin-top: 30px;
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 18px;
        }
        
        .actions {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👥 All Patients</h1>
        
        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <strong>Error!</strong> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <!-- Info Message -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-info">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <!-- Actions -->
        <div class="actions">
            <a href="DisplayPatientsServlet" class="btn btn-primary">🔄 Refresh Data</a>
            <a href="reports.jsp" class="btn btn-success">📊 Generate Reports</a>
        </div>
        
        <%
        List<Patient> patients = (List<Patient>) request.getAttribute("patients");
        Integer totalPatients = (Integer) request.getAttribute("totalPatients");
        
        if (patients != null && !patients.isEmpty()) {
        %>
            <!-- Statistics -->
            <div class="stats">
                📊 Total Patients: <%= totalPatients %> patients found in the database
            </div>
            
            <!-- Patients Table -->
            <table>
                <thead>
                    <tr>
                        <th>Patient ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Admission Date</th>
                        <th>Ailment</th>
                        <th>Assigned Doctor</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for (Patient patient : patients) {
                    %>
                        <tr>
                            <td><%= patient.getPatientID() %></td>
                            <td><%= patient.getPatientName() %></td>
                            <td><%= patient.getAge() %></td>
                            <td><%= patient.getGender() %></td>
                            <td><%= patient.getAdmissionDate() %></td>
                            <td><%= patient.getAilment() %></td>
                            <td><%= patient.getAssignedDoctor() %></td>
                        </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        <%
        } else if (totalPatients != null && totalPatients == 0) {
        %>
            <div class="no-data">
                📋 No patients found in the database.<br>
                <a href="patientadd.jsp" class="btn btn-primary">➕ Add First Patient</a>
            </div>
        <%
        }
        %>
        
        <div class="navigation">
            <a href="index.jsp" class="btn btn-secondary">🏠 Back to Home</a>
            <a href="patientadd.jsp" class="btn btn-primary">➕ Add Patient</a>
            <a href="reports.jsp" class="btn btn-success">📊 View Reports</a>
        </div>
    </div>
</body>
</html>