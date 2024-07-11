<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .progress-bar {
            width: 0;
        }
        .order-status {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .order-summary, .payment-details {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .card {
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .table thead th {
            background-color: #e9ecef;
        }
        .table img {
            margin-right: 10px;
            border-radius: 5px;
        }
        .logo {
            text-align: left;
            margin: 20px 0;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .badge-success {
            background-color: #28a745;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            right: 0;
            top: 100%;
            z-index: 1000;
        }
        .dropdown-menu a {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: #343a40;
        }
        .dropdown-menu a:hover {
            background-color: #f8f9fa;
        }
        .dropdown:hover .dropdown-menu {
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="d-flex justify-content-between align-items-center">
        <div class="logo">
            <img src="img/logo/trang.png" alt="Logo" width="100">
        </div>
        <div class="dropdown">
            <button class="btn btn-secondary" type="button" id="dropdownMenuButton">
                <i class="fas fa-user"></i>
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item" href="./HomePage">Home</a>
            </div>
        </div>
    </div>
    <h2 class="mt-3 text-center">Order Details</h2>
    <div class="progress mb-4">
        <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" role="progressbar"></div>
    </div>
    <div class="order-status">
        <span>Order Placed</span>
        <span>Packed</span>
        <span>Shipping</span>
        <span>Delivered</span>
    </div>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Order ID: <c:out value="${order.order_ID}"/></h5>
            <p class="card-text">Order Date: <c:out value="${order.order_date}"/> <span class="badge badge-success">Paid</span></p>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Products</th>
                    <th>Items</th>
                    <th>Status</th>
                    <th>Amounts</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td>
                            <img src="img/product/${item.product.img.imgUrl}" alt="${item.product.productName}" width="50">
                            <c:out value="${item.product.productName}"/>
                        </td>
                        <td><c:out value="${item.quantity}"/></td>
                        <td><span id="currentStatus"><c:out value="${order.order_status}"/></span></td>
                        <td>$<c:out value="${item.price_unit}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <form id="updateStatusForm" class="mt-4">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="orderId" value="<c:out value='${order.order_ID}'/>">
                <div class="form-group">
                    <label for="status">Update Order Status:</label>
                    <select class="form-control" id="status" name="status">
                        <option value="Order Placed">Order Placed</option>
                        <option value="Packed">Packed</option>
                        <option value="Shipping">Shipping</option>
                        <option value="Delivered">Delivered</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary" onclick="updateStatus()">Update Status</button>
            </form>

        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="order-summary">
                <h5>Order Summary</h5>
                <p>Sub Total: <span class="float-right">$<c:out value="${order.total_mount}"/></span></p>
                <p>Shipping Charge: <span class="float-right">$<c:out value="${order.ship.ship_cost}"/></span></p>
                <p><strong>Total Amount:</strong> <span class="float-right">$<c:out value="${order.total_mount}"/></span></p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="payment-details">
                <h5>Payment Details</h5>
                <p>Payment Method: <span class="float-right">Credit Card</span></p>
                <p><strong>Total Amount:</strong> <span class="float-right">$<c:out value="${order.total_mount}"/></span></p>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Update progress bar based on order status
            var orderStatus = document.getElementById("currentStatus").innerText.trim();
            updateProgressBar(orderStatus);

            // Dropdown menu toggle
            document.getElementById("dropdownMenuButton").addEventListener("click", function () {
                var dropdownMenu = this.nextElementSibling;
                dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
            });

            window.addEventListener("click", function (event) {
                var dropdown = document.querySelector(".dropdown");
                if (!dropdown.contains(event.target)) {
                    var dropdownMenu = dropdown.querySelector(".dropdown-menu");
                    dropdownMenu.style.display = "none";
                }
            });
        });

        function updateStatus() {
            var form = document.getElementById("updateStatusForm");
            var formData = new FormData(form);

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "./Order?action=update", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onload = function () {
                if (xhr.status === 200) {
                    var selectedStatus = document.getElementById("status").value;
                    document.getElementById("currentStatus").innerText = selectedStatus;
                    updateProgressBar(selectedStatus);
                } 
            };

            xhr.onerror = function () {
                alert("Failed to update order status.");
            };

            xhr.send(new URLSearchParams(formData));
        }

        function updateProgressBar(status) {
            var progressBar = document.querySelector(".progress-bar");
            var statusWidth = {
                "Order Placed": "25%",
                "Packed": "50%",
                "Shipping": "75%",
                "Delivered": "100%"
            };

            progressBar.style.width = statusWidth[status] || "0%";
        }
    </script>
</body>
</html>
