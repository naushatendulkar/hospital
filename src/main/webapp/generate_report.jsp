<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Report - Hospital Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            padding: 30px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #28a745;
            text-align: center;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }

        select, input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            margin-top: 30px;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .back {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
        }

        .back:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📑 Generate Patient Report</h2>
        <form action="GenerateReportController" method="post">
            <label for="reportType">Select Report Type:</label>
            <select name="reportType" id="reportType" required>
                <option value="">-- Select --</option>
                <option value="All Patients">All Patients</option>
                <option value="By Gender">Patients by Gender</option>
                <option value="By Doctor">Patients by Assigned Doctor</option>
                <option value="By Ailment">Patients by Ailment</option>
            </select>

            <input type="submit" value="Generate Report">
        </form>
        <a href="home.jsp" class="back">⬅️ Back to Dashboard</a>
    </div>
</body>
</html>
