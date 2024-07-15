/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import Model.Product;
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
public class ManagerProduct extends HttpServlet {

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
            out.println("<title>Servlet ManagerProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerProduct at " + request.getContextPath() + "</h1>");
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

        request.setCharacterEncoding("UTF-8");

        String productName = request.getParameter("productname");
        String categoryID = request.getParameter("category");
        String status = request.getParameter("status");
        String add = request.getParameter("add");
        String edit = request.getParameter("edit");

        if (add != null) {
            if (add.equals("1")) {
                request.setAttribute("info", "Thêm sản phẩm thành công!");
            } else {
                request.setAttribute("error", "Thêm sản phẩm không thành công!");
            }
        }

        if (edit != null) {
            if (edit.equals("1")) {
                request.setAttribute("info", "Chỉnh sửa sản phẩm thành công!");
            } else {
                request.setAttribute("error", "Chỉnh sửa sản phẩm không thành công!");
            }
        }

        AdminDAO dao = new AdminDAO();
        ArrayList<Product> list = dao.getAllProduct();

        if (productName != null && !productName.isEmpty()) {
            list = filterProductsByName(list, productName);
        }
        if (categoryID != null && !categoryID.trim().isEmpty()) {
            list = filterProductsByCategory(list, categoryID);
        }
        if (status != null && !status.isEmpty()) {
            list = filterProductsByStatus(list, status);
        }

        request.setAttribute("list", list);
        request.getRequestDispatcher("admin/ManagerProduct.jsp").forward(request, response);
    }

    // tim theo ten
    private ArrayList<Product> filterProductsByName(ArrayList<Product> products, String name) {
        ArrayList<Product> filteredList = new ArrayList<>();
        for (Product product : products) {
            System.out.println(product.getProductName());
            if (product.getProductName() != null && product.getProductName().toLowerCase().contains(name.toLowerCase())) {
                filteredList.add(product);
            }
        }
        return filteredList;
    }

    // tim theo the loai
    private ArrayList<Product> filterProductsByCategory(ArrayList<Product> products, String categoryID) {
        ArrayList<Product> filteredList = new ArrayList<>();
        for (Product product : products) {
            Integer subcategoryID = product.getSubcategoryID();
            if (subcategoryID != null && ((subcategoryID - 1) + "").equals(categoryID)) {
                filteredList.add(product);
            }
        }
        return filteredList;
    }

    // tim theo trang thai
    private ArrayList<Product> filterProductsByStatus(ArrayList<Product> products, String status) {
        ArrayList<Product> filteredList = new ArrayList<>();
        for (Product product : products) {
            String productStatus = product.getStatus();
            if (productStatus != null && productStatus.equalsIgnoreCase(status)) {
                filteredList.add(product);
            }
        }
        return filteredList;
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
        try {
            int num = Integer.parseInt(request.getParameter("numberColor"));
            request.setAttribute("num", num);
            response.sendRedirect("addproduct?num=" + num);
        } catch (Exception e) {
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
