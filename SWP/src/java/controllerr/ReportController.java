/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllerr;

import DBContext.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 *
 * @author Laptop K1
 */
public class ReportController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();
        try {
            switch (action) {
                case "registrationReport":
                    handleRegistrationReport(request, response, dao);
                    break;
                case "activityReport":
                    handleActivityReport(request, response, dao);
                    break;
                case "customActivityReport":
                    handleCustomActivityReport(request, response, dao);
                    break;
                default:
                    request.setAttribute("error", "Invalid action.");
                    request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        }
    }

    private void handleRegistrationReport(HttpServletRequest request, HttpServletResponse response, AccountDAO dao)
    throws ServletException, IOException {
        String period = request.getParameter("period");
        Map<String, Integer> report = dao.getUserRegistrationReport(period);
        request.setAttribute("registrationReport", report);
        request.getRequestDispatcher("/report/registrationReport.jsp").forward(request, response);
    }

    private void handleActivityReport(HttpServletRequest request, HttpServletResponse response, AccountDAO dao)
    throws ServletException, IOException {
        String period = request.getParameter("period");
        Map<String, Integer> report = dao.getUserActivityReport(period);
        request.setAttribute("activityReport", report);
        request.getRequestDispatcher("/report/activityReport.jsp").forward(request, response);
    }

    private void handleCustomActivityReport(HttpServletRequest request, HttpServletResponse response, AccountDAO dao)
    throws ServletException, IOException {
        String startDate = request.getParameter("start");
        String endDate = request.getParameter("end");
        Map<String, Integer> report = dao.getCustomUserActivityReport(startDate, endDate);
        request.setAttribute("customActivityReport", report);
        request.getRequestDispatcher("/report/customActivityReport.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}