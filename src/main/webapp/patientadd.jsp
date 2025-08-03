<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Patient - Hospital Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 600px;
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
            border-color: #4facfe;
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
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>➕ Add New Patient</h2>
            <p>Enter patient information to register in the system</p>
        </div>
        
        <!-- Display Messages -->
        <% 
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            com.model.Patient patient = (com.model.Patient) request.getAttribute("patient");
            
            if (successMessage != null) { 
        %>
            <div class="message success">
                <%= successMessage %>
            </div>
            <% if (patient != null) { %>
                <div class="patient-details">
                    <h4>Patient Details Added:</h4>
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
        
        <!-- Patient Form -->
        <form action="AddPatientServlet" method="post">
            <div class="form-group">
                <label for="patientID">Patient ID *</label>
                <input type="number" id="patientID" name="patientID" required min="1" 
                       placeholder="Enter unique patient ID">
            </div>
            
            <div class="form-group">
                <label for="patientName">Patient Name *</label>
                <input type="text" id="patientName" name="patientName" required 
                       placeholder="Enter patient's full name">
            </div>
            
            <div class="form-group">
                <label for="age">Age *</label>
                <input type="number" id="age" name="age" required min="1" max="120" 
                       placeholder="Enter patient's age">
            </div>
            
            <div class="form-group">
                <label for="gender">Gender *</label>
                <select id="gender" name="gender" required>
                    <option value="">Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="admissionDate">Admission Date *</label>
                <input type="date" id="admissionDate" name="admissionDate" required>
            </div>
            
            <div class="form-group">
                <label for="ailment">Ailment/Condition *</label>
                <textarea id="ailment" name="ailment" required 
                          placeholder="Describe the patient's medical condition or ailment"></textarea>
            </div>
            
            <div class="form-group">
                <label for="assignedDoctor">Assigned Doctor *</label>
                <input type="text" id="assignedDoctor" name="assignedDoctor" required 
                       placeholder="Enter doctor's name">
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Add Patient</button>
                <button type="reset" class="btn btn-secondary">Clear Form</button>
                <a href="index.jsp" class="btn btn-secondary">Back to Menu</a>
            </div>
        </form>
    </div>
    
    <script>
        // Set today's date as default for admission date
        document.getElementById('admissionDate').value = new Date().toISOString().split('T')[0];
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            var patientID = document.getElementById('patientID').value;
            var patientName = document.getElementById('patientName').value.trim();
            var age = document.getElementById('age').value;
            var gender = document.getElementById('gender').value;
            var admissionDate = document.getElementById('admissionDate').value;
            var ailment = document.getElementById('ailment').value.trim();
            var assignedDoctor = document.getElementById('assignedDoctor').value.trim();
            
            if (!patientID || !patientName || !age || !gender || !admissionDate || !ailment || !assignedDoctor) {
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
        });
    </script>
</body>
</html>