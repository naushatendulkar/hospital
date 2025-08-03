<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results - Hospital Management</title>
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
            color: #28a745;
            text-align: center;
            margin-bottom: 10px;
        }

        .report-title {
            color: #666;
            text-align: center;
            margin-bottom: 30px;
            font-size: 18px;
        }

        .stats {
            background-color: #d4edda;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
            color: #155724;
            border: 1px solid #c3e6cb;
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
            background-color: #28a745;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f5f5f5;
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

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-primary {
            background-color: #007bff;
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

        .print-btn {
            float: right;
            margin-bottom: 20px;
        }

        @media print {
            .navigation, .print-btn {
                display: none;
            }
        }
    </style>
    <script>
        function printReport() {
            window.print();
        }
    </script>
</head>
<body>
    <div class="container">
        <button onclick="printReport()" class="btn btn-primary print-btn">🖨️ Print Report</button>

        <h1>📊 <%= request.getAttribute("reportType") %></h1>
        <div class="report-title"><%= request.getAttribute("reportTitle") %></div>

        <%
        List<Patient> patients = (List<Patient>) request.getAttribute("patients");
        Integer totalCount = (Integer) request.getAttribute("totalCount");

        if (patients != null && !patients.isEmpty()) {
        %>
            <!-- Statistics -->
            <div class="stats">
                📊 Found <%= totalCount %> patient(s) matching your criteria
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
                    } // End of for loop
                    %>
                </tbody>
            </table>
        <%
        } else {
        %>
            <!-- No Data Found -->
            <div class="no-data">
                ⚠️ No patient data found for the selected report criteria.
            </div>
        <%
        }
        %>

        <!-- Navigation Buttons -->
        <div class="navigation">
            <a href="reports.jsp" class="btn btn-secondary">⬅️ Back to Report Selection</a>
            <a href="index.jsp" class="btn btn-success">🏠 Go to Dashboard</a>
        </div>
    </div>
</body>
</html>
