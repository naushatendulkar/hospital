<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Patient - Hospital Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 700px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            padding: 40px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h2 {
            color: #333;
            margin-bottom: 10px;
        }
        .search-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border-left: 4px solid #28a745;
        }
        .search-section h3 {
            margin-top: 0;
            color: #28a745;
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
        input[type="text"], input[type="number"], input[type="date"], select, textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, input[type="number"]:focus, input[type="date"]:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #28a745;
        }
        .search-group {
            display: flex;
            gap: 10px;
            align-items: end;
        }
        .search-group .form-group {
            flex: 1;
            margin-bottom: 0;
        }
        select {
            cursor: pointer;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .btn-container {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            margin: 0 10px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }
        .btn-search {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .message {
            padding: 15px;
            margin: 20px 0;
            border-radius: 6px;
            text-align: center;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .patient-details {
            background-color: #e3f2fd;
            border: 1px solid #bbdefb;
            padding: 15px;
            border-radius: 6px;
            margin-top: 10px;
        }
        .patient-details h4 {
            margin-top: 0;
            color: #1976d2;
        }
        .update-form {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            border-left: 4px solid #28a745;
        }
        .update-form h3 {
            margin-top: 0;
            color: #28a745;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>✏️ Update Patient Information</h2>
            <p>Search for a patient and update their information</p>
        </div>
        
        <!-- Search Section -->
        <div class="search-section">
            <h3>🔍 Search Patient</h3>
            <form action="UpdatePatientServlet" method="get">
                <input type="hidden" name="action" value="search">
                <div class="search-group">
                    <div class="form-group">
                        <label for="searchPatientID">Patient ID</label>
                        <input type="number" id="searchPatientID" name="patientID" required 
                               placeholder="Enter Patient ID to search" min="1">
                    </div>
                    <button type="submit" class="btn btn-search">Search Patient</button>
                </div>
            </form>
        </div>
        
        <!-- Display Messages -->
        <% 
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            Patient patient = (Patient) request.getAttribute("patient");
            Boolean found = (Boolean) request.getAttribute("found");
            Boolean updated = (Boolean) request.getAttribute("updated");
            
            if (successMessage != null) { 
        %>
            <div class="message success">
                <%= successMessage %>
            </div>
            <% if (patient != null && updated != null && updated) { %>
                <div class="patient-details">
                    <h4>Updated Patient Details:</h4>
                    <p><strong>Patient ID:</strong> <%= patient.getPatientID() %></p>
                    <p><strong>Name:</strong> <%= patient.getPatientName() %></p>
                    <p><strong>Age:</strong> <%= patient.getAge() %> years</p>
                    <p><strong>Gender:</strong> <%= patient.getGender() %></p>
                    <p><strong>Admission Date:</strong> <%= patient.getAdmissionDate() %></p>
                    <p><strong>Ailment:</strong> <%= patient.getAilment() %></p>
                    <p><strong>Assigned Doctor:</strong> <%= patient.getAssignedDoctor() %></p>
                </div>
            <% } %>
        <% } %>
        
        <% if (errorMessage != null) { %>
            <div class="message error">
                <%= errorMessage %>
            </div>
        <% } %>
        
        <!-- Update Form - Show only if patient found -->
        <% if (patient != null && found != null && found) { %>
        <div class="update-form">
            <h3>📝 Update Patient Information</h3>
            <form action="UpdatePatientServlet" method="post">
                <div class="form-group">
                    <label for="patientID">Patient ID</label>
                    <input type="number" id="patientID" name="patientID" 
                           value="<%= patient.getPatientID() %>" readonly 
                           style="background-color: #e9ecef; cursor: not-allowed;">
                    <small style="color: #6c757d;">Patient ID cannot be changed</small>
                </div>
                
                <div class="form-group">
                    <label for="patientName">Patient Name *</label>
                    <input type="text" id="patientName" name="patientName" required 
                           value="<%= patient.getPatientName() %>" 
                           placeholder="Enter patient's full name">
                </div>
                
                <div class="form-group">
                    <label for="age">Age *</label>
                    <input type="number" id="age" name="age" required min="1" max="120" 
                           value="<%= patient.getAge() %>" 
                           placeholder="Enter patient's age">
                </div>
                
                <div class="form-group">
                    <label for="gender">Gender *</label>
                    <select id="gender" name="gender" required>
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equals(patient.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(patient.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(patient.getGender()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="admissionDate">Admission Date *</label>
                    <input type="date" id="admissionDate" name="admissionDate" required
                           value="<%= patient.getAdmissionDate() %>">
                </div>
                
                <div class="form-group">
                    <label for="ailment">Ailment/Condition *</label>
                    <textarea id="ailment" name="ailment" required 
                              placeholder="Describe the patient's medical condition or ailment"><%= patient.getAilment() %></textarea>
                </div>
                
                <div class="form-group">
                    <label for="assignedDoctor">Assigned Doctor *</label>
                    <input type="text" id="assignedDoctor" name="assignedDoctor" required 
                           value="<%= patient.getAssignedDoctor() %>" 
                           placeholder="Enter doctor's name">
                </div>
                
                <div class="btn-container">
                    <button type="submit" class="btn btn-primary">Update Patient</button>
                    <button type="reset" class="btn btn-secondary">Reset Changes</button>
                </div>
            </form>
        </div>
        <% } %>
        
        <div class="btn-container" style="margin-top: 30px;">
            <a href="index.jsp" class="btn btn-secondary">Back to Main Menu</a>
        </div>
    </div>
    
    <script>
        // Form validation
        document.querySelector('form[method="post"]')?.addEventListener('submit', function(e) {
            var patientName = document.getElementById('patientName').value.trim();
            var age = document.getElementById('age').value;
            var gender = document.getElementById('gender').value;
            var admissionDate = document.getElementById('admissionDate').value;
            var ailment = document.getElementById('ailment').value.trim();
            var assignedDoctor = document.getElementById('assignedDoctor').value.trim();
            
            if (!patientName || !age || !gender || !admissionDate || !ailment || !assignedDoctor) {
                alert('Please fill in all required fields.');
                e.preventDefault();
                return false;
            }
            
            if (age < 1 || age > 120) {
                alert('Please enter a valid age between 1 and 120.');
                e.preventDefault();
                return false;
            }
            
            if (patientName.length < 2) {
                alert('Patient name must be at least 2 characters long.');
                e.preventDefault();
                return false;
            }
            
            if (confirm('Are you sure you want to update this patient\'s information?')) {
                return true;
            } else {
                e.preventDefault();
                return false;
            }
        });
        
        // Auto-focus search field
        document.getElementById('searchPatientID').focus();
    </script>
</body>
</html>