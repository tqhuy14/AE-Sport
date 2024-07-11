/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import entity.sport;
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
public class ManagerSport extends HttpServlet {

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
            out.println("<title>Servlet ManagerSport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerSport at " + request.getContextPath() + "</h1>");
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

        // Xử lý việc xóa môn thể thao
        if (request.getParameter("sportID") != null) {
            int bid = Integer.parseInt(request.getParameter("sportID"));
            dao.deleteSportByID(bid);
        }

        // Lấy danh sách môn thể thao và tên môn thể thao
        ArrayList<sport> list = dao.getAllSport();
        ArrayList<String> listName = dao.getAllNameSport();

        // Xử lý lọc môn thể thao nếu tham số 'op' khác "all"
        if (request.getParameter("op") != null && !request.getParameter("op").equals("all")) {
            String op = request.getParameter("op");
            ArrayList<sport> filteredList = new ArrayList<>();
            for (sport s : list) {
                if (s.getSport_Name().equals(op)) {
                    filteredList.add(s);
                }
            }
            list = filteredList;
        }

        // Đặt các thuộc tính cần thiết và chuyển tiếp yêu cầu đến trang JSP
        request.setAttribute("list", list);
        request.setAttribute("listName", listName);
        request.getRequestDispatcher("admin/ManagerSport.jsp").forward(request, response);
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
        String name = request.getParameter("sportname");
        String clb = request.getParameter("clbname");
        if (dao.getSportByNameAndClb(name, clb) == null) {
            dao.insertSport(name, clb);
        } else {
            request.setAttribute("error", "Tên CLB đã có trong môn thể thao!");
        }
        ArrayList<sport> list = dao.getAllSport();
        ArrayList<String> listName = dao.getAllNameSport();
        request.setAttribute("list", list);
        request.setAttribute("listName", listName);
        request.getRequestDispatcher("admin/ManagerSport.jsp").forward(request, response);

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
