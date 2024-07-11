/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import Model.Feature;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author admin
 */
@WebServlet(name = "ManagerFeature", urlPatterns = {"/managerfeature"})
public class ManagerFeature extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerFeature</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerFeature at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();
        ArrayList<Feature> list = dao.getAllFeature();
        request.setAttribute("list", list);
        request.getRequestDispatcher("admin/ManagerFeature.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fuName = request.getParameter("fuName");
        String url = request.getParameter("url");
        boolean key = true;
        try {
            AdminDAO dao = new AdminDAO();
            for (Feature f : dao.getAllFeature()) {
                if (f.getFu_Name().toLowerCase().equals(fuName.toLowerCase())) {
                    request.setAttribute("error", "Tên chức năng đã tồn tại!");
                    key = false;
                }

                if (f.getUrl().equals(url)) {
                    request.setAttribute("error2", "Đường dẫn đã tồn tại!");
                    key = false;
                }
            }
            if (key) {
                dao.insertFeature(fuName, url);
            }
            ArrayList<Feature> list = dao.getAllFeature();
            request.setAttribute("list", list);
            request.getRequestDispatcher("admin/ManagerFeature.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
