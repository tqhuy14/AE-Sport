<%-- 
    Document   : ManagerSize
    Created on : Jun 6, 2024, 3:02:47 PM
    Author     : admin
--%>

<%@page import="Model.Size"%>
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
                    <h1 style="padding: 10px">Danh sách Size</h1>
                    <%
                        ArrayList<Size> list = (ArrayList<Size>) request.getAttribute("list");
                        if (list == null || list.size() == 0) {
                    %>
                    <h5>Chưa có Size nào</h5>

                    <form action="managersize" method="post" class="search-form">
                        <div>
                            <input value="${param.sizename}" type="text" name="sizename" placeholder="Nhập size" class="search-input" required="">
                            <select name="sizetype" class="search-button" style="border-radius: 0;border: 1px solid gray">
                                <option value="Size chữ" >Size chữ</option>
                                <option value="Size số" >Size số</option>
                            </select>
                            <input type="submit" value="Thêm" class="search-button">
                        </div>
                        <div><h5 style="color: red; padding: 5px">${error}</h5></div>
                    </form>


                    <%
                    } else {
                    %>
                    <div style="display: flex; justify-content: space-between;">
                        <h5 style="padding: 10px">Tổng <%=list.size()%> size </h5>
                        <div>
                            <form action="managersize" method="post" class="search-form">
                                <input required=""value="${param.sizename}" type="text" name="sizename" placeholder="Nhập size" class="search-input">
                                <select name="sizetype" class="search-button" style="border-radius: 0;border: 1px solid gray">
                                    <option value="Char">Size chữ</option>
                                    <option value="Number">Size số</option>
                                </select>
                                <input type="submit" value="Thêm" class="search-button">
                            </form>
                            <h5 style="color: red; padding: 5px; font-size: 13px">${error}</h5>
                        </div>

                    </div>

                    <table border="1px solid" style="border-collapse: collapse">
                        <tr>
                            <th>SizeID</th>
                            <th>SizeType</th>
                            <th>SizeName</th>
                            <th>Thao Tác</th>
                        </tr>
                        <%
                            for (Size s : list) {
                        %>
                        <tr>
                            <td><%= s.getSize_ID() %></td>
                            <td><%= s.getSize_Type() %></td>
                            <td><%= s.getSize_Name() %></td>

                            <td>
                                <a href="managersize?sizeID=<%= s.getSize_ID() %>" class="delete-link" onclick="return confirm('Bạn có chắc muốn xóa không?');">Delete</a> &nbsp;&nbsp;

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
