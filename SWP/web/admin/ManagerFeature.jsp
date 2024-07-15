<%-- 
    Document   : FeatureManager
    Created on : May 21, 2024, 8:31:10 AM
    Author     : admin
--%>

<%@page import="Model.Feature"%>
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
        
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }

            table th, table td {
                border: none; /* Remove all borders */
                padding: 8px;
                text-align: center;
            }

            table tr {
                border-bottom: 1px solid #ddd; /* Add a border only to the bottom of each row */
                background: #f8f9fa;
            }

            table tr:last-child {
                border-bottom: none; /* Remove the border from the last row */
            }

            table th {
                background-color: #343a40;
            }
        </style>
    </head>
    <body>
        
        <div class="row">
            <div class="col-2 border-4 border-black" style="padding-right: 0px;">
                <jsp:include page="AdministratorPage.jsp"/>
            </div>


            <div class="col-10" style="background: #e2e7e8">
                <jsp:include page="HeaderAdmin.jsp"/>
                
                <div style="margin: 30px; background: white;padding: 20px;border-radius: 10px" >
                <h1 style="padding: 10px">Danh sách chức năng</h1>
                <%
                    ArrayList<Feature> list = (ArrayList<Feature>) request.getAttribute("list");
                    if (list == null || list.size() == 0) {
                %>
                <h5>Chưa có chức năng nào</h5>

                <%
            } else {
                %>
                <table border="1px solid" style="border-collapse: collapse">
                    <tr>
                        <th>FeatureID</th>
                        <th>FeatureName</th>
                        <th>Đường dẫn</th>
                        <th>Thao Tác</th>
                    </tr>
                    <%
                        for (Feature f : list) {
                    %>
                    <tr>
                        <td><%= f.getFu_ID() %></td>
                        <td><%= f.getFu_Name() %></td>
                        <td><%= f.getUrl() %></td>
                        <td>
                            <a href="deletefeature?fID=<%= f.getFu_ID() %>" class="delete-link" onclick="return confirm('Bạn có chắc muốn xóa không?');">Delete</a> &nbsp;&nbsp;

                        </td>
                    </tr>
                    <%
                        }
                    %>
                </table><br/>

                <%
                    }
                %>

                
                <form action="managerfeature" method="post" style="border: 1px; padding: 5px; width: 400px;">
                    <h2>Thêm một chức năng mới</h2>
                    <table style="width: 100%;">
                        <tr>
                            <td style="padding: 4px;">
                                <label for="fuName">Feature Name:</label>
                            </td>
                            <td style="padding: 4px;">
                                <input placeholder="Nhập tên của chức năng" value="${param.fuName}"type="text" id="fuName" name="fuName" required style="width: 100%; padding: 4px;"> <h5 class="fs-6" style="color: red">${error}</h5>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;">
                                <label for="url">URL:</label>
                            </td>
                            <td style="padding: 4px;">
                                <input  placeholder="Nhập đường dẫn của chức năng" value="${param.url}" type="text" id="url" name="url" required style="width: 100%; padding: 4px;"> <h5 class="fs-6" style="color: red">${error2}</h5>
                            </td>
                        </tr>
                         
                    </table>
                            <input type="submit" value="Add Feature" class="search-button" style="margin: 5px; border-radius: 4px;"">
                </form>

                </div>

            </div>
        </div>
    </body>
</html>
