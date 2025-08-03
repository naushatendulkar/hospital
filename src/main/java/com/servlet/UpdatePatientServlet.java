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

	@WebServlet("/UpdatePatientServlet")
	public class UpdatePatientServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    private HospitalDAO hospitalDAO;
	    
	    public void init() {
	        hospitalDAO = new HospitalDAO();
	    }
	    
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        
	        String action = request.getParameter("action");
	        
	        if ("search".equals(action)) {
	            // Search for patient by ID
	            try {
	                int patientID = Integer.parseInt(request.getParameter("patientID"));
	                Patient patient = hospitalDAO.getPatientById(patientID);
	                
	                if (patient != null) {
	                    request.setAttribute("patient", patient);
	                    request.setAttribute("found", true);
	                } else {
	                    request.setAttribute("errorMessage", "Patient with ID " + patientID + " not found.");
	                }
	                
	            } catch (NumberFormatException e) {
	                request.setAttribute("errorMessage", "Invalid Patient ID format.");
	            }
	        }
	        
	        request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
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
	            
	            // Check if patient exists
	            if (!hospitalDAO.patientExists(patientID)) {
	                request.setAttribute("errorMessage", "Patient with ID " + patientID + " does not exist.");
	                request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
	                return;
	            }
	            
	            // Create Patient object with updated information
	            Patient patient = new Patient(patientID, patientName, age, gender, 
	                                        admissionDate, ailment, assignedDoctor);
	            
	            // Update patient in database
	            boolean success = hospitalDAO.updatePatient(patient);
	            
	            if (success) {
	                request.setAttribute("successMessage", "Patient updated successfully!");
	                request.setAttribute("patient", patient);
	                request.setAttribute("updated", true);
	            } else {
	                request.setAttribute("errorMessage", "Failed to update patient. Please try again.");
	            }
	            
	        } catch (NumberFormatException e) {
	            request.setAttribute("errorMessage", "Invalid input format. Please check Patient ID and Age.");
	        } catch (IllegalArgumentException e) {
	            request.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM-DD format.");
	        } catch (Exception e) {
	            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
	        }
	        
	        // Forward back to the form page
	        request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
	    }
	
}
