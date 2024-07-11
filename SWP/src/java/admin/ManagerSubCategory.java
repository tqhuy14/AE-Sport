/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package admin;

import DBContext.AdminDAO;
import Model.SubCategory;
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
public class ManagerSubCategory extends HttpServlet {
   
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerSubCategory</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerSubCategory at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();

        // Xử lý việc xóa thể loại con
        if (request.getParameter("subcategoryID") != null) {
            int sid = Integer.parseInt(request.getParameter("subcategoryID"));
            dao.deleteSubCategoryByID(sid);
        }

        // Lấy danh sách category và type
        ArrayList<SubCategory> list = dao.getAllSubCategory();
        ArrayList<Integer> listCategory = dao.getAllCategoryOfSubCategory();

        // Xử lý lọc category nếu tham số 'op' khác "all"
        if (request.getParameter("op") != null && Integer.parseInt(request.getParameter("op")) != 0) {
            int op = Integer.parseInt(request.getParameter("op"));
            ArrayList<SubCategory> filteredList = new ArrayList<>();
            for (SubCategory s : list) {
                if (s.getCategory_ID() == op) {
                    filteredList.add(s);
                }
            }
            list = filteredList;
        }

        // Đặt các thuộc tính cần thiết và chuyển tiếp yêu cầu đến trang JSP
        request.setAttribute("list", list);
        request.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("admin/ManagerSubCategory.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();
        String name = request.getParameter("subcategoryname");
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        if (dao.getSubCategoryByNameAndCategoryID(name, categoryID) == null) {
            dao.insertSubCategory(name, categoryID);
        } else {
            
            request.setAttribute("error", "Tên thể loại con đã có danh mục "+dao.getCategoryByID(categoryID)+"!");
        }
        ArrayList<SubCategory> list = dao.getAllSubCategory();
        ArrayList<Integer> listCategory = dao.getAllCategoryOfSubCategory();
        request.setAttribute("list", list);
        request.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("admin/ManagerSubCategory.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
