/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import Model.Role;
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
public class UpdateAccount extends HttpServlet {

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
            out.println("<title>Servlet UpdateAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccount at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("uID"));
        ArrayList<Role> list = dao.getAllRole();
        request.setAttribute("uID", id);
        request.setAttribute("list", list);
        if (id == 0) {
            response.sendRedirect(request.getContextPath() + "/manageruseraccount");
        } else {
            request.getRequestDispatcher("admin/UpdateUserAccount.jsp").forward(request, response);
        }
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

        try {
            int uid = Integer.parseInt(request.getParameter("uID"));
            if (request.getParameter("role").equals("user")) {
                dao.deleteUserRole(uid);
                if (dao.getUserRoleByUserID(uid) != null) {
                    response.sendRedirect(request.getContextPath() + "/manageremployeeaccount");
                } else {
                    response.sendRedirect(request.getContextPath() + "/manageruseraccount");
                }

            } else {
                int roleid = Integer.parseInt(request.getParameter("role"));
                dao.deleteUserRole(uid);
                dao.insertUserRole(uid, roleid);
                if (dao.getUserRoleByUserID(uid) != null) {
                    response.sendRedirect(request.getContextPath() + "/manageremployeeaccount");
                } else {
                    response.sendRedirect(request.getContextPath() + "/manageruseraccount");
                }
            }

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manageruseraccount");
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
