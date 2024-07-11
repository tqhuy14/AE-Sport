<%-- 
    Document   : requestBlog
    Created on : Jun 21, 2024, 11:18:19 AM
    Author     : Hoàng Sơn
--%>


<%@page import="entity.Blog"%>
<%@page import="java.util.ArrayList"%>
<%@page import="data.BlogContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yêu Cầu</title>
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

            .rounded-table {
                border: 2px solid #000; /* Tạo viền ngoài cho bảng */
                border-radius: 15px;
                overflow: hidden;
            }
            .custom-alert {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 30px;
                background-color: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
                border-radius: 12px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                max-width: 500px;
                width: 90%;
                text-align: center;
                margin-top: 100px;
            }

            .custom-alert .alert-icon {
                font-size: 3rem;
                margin-bottom: 20px;
            }


        </style>
        <script>
            function submit() {
                document.getElementsByClassName("form").submit();
            }
        </script>
    </head>

    <body class="bg-dark p-2 text-dark bg-opacity-25">
        <div class="row">
            <div class="col-1">
                <jsp:include page="../Homestaff/SideBar.jsp"/>
            </div>
            <div class="col-11">
                <div class="container mt-5 ">

                    <c:if test="${ not empty requestScope.requestAdd}"  >
                        <h1 class=" my-4 ">Yêu cầu thêm tin tức</h1> 
                        <table class="table  table-hover table-dark  rounded-table shadow ">
                            <thead class="table-dark align-middle">
                                <tr>
                                    <th class="p-4 text-center" >#</th>
                                    <th class="p-4 text-center" >Tiêu Đề</th>
                                    <th class="p-4 text-center">Ảnh</th>
                                    <th class="p-4 text-center">Doanh Mục</th>
                                    <th class="p-4 text-center" >Tác Giả</th>
                                    <th class="p-4 text-center" >Ngày Đăng</th>
                                    <th class="p-4 text-center" ></th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider table-divider-color">
                                <c:forEach items="${requestScope.requestAdd}" var="elem">
                                    <tr class="p-3 text-center ">
                                        <th class="p-2">${ elem.getBlog_ID()}</th>
                                        <td class="text-start">${ elem.getTitle()}</td>
                                        <td> 
                                            <span  type="button"  data-bs-toggle="modal" data-bs-target="#firstModal${ elem.getBlog_ID()}">
                                                ${ elem.getImg()}
                                            </span>

                                        </td>
                                        <td> 
                                            <span>${ elem.getCa().getName()   }</span>
                                        </td>
                                        <td> 
                                            <span>${ elem.getAuthorString()}</span>

                                        </td>
                                        <td> 
                                            <span>${ elem.getDate()}</span>

                                        </td>


                                        <td class="text-start"  style="width: 4rem"> 
                                            <div class="btn-group" role="group" >
                                                <form  method="post" action="RequestsBlog">
                                                    <input type="hidden" name="accept"  value="${ elem.getBlog_ID()}">
                                                    <input type="hidden" name="type"  value="add">

                                                    <button onclick="submit()"   class="btn btn-outline-primary">Duyệt</button>
                                                </form>
                                                <form   method="post" action="RequestsBlog">
                                                    <input type="hidden" name="type"  value="add">
                                                    <input type="hidden" name="reject" value="${ elem.getBlog_ID()}">
                                                    <button onclick="submit()" class="btn btn-outline-danger">Xóa</button>
                                                </form>

                                            </div>
                                        </td>

                                    </tr>
                                <div class="img modal fade" id="firstModal${ elem.getBlog_ID()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <img src="img/blog/${ elem.getImg()}" class="img-fluid" alt="${ elem.getBlog_ID()}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>




                            </tbody>
                        </table>



                    </c:if>
                    <c:if test="${ empty requestScope.requestAdd &&   empty requestScope.requestDelete}"  >
                        <div class="custom-alert alert alert-danger" role="alert">
                            <div class="alert-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-exclamation-triangle" viewBox="0 0 16 16">
                                <path d="M8.854 1.303a1.145 1.145 0 0 1 1.292 0l5.579 3.719A1.145 1.145 0 0 1 16 6.822v6.356a1.145 1.145 0 0 1-.275.8l-5.579 3.72a1.145 1.145 0 0 1-1.292 0L2.275 14.978a1.145 1.145 0 0 1-.275-.8V6.822a1.145 1.145 0 0 1 .275-.8l5.579-3.719zM8.5 12a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1zm-1-4a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM8 2.196L4.854 5.303a.145.145 0 0 0-.042.103v6.356c0 .037.014.072.04.099l3.146 3.303a.145.145 0 0 0 .204 0l3.146-3.303a.145.145 0 0 0 .04-.099V5.406a.145.145 0 0 0-.042-.103L8 2.196z"/>
                                </svg>
                            </div>
                            <div>
                                <strong>Thông báo:</strong> Không có yêu cầu nào !
                            </div>
                        </div>
                    </c:if>



                    <c:if test="${ not empty requestScope.requestDelete}"  >
                        <h1 class=" my-4 ">Yêu cầu xóa tin tức</h1> 
                        <table class="table  table-hover table-dark  rounded-table shadow ">
                            <thead class="table-dark align-middle">
                                <tr>
                                    <th class="p-4 text-center" >#</th>
                                    <th class="p-4 text-center" >Tiêu Đề</th>
                                    <th class="p-4 text-center">Ảnh</th>
                                    <th class="p-4 text-center">Doanh Mục</th>
                                    <th class="p-4 text-center" >Tác Giả</th>
                                    <th class="p-4 text-center" >Ngày Đăng</th>
                                    <th class="p-4 text-center" ></th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider table-divider-color">
                                <c:forEach items="${requestScope.requestDelete}" var="elem">
                                    <tr class="p-3 text-center ">
                                        <th class="p-2">${ elem.getBlog_ID()}</th>
                                        <td class="text-start">${ elem.getTitle()}</td>
                                        <td> 
                                            <span  type="button"  data-bs-toggle="modal" data-bs-target="#firstModal${ elem.getBlog_ID()}">
                                                ${ elem.getImg()}
                                            </span>

                                        </td>
                                        <td> 
                                            <span>${ elem.getCa().getName()   }</span>
                                        </td>
                                        <td> 
                                            <span>${ elem.getAuthorString()}</span>

                                        </td>
                                        <td> 
                                            <span>${ elem.getDate()}</span>

                                        </td>


                                        <td class="text-start"  style="width: 4rem"> 
                                            <div class="btn-group" role="group" >
                                                <form  method="post" action="RequestsBlog">
                                                    <input type="hidden" name="type"  value="delete">
                                                    <input type="hidden" name="accept"  value="${ elem.getBlog_ID()}">
                                                    <button onclick="submit()"   class="btn btn-outline-primary">Duyệt</button>
                                                </form>
                                                <form   method="post" action="RequestsBlog">
                                                    <input type="hidden" name="type"  value="delete">
                                                    <input type="hidden" name="reject" value="${ elem.getBlog_ID()}">
                                                    <button onclick="submit()" class="btn btn-outline-danger">Xóa</button>
                                                </form>

                                            </div>
                                        </td>

                                    </tr>
                                <div class="img modal fade" id="firstModal${ elem.getBlog_ID()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <img src="img/blog/${ elem.getImg()}" class="img-fluid" alt="${ elem.getBlog_ID()}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>




                            </tbody>
                        </table>



                    </c:if>


                </div>
            </div>
        </div>


        <script>


        </script>

    </body>
</html>
