package com.servlet;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.HospitalDAO;
import com.model.Patient;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HospitalDAO hospitalDAO;
    
    public void init() {
        hospitalDAO = new HospitalDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null && action.equals("load")) {
            loadPatientForDelete(request, response);
        } else {
            response.sendRedirect("patientdelete.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null && action.equals("delete")) {
            deletePatient(request, response);
        } else if (action != null && action.equals("search")) {
            searchPatientForDelete(request, response);
        }
    }
    
    private void searchPatientForDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int patientID = Integer.parseInt(request.getParameter("patientID"));
            Patient patient = hospitalDAO.getPatientById(patientID);
            
            if (patient != null) {
                request.setAttribute("patient", patient);
                request.setAttribute("found", true);
                request.setAttribute("message", "Patient found. Review details before deletion.");
            } else {
                request.setAttribute("found", false);
                request.setAttribute("error", "Patient with ID " + patientID + " not found.");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("found", false);
            request.setAttribute("error", "Please enter a valid Patient ID.");
        } catch (Exception e) {
            request.setAttribute("found", false);
            request.setAttribute("error", "Error searching for patient: " + e.getMessage());
        }
        
        request.getRequestDispatcher("patientdelete.jsp").forward(request, response);
    }
    
    private void loadPatientForDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int patientID = Integer.parseInt(request.getParameter("id"));
            Patient patient = hospitalDAO.getPatientById(patientID);
            
            if (patient != null) {
                request.setAttribute("patient", patient);
                request.setAttribute("found", true);
            } else {
                request.setAttribute("found", false);
                request.setAttribute("error", "Patient not found.");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("found", false);
            request.setAttribute("error", "Invalid Patient ID.");
        }
        
        request.getRequestDispatcher("patientdelete.jsp").forward(request, response);
    }
    
    private void deletePatient(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int patientID = Integer.parseInt(request.getParameter("patientID"));
            
            // First check if patient exists
            Patient patient = hospitalDAO.getPatientById(patientID);
            if (patient == null) {
                request.setAttribute("found", false);
                request.setAttribute("error", "Patient with ID " + patientID + " not found.");
                request.getRequestDispatcher("patientdelete.jsp").forward(request, response);
                return;
            }
            
            // Delete the patient
            boolean deleted = hospitalDAO.deletePatient(patientID);
            
            if (deleted) {
                request.setAttribute("success", "Patient '" + patient.getPatientName() + 
                    "' (ID: " + patientID + ") has been successfully deleted.");
                request.setAttribute("found", false); // Hide the form after successful deletion
            } else {
                request.setAttribute("found", true);
                request.setAttribute("patient", patient);
                request.setAttribute("error", "Failed to delete patient. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("found", false);
            request.setAttribute("error", "Please enter a valid Patient ID.");
        } catch (Exception e) {
            request.setAttribute("found", false);
            request.setAttribute("error", "Error deleting patient: " + e.getMessage());
        }
        
        request.getRequestDispatcher("patientdelete.jsp").forward(request, response);
    }
}


