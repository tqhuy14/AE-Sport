<%-- 
    Document   : HomeStaff
    Created on : Jun 16, 2024, 5:37:30 PM
    Author     : Hoàng Sơn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>'
        <style>
            .btn {
                font-size: 17px;
                background: transparent;
                border: none;
                padding: 1em 1.5em;
                color: #ffedd3;
                text-transform: uppercase;
                position: relative;
                transition: 0.5s ease;
                cursor: pointer;
            }

            .btn::before {
                content: "";
                position: absolute;
                left: 0;
                bottom: 0;
                height: 2px;
                width: 0;
                background-color: #ffc506;
                transition: 0.5s ease;
            }

            .btn:hover {
                color: #1e1e2b;
                transition-delay: 0.5s;
            }

            .btn:hover::before {
                width: 100%;
            }

            .btn::after {
                content: "";
                position: absolute;
                left: 0;
                bottom: 0;
                height: 0;
                width: 100%;
                background-color: #ffc506;
                transition: 0.4s ease;
                z-index: -1;
            }

            .btn:hover::after {
                height: 100%;
                transition-delay: 0.4s;
                color: aliceblue;
            }

        </style>
    </head>
    <body>
        <div class="row">
            <div class="col-1">
                <jsp:include page="../Homestaff/SideBar.jsp"/>
            </div>
            <div class=" col-11">
                <div class="container">
                    <a href="HomePage">
                        <button class="btn">Home Page</button>

                    </a>
                </div>

            </div>
    </body>
</html>
