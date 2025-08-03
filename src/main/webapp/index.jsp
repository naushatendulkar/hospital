<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hospital Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            padding: 40px;
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        .header h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        .header p {
            color: #666;
            font-size: 1.1em;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .menu-item {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            border-radius: 8px;
            padding: 30px 20px;
            text-align: center;
            text-decoration: none;
            color: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            text-decoration: none;
            color: white;
        }
        .menu-item h3 {
            margin: 0 0 10px 0;
            font-size: 1.3em;
        }
        .menu-item p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.9em;
        }
        .add-patient { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        .update-patient { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
        .delete-patient { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }
        .display-patient { background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%); }
        .reports { background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%); }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏥 Hospital Management System</h1>
            <p>Comprehensive Patient Care Management</p>
        </div>
        
        <div class="menu-grid">
            <a href="patientadd.jsp" class="menu-item add-patient">
                <h3>➕ Add Patient</h3>
                <p>Register new patients to the system</p>
            </a>
            
            <a href="patientupdate.jsp" class="menu-item update-patient">
                <h3>✏️ Update Patient</h3>
                <p>Modify existing patient information</p>
            </a>
            
            <a href="patientdelete.jsp" class="menu-item delete-patient">
                <h3>🗑️ Delete Patient</h3>
                <p>Remove patient records from system</p>
            </a>
            
            <a href="patientdisplay.jsp" class="menu-item display-patient">
                <h3>👥 View Patients</h3>
                <p>Display all patient information</p>
            </a>
            
            <a href="reports.jsp" class="menu-item reports">
                <h3>📊 Reports</h3>
                <p>Generate various patient reports</p>
            </a>
        </div>
    </div>
</body>
</html>