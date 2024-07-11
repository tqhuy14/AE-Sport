/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerr;

import DBContext.DAOFeedback;
import Model.Feedback;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;

/**
 *
 * @author Admin
 */
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class FeedbackForm extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/feedbackphanhoi.jsp").forward(request, response);
  
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        int user_ID = Integer.parseInt(request.getParameter("user_ID"));
        String detal = request.getParameter("detal");
        String img = request.getParameter("img");
   
        // Sử dụng DAO để chèn dữ liệu vào cơ sở dữ liệu
        DAOFeedback dao = new DAOFeedback();
        dao.insertFeedback(user_ID, detal, img);

        // Trả về kết quả cho người dùng
        response.getWriter().print("Feedback submitted successfully");

    }
}
