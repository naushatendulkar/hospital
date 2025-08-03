package com.controller;
import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/generateReport")  // this path must match the one you use in the browser or link
public class GenerateReportController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = dao.getAllPatients();
        request.setAttribute("patients", patients);
        RequestDispatcher dispatcher = request.getRequestDispatcher("report.jsp");
        dispatcher.forward(request, response);
    }
}

