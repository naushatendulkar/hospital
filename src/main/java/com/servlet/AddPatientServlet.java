package com.servlet;



	import java.io.IOException;
	import java.sql.Date;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;

	import com.dao.HospitalDAO;
	import com.model.Patient;

	@WebServlet("/AddPatientServlet")
	public class AddPatientServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    private HospitalDAO hospitalDAO;
	    
	    public void init() {
	        hospitalDAO = new HospitalDAO();
	    }
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        
	        try {
	            // Get form parameters
	            int patientID = Integer.parseInt(request.getParameter("patientID"));
	            String patientName = request.getParameter("patientName");
	            int age = Integer.parseInt(request.getParameter("age"));
	            String gender = request.getParameter("gender");
	            Date admissionDate = Date.valueOf(request.getParameter("admissionDate"));
	            String ailment = request.getParameter("ailment");
	            String assignedDoctor = request.getParameter("assignedDoctor");
	            
	            // Check if patient ID already exists
	            if (hospitalDAO.patientExists(patientID)) {
	                request.setAttribute("errorMessage", "Patient ID " + patientID + " already exists. Please use a different ID.");
	                request.getRequestDispatcher("patientadd.jsp").forward(request, response);
	                return;
	            }
	            
	            // Create Patient object
	            Patient patient = new Patient(patientID, patientName, age, gender, 
	                                        admissionDate, ailment, assignedDoctor);
	            
	            // Add patient to database
	            boolean success = hospitalDAO.addPatient(patient);
	            
	            if (success) {
	                request.setAttribute("successMessage", "Patient added successfully!");
	                request.setAttribute("patient", patient);
	            } else {
	                request.setAttribute("errorMessage", "Failed to add patient. Please try again.");
	            }
	            
	        } catch (NumberFormatException e) {
	            request.setAttribute("errorMessage", "Invalid input format. Please check Patient ID and Age.");
	        } catch (IllegalArgumentException e) {
	            request.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM-DD format.");
	        } catch (Exception e) {
	            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
	        }
	        
	        // Forward back to the form page
	        request.getRequestDispatcher("patientadd.jsp").forward(request, response);
	    }
	    
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        // Redirect GET requests to the form page
	        response.sendRedirect("patientadd.jsp");
	    }
	

}
