<%-- 
    Document   : feedbackphanhoi
    Created on : May 21, 2024, 8:41:19 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đánh Giá Sản Phẩm</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-8">
                    <h1>Đánh Giá Sản Phẩm</h1>
                    <form action="submitFeedback" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="user_ID">ID_User:</label>
                            <select name="user_ID" id="user_ID" class="form-control">
                                <c:forEach var="i" begin="1" end="5">
                                    <option value="${i}">${i}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="detal">Đánh Giá:</label>
                            <input type="text" name="detal" id="detal" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="img">Hình Ảnh:</label>
                            <input type="text" name="img" id="img" class="form-control">
                        </div>
                        <button type="submit" name="submit" class="btn btn-primary">Submit Feedback</button>
                    </form>
                </div>
                <div class="col-md-4">
                    <jsp:include page="sidebar.jsp" />
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies (Optional) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>