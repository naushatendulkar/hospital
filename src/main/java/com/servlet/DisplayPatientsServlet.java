package com.servlet;



import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.HospitalDAO;
import com.model.Patient;

@WebServlet("/DisplayPatientsServlet")
public class DisplayPatientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HospitalDAO hospitalDAO;
    
    public void init() {
        hospitalDAO = new HospitalDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        displayAllPatients(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        displayAllPatients(request, response);
    }
    
    private void displayAllPatients(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Patient> patients = hospitalDAO.getAllPatients();
            request.setAttribute("patients", patients);
            request.setAttribute("totalPatients", patients.size());
            
            if (patients.isEmpty()) {
                request.setAttribute("message", "No patients found in the database.");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error retrieving patients: " + e.getMessage());
        }
        
        request.getRequestDispatcher("patientdisplay.jsp").forward(request, response);
    }

}
