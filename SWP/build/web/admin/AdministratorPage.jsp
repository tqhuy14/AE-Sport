<!DOCTYPE html>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/tab.css">
        <style>
            .submenu {
                display: none;
                list-style-type: none;
                padding-left: 20px;
            }

            .menu-item.active .submenu {
                display: block;
            }

            .submenu-item {
                padding: 5px 0;
                width: 200px

            }

            ul{
                width: 100%

            }

            li{
                width: 150%
            }

            .menu-item {
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div id="logo">
                <a href="${pageContext.request.contextPath}/HomePage">
                    <i class="bi bi-house-fill" style="padding-right: 7px"></i>Home
                </a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/manageruseraccount">
                    <i class="bi bi-person" style="padding-right: 7px"></i> Quản Lý Người Dùng
                </a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/manageremployeeaccount">
                    <i class="bi bi-person-gear" style="padding-right: 7px"></i> Quản Lý Nhân Viên
                </a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/managerrole">
                    <i class="bi bi-microsoft-teams" style="padding-right: 7px"></i> Quản Lý Role
                </a>
            </div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/managerfeature">
                    <i class="bi bi-arrow-left-right" style="padding-right: 7px"></i> Quản Lý Chức Năng
                </a>
            </div>

            <div class="menu-item flex-column" onclick="toggleSubmenu(this)">
                <a><i class="bi bi-border-width" style="padding-right: 7px"></i> Sản Phẩm</a>

                <ul style="" class="submenu">
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managerproduct"><i class="bi bi-bag-dash-fill" style="padding-right: 7px"></i>Danh Sách Sản Phẩm</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managerdiscount"><i class="bi bi-calendar2-event" style="padding-right: 7px" ></i>Danh Sách Sự Kiện</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managerbrand"><i class="bi bi-buildings" style="padding-right: 7px"></i>Danh Sách Thương Hiệu</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managersport"><i class="bi bi-cookie" style="padding-right: 7px" ></i>Môn Thể Thao</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managersize"><i class="bi bi-box2" style="padding-right: 7px" ></i>Kích Cỡ</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managercolor"><i class="bi bi-palette" style="padding-right: 7px" ></i>Màu Sắc</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managercategory"><i class="bi bi-journals" style="padding-right: 7px" ></i>Danh Sách Danh Mục</a></li>
                    <li class="submenu-item"><a style="width: 120%" href="${pageContext.request.contextPath}/managersubcategory"><i class="bi bi-journal" style="padding-right: 7px" ></i>Danh Sách Thể Loại</a></li>                 
                </ul>
            </div>
        </div>

        <script>
            function toggleSubmenu(element) {
                element.classList.toggle('active');
            }
        </script>

    </body>
</html>
