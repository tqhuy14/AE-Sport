/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package admin;

import DBContext.AdminDAO;
import Model.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.sql.Date;
/**
 *
 * @author admin
 */
public class AddUserAccount extends HttpServlet {
   
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
            out.println("<title>Servlet AddUserAccount</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserAccount at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("admin/AddUserAccount.jsp").forward(request, response);
        
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
        String fullName = request.getParameter("fname");
        String address = request.getParameter("address");
        String userName = request.getParameter("uname");
        String password = request.getParameter("pword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String img = request.getParameter("img");
        String status = "none";
        LocalDate localDate = LocalDate.now();
        Date sqlDate = Date.valueOf(localDate);
        
        AdminDAO dao = new AdminDAO();
        String error = "";
        try {
            
            UserAccount userTemp1 = dao.getUserAccountByEmail(email);
            if(userTemp1 != null){
                error += "e";
                request.setAttribute("error3", "Email đã tồn tại!");
            }
            userTemp1 = dao.getUserAccountByUserName(userName);
            if(userTemp1 != null){
                error += "e";
                request.setAttribute("error2", "UserName đã tồn tại!");
            }
            if(error.equals("")){
               dao.insertUserAccount( new UserAccount(password, userName, fullName, email, phone, img, status, sqlDate));
               int id = dao.getLastInsertedUserAccountId();
               dao.insertAddressUserAccount(address, id);
               response.sendRedirect("manageruseraccount");
            }else{
                request.getRequestDispatcher("admin/AddUserAccount.jsp").forward(request, response);
            }
              
        } catch (Exception e) {
            response.sendRedirect("manageruseraccount");
        }
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
