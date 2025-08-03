<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Patients</title>
</head>
<body>
    <h2>All Patients</h2>

    <%
        List<Patient> patients = (List<Patient>) request.getAttribute("patients");
        if (patients != null && !patients.isEmpty()) {
    %>
        <table border="1" cellpadding="8">
            <tr>
                <th>Patient ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Admission Date</th>
                <th>Ailment</th>
                <th>Assigned Doctor</th>
            </tr>
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
        </table>
    <%
        } else {
    %>
        <p>No patients available.</p>
    <%
        }
    %>
</body>
</html>
