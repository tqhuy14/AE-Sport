/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import Model.Size;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author admin
 */
public class ManagerSize extends HttpServlet {

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
            out.println("<title>Servlet ManagerSize</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerSize at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("sizeID") != null) {
            int sid = Integer.parseInt(request.getParameter("sizeID"));
            dao.deleteSizeByID(sid);
        }
        ArrayList<Size> list = dao.getAllSize();
        request.setAttribute("list", list);
        request.getRequestDispatcher("admin/ManagerSize.jsp").forward(request, response);
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
        AdminDAO dao = new AdminDAO();
        String sizetype = request.getParameter("sizetype");
        String sizename = request.getParameter("sizename");
        ArrayList<Size> list;

        if (sizetype.equals("Size số")) {
            try {
                 Integer.parseInt(sizename);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Sai định dạng!");
                list = dao.getAllSize();
                request.setAttribute("list", list);
                request.setAttribute("sizetype", sizetype);
                request.getRequestDispatcher("admin/ManagerSize.jsp").forward(request, response);
                return;
            }
        }

        if (dao.getSizeByName(sizename) == null) {
            dao.insertSize(sizename, sizetype);
        } else {
            request.setAttribute("error", "Size đã tồn tại!");
        }

        list = dao.getAllSize();
        request.setAttribute("list", list);
        request.getRequestDispatcher("admin/ManagerSize.jsp").forward(request, response);

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
