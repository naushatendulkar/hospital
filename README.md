# 🏥 Hospital Management System

A basic web-based **Hospital Management System** built using **Java**, **JSP**, and **Servlets**, following the MVC architecture.

## 📌 Description

This application helps in managing patient records, including adding, updating, displaying, deleting patients, and generating reports. It demonstrates good separation of concerns using the **Model-View-Controller (MVC)** pattern.

---

## 📁 Project Structure

src/main/java/com/
├── controller/
│ └── GenerateReportController.java # Handles report generation
├── dao/
│ └── HospitalDAO.java # Database access object for patients
├── model/
│ └── Patient.java # Patient entity class
├── servlet/
│ ├── AddPatientServlet.java # Add new patient
│ ├── DeletePatientServlet.java # Delete existing patient
│ ├── DisplayPatientsServlet.java # Display patient list
│ ├── ReportServlet.java # Generate report
│ ├── UpdatePatientServlet.java # Update patient info

---

## 🌐 JSP Pages

Ensure the following JSP pages are placed in your `WebContent/` or `webapp/` folder:

- `index.jsp` – Homepage
- `patientadd.jsp` – Form to add new patients
- `patientdisplay.jsp` – View list of patients
- `report_result.jsp` – Display generated report
- `home.jsp` – Navigation page
- `patientedit.jsp` – (optional) Edit form

---

## 🛠️ Tech Stack

- Java
- JSP
- Servlets
- Eclipse IDE
- Apache Tomcat (for deployment)

---

## ▶️ How to Run

## ▶️ How to Run the Project

### 1. Import into Eclipse

- Go to `File` → `Import` → `Existing Projects into Workspace`
- Browse and select the root directory of the project (where `.project` file is located)
- Click **Finish**

### 2. Configure Apache Tomcat

- Ensure Apache Tomcat is installed and configured in Eclipse
- Right-click on the project → `Run As` → `Run on Server`
- Select **Tomcat** and click **Finish**

### 3. Access the Application

Open your browser and go to:

http://localhost:8080/hospital/

---

## ✍️ Author

**Nausha Tendulkar**  
GitHub: [@naushatendulkar](https://github.com/naushatendulkar)

---

> 📌 **Tip:**  
Make sure to configure your **database connection** inside `HospitalDAO.java` if you're using a database like **MySQL**.

---



