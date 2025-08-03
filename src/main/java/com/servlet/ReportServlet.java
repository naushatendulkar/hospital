package com.servlet;



import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.HospitalDAO;
import com.model.Patient;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HospitalDAO hospitalDAO;
    
    public void init() {
        hospitalDAO = new HospitalDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to report form
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        
        try {
            switch (reportType) {
                case "dateRange":
                    generateDateRangeReport(request, response);
                    break;
                case "ailment":
                    generateAilmentReport(request, response);
                    break;
                case "doctor":
                    generateDoctorReport(request, response);
                    break;
                default:
                    request.setAttribute("error", "Invalid report type selected.");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }
    
    private void generateDateRangeReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = new Date(sdf.parse(startDateStr).getTime());
            Date endDate = new Date(sdf.parse(endDateStr).getTime());
            
            List<Patient> patients = hospitalDAO.getPatientsByDateRange(startDate, endDate);
            
            request.setAttribute("patients", patients);
            request.setAttribute("reportTitle", "Patients Admitted Between " + startDateStr + " and " + endDateStr);
            request.setAttribute("reportType", "Date Range Report");
            request.setAttribute("totalCount", patients.size());
            
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD format.");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            return;
        }
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    private void generateAilmentReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String ailment = request.getParameter("ailment");
        
        if (ailment == null || ailment.trim().isEmpty()) {
            request.setAttribute("error", "Please enter an ailment to search for.");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            return;
        }
        
        List<Patient> patients = hospitalDAO.getPatientsByAilment(ailment);
        
        request.setAttribute("patients", patients);
        request.setAttribute("reportTitle", "Patients with Ailment: " + ailment);
        request.setAttribute("reportType", "Ailment Report");
        request.setAttribute("totalCount", patients.size());
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    private void generateDoctorReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String doctor = request.getParameter("doctor");
        
        if (doctor == null || doctor.trim().isEmpty()) {
            request.setAttribute("error", "Please enter a doctor name to search for.");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            return;
        }
        
        List<Patient> patients = hospitalDAO.getPatientsByDoctor(doctor);
        
        request.setAttribute("patients", patients);
        request.setAttribute("reportTitle", "Patients Assigned to Dr. " + doctor);
        request.setAttribute("reportType", "Doctor Report");
        request.setAttribute("totalCount", patients.size());
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }


}
