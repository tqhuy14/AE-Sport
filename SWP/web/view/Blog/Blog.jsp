<%-- 
    Document   : Blog
    Created on : May 28, 2024, 4:05:08 PM
    Author     : Hoàng Sơn
--%>
<%@page import="data.BlogContext"%>
<%@page import="entity.Blog"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Tin Tức</title>
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


            .fixed-height {
                height: 4em;

            }
            .fixed-size-img {
                width: 100%;
                height: 250px;
                object-fit: cover;
            }

        </style>
        <%
            Blog blog = (Blog) request.getAttribute("blog");
            Blog mainBlog = (Blog) request.getAttribute("mainBlog");
            ArrayList<Blog> list = (ArrayList<Blog>) request.getAttribute("list");
            ArrayList<Blog> listBlogbyCate = (ArrayList<Blog>) request.getAttribute("listBlogbyCate");
        %>
    </head>
    <body>
        <jsp:include page="../HomePage/header.jsp"/>
        <header class=" m-200 py-5 bg-light border-bottom mb-4">

            <div class="text-center my-3">
                <h1 class="fw-bolder">Tin Tức</h1>
            </div>

        </header>

        <div class="container mb-4">
            <div class="row">


                <%  if (listBlogbyCate != null) {%>
                <nav aria-label="breadcrumb " >
                    <ol class="breadcrumb m-5 ms-0 transition-1">
                        <li class="breadcrumb-item"><span><i class="bi bi-house-door mx-3"></i></span><a href="HomePage" class="text-decoration-none text-black">Home</a></li>
                        <li class="breadcrumb-item"><a href="BlogList?page=1" class="text-decoration-none text-black">Tin Tức</a></li>

                        <li class="breadcrumb-item active" aria-current="page"><%= listBlogbyCate.get(0).getCa().getName()  %></li>

                    </ol>
                </nav>
                <%for (Blog bl : listBlogbyCate) {%>
                <div class="col-4">

                    <div class="card mb-4  ">

                        <img
                            class="card-img-top fixed-size-img"
                            src="img/blog/<%=bl.getImg()%>"
                            alt="..."
                            />
                        <div class="card-body">
                            <div class="small text-muted"><%=bl.getDate()%></div>
                            <h2 class="card-title h4 fixed-height"><%=bl.getTitle()%></h2>

                            <a class="btn btn-primary" href="BlogList?blogID=<%=bl.getBlog_ID()%>">Chi Tiết→</a>
                        </div>
                    </div>   

                </div> 
                <% }
                    }else{%>
                <%if (blog == null) {%> 
                <nav aria-label="breadcrumb " >
                    <ol class="breadcrumb m-5 ms-0 transition-1">
                        <li class="breadcrumb-item"><span><i class="bi bi-house-door mx-3"></i></span><a href="HomePage" class="text-decoration-none text-black">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Tin Tức</li>
                    </ol>
                </nav>
                <div  class="row">
                    <div class="col-lg-8">

                        <div class="card mb-4">

                            <img
                                class="card-img-top"
                                src="img/blog/<%=mainBlog.getImg()%>"
                                alt="..."
                                />
                            <div class="card-body">
                                <div class="small text-muted"><%=mainBlog.getDate()%></div>
                                <h2 class="card-title"><%=mainBlog.getTitle()%></h2>

                                <a class="btn btn-primary" href="BlogList?blogID=<%=mainBlog.getBlog_ID()%>">Chi Tiết →</a>
                            </div>
                        </div>



                    </div>
                    <div class="col-lg-4">

                        <div class="card mb-4">
                            <div class="card-header">Tìm Kiếm Bài Viết</div>
                            <div class="card-body">
                                <div >
                                    <input
                                        class="form-control"
                                        type="text"
                                        placeholder="Tìm Kiếm Bài Viết"
                                        aria-label="Tìm Kiếm Bài Viết"
                                        aria-describedby="button-search"
                                        />
                                    <button
                                        class="btn btn-primary float-end my-3"
                                        id="button-search"
                                        type="button"
                                        >
                                        Tìm!
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header">Doanh Mục</div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <ul class="list-unstyled mb-0">
                                            <li><a href="BlogList?categoryBlog=1">Thể Thao</a></li>
                                            <li><a href="BlogList?categoryBlog=2">Sức Khỏe</a></li>
                                            <li><a href="BlogList?categoryBlog=3">Thời Trang</a></li>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="row">
                    <%
                        for (Blog bl : list) {
                            if (mainBlog.getBlog_ID() != bl.getBlog_ID()) {


                    %>

                    <div class="col-4">

                        <div class="card mb-4  ">

                            <img
                                class="card-img-top fixed-size-img"
                                src="img/blog/<%=bl.getImg()%>"
                                alt="..."
                                />
                            <div class="card-body">
                                <div class="small text-muted"><%=bl.getDate()%></div>
                                <h2 class="card-title h4 fixed-height"><%=bl.getTitle()%></h2>

                                <a class="btn btn-primary" href="BlogList?blogID=<%=bl.getBlog_ID()%>">Chi Tiết→</a>
                            </div>
                        </div>   

                    </div> 
                    <%   }
                        }
                    %>
                    <nav aria-label="Page navigation example  " >
                        <ul class="pagination justify-content-center my-4">
                            <li class="page-item"><a class="page-link" href="BlogList?page=${param.page-1}">Previous</a></li>
                                <c:forEach var="i" begin="1" end="3">
                                <li class="page-item ${param.page == i ? 'active' : ''}">
                                    <a class="page-link" href="BlogList?page=${i}">${i}</a>
                                </li>   
                            </c:forEach>
                            <li class="page-item"><a class="page-link" href="BlogList?page=${param.page+1}">Next</a></li>
                        </ul>
                    </nav>
                </div>

                <%} else {%>
                <nav aria-label="breadcrumb " >
                    <ol class="breadcrumb ms-5  mt-5">
                        <li class="breadcrumb-item"><span><i class="bi bi-house-door mx-3"></i></span><a href="HomePage" class="text-decoration-none text-black">Home</a></li>
                        <li class="breadcrumb-item"><a href="BlogList?page=1" class="text-decoration-none text-black">Tin Tức</a></li>

                        <li class="breadcrumb-item active" aria-current="page"><%=blog.getTitle()%></li>
                    </ol>
                </nav>
                <div class="row">
                    <div class="col-lg-8 my-5">
                        <h2 class=" mx-5"><%=blog.getTitle()%></h2>
                        <h6 class="col-10 text-end m-5 me-5 fst-italic text-body-secondary"><%=blog.getDate()%></h6>
                        <img
                            src="img/blog/<%=blog.getImg()%>"
                            class="rounded mx-auto d-block my-5 img-fluid"
                            alt="..."
                            />
                        <div class="ms-5"><%= blog.getDetail()%></div>
                    </div>
                    <div class="col-lg-4  px-5">

                        <div class="card mb-4">
                            <div class="card-header">Tìm Kiếm Bài Viết</div>
                            <div class="card-body">
                                <div >
                                    <input
                                        class="form-control"
                                        type="text"
                                        placeholder="Tìm Kiếm Bài Viết"
                                        aria-label="Tìm Kiếm Bài Viết"
                                        aria-describedby="button-search"
                                        />
                                    <button
                                        class="btn btn-primary float-end my-3"
                                        id="button-search"
                                        type="button"
                                        >
                                        Tìm!
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4 ">
                            <div class="card-header">Doanh Mục</div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <ul class="list-unstyled mb-0">
                                            <li><a href="BlogList?categoryBlog=1">Thể Thao</a></li>
                                            <li><a href="BlogList?categoryBlog=3">Sức Khỏe</a></li>
                                            <li><a href="BlogList?categoryBlog=2">Thời Trang</a></li>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>




                <%}
                %>

                <%    }
                %>
            </div>

        </div>
        <jsp:include page="../HomePage/footer.jsp"/>

    </body>
</html>
