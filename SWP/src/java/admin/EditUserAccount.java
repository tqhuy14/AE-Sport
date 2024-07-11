/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import Model.Address;
import Model.UserAccount;
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
public class EditUserAccount extends HttpServlet {

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
            out.println("<title>Servlet EditUserAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditUserAccount at " + request.getContextPath() + "</h1>");
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
        UserAccount user = dao.getUserAccountByUserID(id);
        request.setAttribute("user", user);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/manageruseraccount");
        } else {
            ArrayList<Address> adrList = dao.getAddressByUserID(id);
            request.setAttribute("adrList", adrList);
            request.getRequestDispatcher("admin/EditUserAccount.jsp").forward(request, response);
        };
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
        int userId = Integer.parseInt(request.getParameter("uid"));
        String fullName = request.getParameter("fname");
        String userName = request.getParameter("uname");
        String password = request.getParameter("pword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String img1 = request.getParameter("img1");
        String img2 = request.getParameter("img2");
        String img = img1;
        String[] addresses = request.getParameterValues("address");

        String error = "";

        UserAccount user = dao.getUserAccountByUserName(userName);
        if (user != null && !dao.getUserAccountByUserID(userId).getUserName().equals(userName)) {
            error += "e";
            request.setAttribute("error1", "UserName: (" + userName + ") đã tồn tại!");
        }
        user = dao.getUserAccountByEmail(email);
        if (user != null && !dao.getUserAccountByUserID(userId).getEmail().equals(email)) {
            error += "e";
            request.setAttribute("error2", "Email: (" + email + ") đã tồn tại!");
        }
        if (error.equals("")) {
            if(img1.trim().isEmpty()){
                img = img2;
            }
            UserAccount userTemp = new UserAccount(userId, password, userName, fullName, email, phone, img);
            dao.updateUserAccount(userTemp);
            
            //update address
            if (addresses != null) {
                ArrayList<Address> adrList = dao.getAddressByUserID(userId);
                for (int i = 0; i < addresses.length; i++) {
                    Address elem = new Address(adrList.get(i).getAddressId(), addresses[i], userId);
                    
                    dao.updateAddress(elem);
                }
            }
            if (dao.getUserRoleByUserID(userId) != null) {
                response.sendRedirect(request.getContextPath() + "/manageremployeeaccount");
            } else {
                response.sendRedirect(request.getContextPath() + "/manageruseraccount");
            }
        } else {
            user = dao.getUserAccountByUserID(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin/EditUserAccount.jsp").forward(request, response);
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
