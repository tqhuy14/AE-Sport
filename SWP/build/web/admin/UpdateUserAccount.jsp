<%-- 
    Document   : UpdateUserAccount.jsp
    Created on : May 25, 2024, 7:09:40 PM
    Author     : admin
--%>

<%@page import="Model.Role"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/update.css">
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
                    <h1 style="font-family: initial">Update Role for Account ID: <%= request.getAttribute("uID")%></h1>
                    <%
                        ArrayList<Role> list = (ArrayList<Role>) request.getAttribute("list");
                    %>
                    <form action="updateaccount" method="post" style="font-weight: bold">
                        <input value="<%= request.getAttribute("uID")%>" name="uID" type="hidden"/>
                        <%
                            if (list != null) {
                                for (Role item : list) {
                        %>
                        <div>
                            <input type="radio" name="role" value="<%= item.getRoleID() %>"">
                            <label for="<%= item.getRoleID() %>"><%= item.getRoleName() %></label>
                        </div>
                        <%
                            }
                        %>
                        <div>
                            <input type="radio" name="role" value="user""> user
                        </div>
                        <%
                        } else {
                        %>
                        <p>No roles available to update.</p>
                        <%
                            }
                        %>
                        <input type="submit" value="Update Roles">
                    </form>
                </div>

            </div>
    </body>
</html>
