<%-- 
    Document   : ManagerColor
    Created on : Jun 6, 2024, 2:43:44 PM
    Author     : admin
--%>

<%@page import="Model.Color"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/table.css">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
            />
    </head>
    <body>
        <div class="row">
            <div class="col-2 border-4 border-black" style="padding-right: 0px;">
                <jsp:include page="AdministratorPage.jsp"/>
            </div>


            <div class="col-10" style="background: #e2e7e8">
                <jsp:include page="HeaderAdmin.jsp"/>

                <div style="margin: 30px; background: white;padding: 20px;border-radius: 10px" >
                    <h1 style="padding: 10px">Danh sách màu</h1>
                    <%
                        ArrayList<Color> list = (ArrayList<Color>) request.getAttribute("list");
                        if (list == null || list.size() == 0) {
                    %>
                    <h5>Chưa có màu nào</h5>

                    <form action="managercolor" method="post" class="search-form">
                        <div>
                            <input value="${param.colorname}" type="text" name="colorname" placeholder="Nhập màu" class="search-input" required="">
                            <input type="submit" value="Thêm" class="search-button">
                        </div>
                        <div><h5 style="color: red; padding: 5px">${error}</h5></div>
                    </form>


                    <%
                    } else {
                    %>
                    <div style="display: flex; justify-content: space-between;">
                        <h5 style="padding: 10px">Tổng <%=list.size()%> màu </h5>
                        <div>
                            <form action="managercolor" method="post" class="search-form">
                                <input required=""value="${param.colorname}" type="text" name="colorname" placeholder="Nhập màu" class="search-input">
                                <input type="submit" value="Thêm" class="search-button">
                            </form>
                            <h5 style="color: red; padding: 5px; font-size: 13px">${error}</h5>
                        </div>

                    </div>

                    <table border="1px solid" style="border-collapse: collapse">
                        <tr>
                            <th>ColorID</th>
                            <th>ColorName</th>
                            <th>Thao Tác</th>
                        </tr>
                        <%
                            for (Color c : list) {
                        %>
                        <tr>
                            <td><%= c.getColor_ID() %></td>
                            <td><%= c.getColor_Name() %></td>

                            <td>
                                <a href="managercolor?colorID=<%= c.getColor_ID() %>" class="delete-link" onclick="return confirm('Bạn có chắc muốn xóa không?');">Delete</a> &nbsp;&nbsp;

                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table><br/>

                    <%
                        }
                    %>
                </div>
            </div>
    </body>
</html>
