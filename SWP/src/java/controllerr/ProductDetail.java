package controllerr;

import data.ImgContext;
import data.ProductContext;
import entity.ProductSizeColor;
import entity.img;
import entity.product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class ProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        ProductContext productDB = new ProductContext();
        ImgContext imgDB = new ImgContext();

        product productDetail = productDB.getProduct(Integer.parseInt(productId));
        ArrayList<img> listImg = imgDB.getImgsofProduct(Integer.parseInt(productId));

        ArrayList<ProductSizeColor> listSizeandColorofProduct = productDB.getColorandSizeofProduct(Integer.parseInt(productId));
        request.setAttribute("listSizeandColorofProduct", listSizeandColorofProduct);
        request.setAttribute("listImg", listImg);

        request.setAttribute("productDetail", productDetail);

        request.getRequestDispatcher("/view/Product/productDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String number = request.getParameter("number");
        String action = request.getParameter("action");
        System.out.println(action);
        System.out.println(productId);
        System.out.println(color);
        System.out.println(size);
        System.out.println(number);

    }

    @Override
    public String getServletInfo() {
        return "Product Detail Servlet";
    }
}
