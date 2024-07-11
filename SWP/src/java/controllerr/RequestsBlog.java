/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerr;

import data.BlogContext;
import entity.Blog;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author Hoàng Sơn
 */
public class RequestsBlog extends HttpServlet {

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
        BlogContext blogDB = new BlogContext();
        if (request.getParameter("type").contains("1")) {
            ArrayList<Blog> requestAdd = blogDB.getRequestBlogPending("add", "pending");

            request.setAttribute("requestAdd", requestAdd);
        }
        if (request.getParameter("type").contains("2")) {
            ArrayList<Blog> requestDelete = blogDB.getRequestBlogPending("delete", "pending");
            request.setAttribute("requestDelete", requestDelete);
        }
        request.getRequestDispatcher("view/Blog/requestBlog.jsp").forward(request, response);
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
        String reject = request.getParameter("reject");
        String accept = request.getParameter("accept");
        BlogContext blogDB = new BlogContext();
        if ("add".contains(request.getParameter("type"))) {
            if (reject != null) {
                blogDB.updateStatusBlog(Integer.parseInt(reject), "reject", "add");
            }
            if (accept != null) {
                blogDB.updateStatusBlog(Integer.parseInt(accept), "done", "add");

            }

            ArrayList<Blog> requestAdd = blogDB.getRequestBlogPending("add", "pending");
            request.setAttribute("requestAdd", requestAdd);
        }

        if ("delete".contains(request.getParameter("type"))) {
            if (reject != null) {
                blogDB.updateStatusBlog(Integer.parseInt(reject), "reject", "delete");
            }
            if (accept != null) {
                blogDB.updateStatusBlog(Integer.parseInt(accept), "done", "delete");
            }
            ArrayList<Blog> requestDelete = blogDB.getRequestBlogPending("delete", "pending");
            request.setAttribute("requestDelete", requestDelete);
        }
        request.getRequestDispatcher("view/Blog/requestBlog.jsp").forward(request, response);

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
