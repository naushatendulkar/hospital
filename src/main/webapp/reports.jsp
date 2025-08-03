<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hospital Reports - Hospital Management</title>
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
            color: #28a745;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .report-section {
            background-color: #f8f9fa;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 8px;
            border-left: 4px solid #28a745;
        }
        
        .report-section h3 {
            color: #28a745;
            margin-top: 0;
            margin-bottom: 15px;
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
        
        input[type="text"],
        input[type="date"] {
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
        
        .btn-success {
            background-color: #28a745;
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
        
        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .navigation {
            text-align: center;
            margin-top: 30px;
        }
        
        .date-inputs {
            display: flex;
            gap: 15px;
        }
        
        .date-inputs .form-group {
            flex: 1;
        }
        
        .report-description {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Hospital Reports</h1>
        
        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <strong>Error!</strong> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <!-- Date Range Report -->
        <div class="report-section">
            <h3>📅 Patients by Date Range</h3>
            <p class="report-description">View all patients admitted between specific dates</p>
            
            <form method="post" action="ReportServlet">
                <input type="hidden" name="reportType" value="dateRange">
                
                <div class="date-inputs">
                    <div class="form-group">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-success">📊 Generate Date Range Report</button>
            </form>
        </div>
        
        <!-- Ailment Report -->
        <div class="report-section">
            <h3>🏥 Patients by Ailment</h3>
            <p class="report-description">Find all patients with a specific medical condition</p>
            
            <form method="post" action="ReportServlet">
                <input type="hidden" name="reportType" value="ailment">
                
                <div class="form-group">
                    <label for="ailment">Ailment/Condition:</label>
                    <input type="text" id="ailment" name="ailment" required 
                           placeholder="e.g., Fever, Diabetes, Hypertension">
                </div>
                
                <button type="submit" class="btn btn-success">📊 Generate Ailment Report</button>
            </form>
        </div>
        
        <!-- Doctor Report -->
        <div class="report-section">
            <h3>👨‍⚕️ Patients by Doctor</h3>
            <p class="report-description">View all patients assigned to a specific doctor</p>
            
            <form method="post" action="ReportServlet">
                <input type="hidden" name="reportType" value="doctor">
                
                <div class="form-group">
                    <label for="doctor">Doctor Name:</label>
                    <input type="text" id="doctor" name="doctor" required 
                           placeholder="e.g., Dr. Smith, Dr. Johnson">
                </div>
                
                <button type="submit" class="btn btn-success">📊 Generate Doctor Report</button>
            </form>
        </div>
        
        <div class="navigation">
            <a href="index.jsp" class="btn btn-secondary">🏠 Back to Home</a>
            <a href="patientdisplay.jsp" class="btn btn-secondary">👥 View All Patients</a>
        </div>
    </div>
</body>
</html>
