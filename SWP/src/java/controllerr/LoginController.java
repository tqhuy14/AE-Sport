/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerr;

import DBContext.AccountDAO;
import Model.UserAccount;
import Service.Email;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Laptop K1
 */
public class LoginController extends HttpServlet {

    private AccountDAO ADAO;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("Action");
        ADAO = new AccountDAO();
        switch (action) {
            case "Login":
                Login(request, response);
                break;
            case "Register":
                Register(request, response);
                break;
            case "ForgetPasswork":
                ForgetPasswork(request, response);
                break;
        }
    }

    private void Login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String pass = request.getParameter("password");
        String uName = request.getParameter("userName");
        UserAccount U = ADAO.CheckLogin(uName, pass);
        
        // check acccount có tồn tại hay không
        if (U != null) { 
            response.getWriter().write("PASS");
            request.getSession().setAttribute("CRRAccount", U);
        } else {
            response.getWriter().write("Inorrect username or password!!");
        }
    }

    private void Register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String userName = request.getParameter("userName");
        String userPhone = request.getParameter("userPhone");
        String userAddress = request.getParameter("userAddress");
        String userEmail = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String usserPass = request.getParameter("usserPass");
        // kiểm tra email đã được đăng ký trước đó chưa?
        if (ADAO.GetAccountByEmail(userEmail) > 0) {
            response.getWriter().write("Incorrect Email was existed, try again");
            return;
        }
        // kiểm tra userName đã được đăng ký trước đó chưa?
        if (ADAO.validateUserName(userName)) {
            response.getWriter().write("Incorrect UsserName was existed, try again");
        } else {
            UserAccount uA = new UserAccount(userAddress, userName, usserPass, fullName, userEmail, userName);
            // trả về id account mới vừa được insert nếu thành công
            int newIdInsert = ADAO.insertUserAccount(uA); 
            if (newIdInsert > 0) {
                // gửi email tới địa chỉ mail vừa được đăng ký
                Email.sendEmail(userEmail, "AESport, Active you account", "Click this link to active your account: http://localhost:8080/SWP/Account?Action=ActiveAccount&AccountId=" + newIdInsert);
                response.getWriter().write("Register successfull, please check yout email");
            } else {
                response.getWriter().write("Incorrect fail to register");
            }
        }
    }

    private void ForgetPasswork(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String emailForgot = request.getParameter("userEmail");
        int newAccID = ADAO.GetAccountByEmail(emailForgot);
        if (newAccID != 0) {
            // gửi email tới địa chỉ mail vừa được đăng ký
            String bodyMail = "Click this link to reset your account: http://localhost:8080/SWP/Account?Action=RQResetPassword&AccountId=" + newAccID;
            Email.sendEmail(emailForgot, "Request To Reset your account password", bodyMail);
            response.getWriter().write("Please check your mail to get token reset!!");
            return;
        }
        response.getWriter().write("Incorrect, Your Email not existed");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

