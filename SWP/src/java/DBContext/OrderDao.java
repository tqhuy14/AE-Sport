/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBContext;

import Model.Address;
import Model.ImgProduct;
import Model.Order;
import Model.OrderItem;
import Model.Payment;
import Model.Product;
import Model.Ship;
import Model.UserAccount;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Laptop K1
 */
public class OrderDao extends DBContext {

    public List<Order> getOrderUser(int uId) {
        List<Order> listOrder = new ArrayList<Order>();
        String sql = "SELECT * FROM [dbo].[Order] WHERE user_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, uId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_ID");
                int userID = rs.getInt("user_ID");
                String status = rs.getString("order_status"); // Sửa tên cột
                Date date = rs.getDate("order_date");
                int payId = rs.getInt("pay_ID");
                int shipId = rs.getInt("shipID");
                float amount = rs.getFloat("total_amount"); // Sửa tên cột
                Order order = new Order(orderId, userID, status, date, payId, shipId, amount);
                listOrder.add(order);
            }
            return listOrder;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Order getOrderDetail(int orderId) {
        Order order = new Order();
        String sql = "SELECT * FROM [dbo].[Order] WHERE order_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userID = rs.getInt("user_ID");
                String status = rs.getString("order_status"); // Sửa tên cột
                Date date = rs.getDate("order_date");
                int payId = rs.getInt("pay_ID");
                int shipId = rs.getInt("shipID");
                float amount = rs.getFloat("total_amount"); // Sửa tên cột
                order = new Order(orderId, userID, status, date, payId, shipId, amount);
                order.setItems(getOrderItems(orderId));
                order.setShip(getShipByOrderId(orderId));
                order.setPayment(getPaymentByOrderId(orderId));
            }
            return order;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<OrderItem> getOrderItems(int orderID) {
        List<OrderItem> orderItems = new ArrayList<OrderItem>();
        String sql = "SELECT * FROM [dbo].[Order_item] WHERE order_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_ID");
                int proId = rs.getInt("product_ID");
                int quantity = rs.getInt("quantity");
                float price = rs.getFloat("price_unit");

                OrderItem item = new OrderItem(orderId, proId, quantity, price);

                // Lấy thông tin sản phẩm và hình ảnh sản phẩm
                Product product = getProductById(proId);
//                ImgProduct productImg = getImgProductByProductId(proId);
//
//                // Thiết lập hình ảnh cho sản phẩm
//                product.setImg(productImg);

                // Thiết lập sản phẩm cho OrderItem
                item.setProduct(product);

                // Thêm OrderItem vào danh sách
                orderItems.add(item);
            }
            return orderItems;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
     public Address getAddressByUserID(int userId) {
        Address address = null;
        String sql = "SELECT * FROM Address WHERE user_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int addressId = rs.getInt("address_id");
                String addr = rs.getString("address");
                address = new Address(addressId, addr, userId);
            }
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return address;
    }


    public ImgProduct getImgProductByProductId(int productId) {
        ImgProduct imgProduct = null;
        String sql = "SELECT * FROM ImgProduct WHERE product_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int imgID = rs.getInt("img_ID");
                String imgUrl = rs.getString("img_url");
                imgProduct = new ImgProduct(imgID, imgUrl);
            }
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imgProduct;
    }

    public Ship getShipByOrderId(int orderId) {
        Ship ship = null;
        String sql = "SELECT * FROM Ship WHERE shipID = (SELECT shipID FROM [dbo].[Order] WHERE order_ID = ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int shipID = rs.getInt("shipID");
                String shipStatus = rs.getString("ship_status");
                Date phanedTime = rs.getDate("phaned_time");
                Float shipCost = rs.getFloat("ship_cost");
                String shipMethod = rs.getString("Ship_method");

                ship = new Ship(shipID, shipStatus, phanedTime, shipCost, shipMethod);
            }
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ship;
    }

    public Payment getPaymentByOrderId(int orderId) {
        Payment payment = null;
        String sql = "SELECT p.* FROM Payment p JOIN [dbo].[Order] o ON p.pay_ID = o.pay_ID WHERE o.order_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int payID = rs.getInt("pay_ID");
                String paymentName = rs.getString("payment_Name");

                payment = new Payment(payID, paymentName);
            }
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payment;
    }

    public Product getProductById(int productId) {
        Product product = null;

        try {
            String sql = "SELECT product_ID, feedback_ID, price, description, status, Sport_ID, product_Name, brand_ID, Inventory_number, discount_ID, Subcategory_ID FROM Product WHERE product_ID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet resultSet = st.executeQuery();

            if (resultSet.next()) {
                product = new Product();
                product.setProductID(resultSet.getInt("product_ID"));
                product.setFeedbackID(resultSet.getInt("feedback_ID"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setStatus(resultSet.getString("status"));
                product.setSportID(resultSet.getInt("Sport_ID"));
                product.setProductName(resultSet.getString("product_Name"));
                product.setBrandID(resultSet.getInt("brand_ID"));
                product.setQuantity(resultSet.getInt("Inventory_number"));
                product.setDiscountID(resultSet.getInt("discount_ID"));
                // Assuming there is a setter for Subcategory_ID if required
            }

            if (resultSet != null) {
                resultSet.close();
            }
            if (st != null) {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public String getOrderStatus(int orderId) {
        String status = null;
        String sql = "SELECT order_status FROM [dbo].[Order] WHERE order_ID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                status = rs.getString("order_status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public void cancelOrder(int orderId) {
        String sql = "UPDATE [dbo].[Order] SET order_status = 'Cancelled' WHERE order_ID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// ADmin
    public List<Order> getAllOrders() {
        List<Order> listOrder = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Order]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_ID");
                int userID = rs.getInt("user_ID");
                String status = rs.getString("order_status");
                Date date = rs.getDate("order_date");
                int payId = rs.getInt("pay_ID");
                int shipId = rs.getInt("shipID");
                float amount = rs.getFloat("total_amount");
                Order order = new Order(orderId, userID, status, date, payId, shipId, amount);
                order.setItems(getOrderItems(orderId));
                order.setShip(getShipByOrderId(orderId));
                order.setPayment(getPaymentByOrderId(orderId));
                order.setUser(getUserByOrderId(orderId));

                listOrder.add(order);
            }
            return listOrder;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public UserAccount getUserByOrderId(int orderId) {
        UserAccount user = null;
        String sql = "SELECT u.* FROM UserAccounts u JOIN [dbo].[Order] o ON u.user_ID = o.user_ID WHERE o.order_ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("user_ID");
                String address = rs.getString("address");
                String passwordHash = rs.getString("password_hash");
                String username = rs.getString("username");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phone_number");

                user = new UserAccount(userId, address, passwordHash, username, fullName, email, phoneNumber);
            }
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE [dbo].[Order] SET order_status = ? WHERE order_ID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // Assuming you already have a connection object named 'connection'

        try {
            // Create OrderDao instance with the existing connection
            OrderDao orderDao = new OrderDao();

            // Test getPaymentByOrderId method
            int testOrderId = 1; // Change this order ID as needed for your database data
            Payment payment = orderDao.getPaymentByOrderId(testOrderId);
            System.out.println("Payment details for order ID " + testOrderId + ":");
            System.out.println(payment);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
