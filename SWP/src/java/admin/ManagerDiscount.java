/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin;

import DBContext.AdminDAO;
import Model.Discount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author admin
 */
public class ManagerDiscount extends HttpServlet {

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
            out.println("<title>Servlet ManagerDiscount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerDiscount at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("key") != null) {
            if (request.getParameter("key").equals("delete")) {
                try {
                    int dID = Integer.parseInt(request.getParameter("dID"));
                    dao.deleteDiscountByID(dID);
                    request.setAttribute("info", "Xóa thành công!");
                } catch (Exception e) {
                    if (e.getMessage().contains("The DELETE statement conflicted with the REFERENCE constraint \"FK_Product_Discount\"")) {
                        request.setAttribute("error", "Xóa không thành công (có sản phẩm đang dùng sự kiện này)!");
                    } else {
                        request.setAttribute("error", "Xóa không thành công! Lỗi: " + e.getMessage());
                    }
                }

            }
        }
        request.setCharacterEncoding("UTF-8");
        String dName = request.getParameter("dname");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        ArrayList<Discount> list = dao.getAllDiscount();
        if (dName != null && !dName.isEmpty()) {
            list = filterDiscountsByName(list, dName);
        }
        if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
            System.out.println(startDateStr + "-" + endDateStr);
            list = filterDiscountsByDate(list, startDateStr, endDateStr);
        }
        request.setAttribute("list", list);
        request.getRequestDispatcher("admin/ManagerDiscount.jsp").forward(request, response);
    }

    // tim theo ten
    private ArrayList<Discount> filterDiscountsByName(ArrayList<Discount> discounts, String name) {
        ArrayList<Discount> filteredList = new ArrayList<>();
        for (Discount discount : discounts) {
            if (discount.getDiscount_Name() != null && discount.getDiscount_Name().toLowerCase().contains(name.toLowerCase())) {
                filteredList.add(discount);
            }
        }
        return filteredList;
    }

    // tim theo date
    private ArrayList<Discount> filterDiscountsByDate(ArrayList<Discount> discounts, String startDateStr, String endDateStr) {
        ArrayList<Discount> filteredList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date startDate = new Date(sdf.parse(startDateStr).getTime());
            Date endDate = new Date(sdf.parse(endDateStr).getTime());

            if (startDate.after(endDate)) {
                return filteredList; // Return empty list if start date is after end date
            }

            for (Discount discount : discounts) {
                if ((discount.getStartDate().compareTo(startDate) >= 0 && discount.getStartDate().compareTo(endDate) <= 0)
                        || (discount.getEndDate().compareTo(startDate) >= 0 && discount.getEndDate().compareTo(endDate) <= 0)
                        || (discount.getStartDate().compareTo(startDate) <= 0 && discount.getEndDate().compareTo(endDate) >= 0)) {
                    filteredList.add(discount);
                    System.out.println(discount);
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
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
        AdminDAO dao = new AdminDAO();
        if (request.getParameter("key") != null) {
            if (request.getParameter("key").equals("add")) {

                String name = request.getParameter("dname");
                String amountStr = request.getParameter("amount");
                String startDateStr = request.getParameter("startdate");
                String endDateStr = request.getParameter("enddate");
                //System.out.println(name + "-" + amountStr + "-" + startDateStr + "-" + endDateStr);
                String error = "";
                try {
                    Date startDate = Date.valueOf(startDateStr);
                    Date endDate = Date.valueOf(endDateStr);
                    int amount = Integer.parseInt(amountStr);
                    Discount distemp = dao.getDiscountByName(name);
                    if (distemp != null) {
                        error += "e";
                        request.setAttribute("error1", "Tên sự kiện đã tồn tại!");
                    }
                    if (startDate.after(endDate)) {
                        error += "e";
                        request.setAttribute("error2", "Ngày kết thúc phải diễn ra sau ngày bắt đầu!");
                    }
                    if (error.equals("")) {
                        dao.insertDiscount(new Discount(amount, name, startDate, endDate));
                        request.setAttribute("info", "Thêm thành công!");
                    } else {
                        request.getRequestDispatcher("admin/AddDiscount.jsp").forward(request, response);
                    }

                } catch (Exception e) {
                    request.setAttribute("error", "Thêm không thành công!" + e);
                }
            } else if (request.getParameter("key").equals("edit")) {
                int dID = Integer.parseInt(request.getParameter("dID"));
                String name = request.getParameter("dname");
                String amountStr = request.getParameter("amount");
                String startDateStr = request.getParameter("startdate");
                String endDateStr = request.getParameter("enddate");
                //System.out.println(dID+"-"+name+amountStr+startDateStr+endDateStr);
                Discount dc = dao.getDiscountByName(name);
                String error = "";
                try {
                    Date startDate = Date.valueOf(startDateStr);
                    Date endDate = Date.valueOf(endDateStr);
                    int amount = Integer.parseInt(amountStr);
                    if (dc != null && !dao.getDiscountByID(dID).getDiscount_Name().equals(name)) {
                        error += "e";
                        request.setAttribute("error1", "Tên sự kiện: (" + name + ") đã tồn tại!");
                    }

                    if (startDate.after(endDate)) {
                        error += "e";
                        request.setAttribute("error2", "Ngày kết thúc phải diễn ra sau ngày bắt đầu!");

                    }

                    if (error.equals("")) {

                        dao.updateDiscount(new Discount(dID, amount, name, startDate, endDate));
                        request.setAttribute("info", "Chỉnh sửa thành công!");
                    } else {
                        request.getRequestDispatcher("admin/EditDiscount.jsp?dID=" + dID).forward(request, response);
                    }
                } catch (Exception e) {
                    request.setAttribute("error", "Thêm không thành công!" + e);
                }

            }
            ArrayList<Discount> list = dao.getAllDiscount();
            request.setAttribute("list", list);
            request.getRequestDispatcher("admin/ManagerDiscount.jsp").forward(request, response);
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
