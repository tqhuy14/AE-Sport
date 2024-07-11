<%-- 
    Document   : productDetail
    Created on : Jun 6, 2024, 11:12:04 PM
    Author     : Hoàng Sơn
--%>

<%@page import="entity.product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product</title>
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
            .form-check-input {
                display: none;
            }
            .form-check-label {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: inline-block;
                cursor: pointer;
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .form-check-input:checked + .form-check-label {
                border: 4px solid #000;
                box-shadow: 0 0 20px rgba(0, 123, 255, 0.5); /* Hiệu ứng bóng */
            }
            input[type="number"]::-webkit-outer-spin-button,
            input[type="number"]::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            input[type="number"] {
                -moz-appearance: textfield;
            }

            .yellow-star {
                color: yellow;
                font-size: 28px; /* Kích thước của sao */
            }

            .btn-check:checked + label  {
                border: 2px solid #007bff;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.5); /* Hiệu ứng bóng */
            }
            .btn-check + label {
                border: 2px solid transparent;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            .card-title {
                color: #db0075;
            }
            .card-text {
                color: #17E6E6;
            }
            .list-inline-item {
                color: #ffd700
            }
            .price {
                color: #d92644;
            }
            .btn-pink {
                background-color: #fcb2b2 !important;
            }
        </style>
    </head>


    <body>
        <jsp:include page="../HomePage/header.jsp"/>
        <div class="m-223 container  ">
            <nav aria-label="breadcrumb" >
                <ol class="breadcrumb m-5 ms-0 transition-1">
                    <li class="breadcrumb-item">
                        <span><i class="bi bi-house-door mx-3"></i></span>
                        <a href="HomePage" class="text-decoration-none text-black">Home</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Sản Phẩm</li>
                </ol>
            </nav>

            <div class="row  ">
                <div class="col-6 px-0 ">
                    <img src="img/product/${requestScope.listImg.get(o).url}" style="width: 600px; height: 600px;" id="largeImage" class="img-thumbnail" alt="...">
                    <div class="row mt-3">
                        <c:forEach var="img" items="${requestScope.listImg}">
                            <div class="col-2 px-0">
                                <img src="img/product/${img.url}" class="img-thumbnail thumbnail-image" alt="Thumbnail${img.id}">
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="col-6 ps-5">
                    <h2 class="mt-5">${productDetail.productName}</h2>
                    <div class="d-flex">
                        <div class="d-flex">
                            <span class="yellow-star">&#9733;</span>
                            <span class="yellow-star">&#9733;</span>
                            <span class="yellow-star">&#9733;</span>
                            <span class="yellow-star">&#9733;</span>
                            <span class="yellow-star">&#9733;</span>
                            <p class="mb-0 d-flex align-items-center">(5/5)</p>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="mx-3">&#124;</span>
                            <p class="font-monospace mb-0">Đã bán ${productDetail.getQuantity_sold()} sản phẩm</p>
                        </div>
                    </div>

                    <form action="Product" method="post" id="productForm">
                        <input type="hidden" name="productId" value="${param.productId}"/>
                        <label for="size">Size</label>
                        <div id="size-options" class="mt-3 ms-3">
                            <div id="sizeForm" class="d-flex">
                                <c:forEach var="size" items="${listSize}">
                                    <input type="radio" class="btn-check size-radio" name="size" id="size${size.size_ID}" value="${size.size_ID}" autocomplete="off">
                                    <label class="btn mx-1 bg-body-tertiary d-flex justify-content-center align-items-center" for="size${size.size_ID}">${size.size_Name}</label>
                                </c:forEach>
                            </div>
                        </div>

                        <label for="color">Màu</label>
                        <div class="d-flex mt-3 justify-content-start">
                            <c:forEach var="color" items="${listColor}">
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" id="radio${color.color_Name}" name="color" value="${color.color_Name}">
                                    <label class="form-check-label" style="background-color:${color.color_Name}; width: 30px; height: 30px" for="radio${color.color_Name}"></label>
                                </div>
                            </c:forEach>
                        </div>

                        <label for="quantity">Số lượng</label>
                        <div class="my-3 d-flex align-items-center">
                            <div class="input-group">
                                <button class="btn btn-dark input-group-text" id="decreaseBtn" type="button">-</button>
                                <input type="number" class="form-control text-center" id="numberInput" name="number" value="1" readonly>
                                <button class="btn btn-dark input-group-text" id="increaseBtn" type="button">+</button>
                            </div>
                        </div>


                        <label for="price">Giá bán</label>
                        <h1 class="text-danger w-50 text-center">${productDetail.price}đ</h1>
                        <div class="mt-3">
                            <button type="submit" class="fs-5 btn btn-danger w-50" value="1" name="action" id="buyNowBtn">Mua Ngay!</button>
                            <button type="submit" class="fs-4 btn ms-2 bg-body-tertiary text-danger" value="2" name="action" id="addToCartBtn"><i class="bi bi-cart-plus"></i></button>
                        </div>
                    </form>

                </div>

                <div class="text-dark my-5">
                    <hr>
                </div>
                <div class="row w-100 ">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active text-black" id="detail-tab" data-bs-toggle="tab" data-bs-target="#detail-tab-pane" type="button" role="tab" aria-controls="detail-tab-pane" aria-selected="true">Chi tiết sản phẩm</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link  text-black" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="false">Mô tả sản phẩm</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link text-black" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Đánh Giá</button>
                        </li>
                    </ul>

                    <div class="tab-content mt-5" id="myTabContent">
                        <div class="tab-pane fade show active" id="detail-tab-pane" role="tabpanel" aria-labelledby="detail-tab" tabindex="0">
                            <p class="fw-semibold">Doanh Mục:<span class="fw-normal">   
                                    <c:if test="${productDetail.cate.type == 'nam'}">Nam</c:if>
                                    <c:if test="${productDetail.cate.type == 'nu'}">Nữ</c:if>
                                    <c:if test="${productDetail.cate.type == 'phu_kien'}">Phụ Kiện</c:if>
                                    <c:if test="${productDetail.cate.type == 'the_thao'}">Thể Thao</c:if>
                                    <c:if test="${productDetail.cate.type == 'thuong_hieu'}">Thương Hiệu</c:if>
                                    / ${productDetail.cate.category_Name} </span>
                            </p>
                            <p class="fw-semibold">Loại trang phục: <span class="fw-normal">:${productDetail.getSubCate().getSubcategory_Name()} </span></p>
                            <p class="fw-semibold">Xuất xứ::  <span class="fw-normal">Việt Nam</span> </p>
                        </div>

                        <div class="tab-pane fade show " id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">${productDetail.description}</div>
                        <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">.dsfdsfsdfsdfsd..</div>
                    </div>
                </div>
            </div>

            <div class="border-start border-5 border-black border-opacity-75 mt-5">
                <h2 class="w-100 ms-3">SẢN PHẨM LIÊN QUAN</h2>
            </div>
            <div>   

            </div>



        </div>           
    </div>
    <jsp:include page="../HomePage/footer.jsp"/>
    <script>
        const numberInput = document.getElementById('numberInput');
        const increaseBtn = document.getElementById('increaseBtn');
        const decreaseBtn = document.getElementById('decreaseBtn');

        increaseBtn.addEventListener('click', function (event) {
            event.preventDefault();
            numberInput.stepUp();
        });
        decreaseBtn.addEventListener('click', function (event) {
            event.preventDefault();
            if (numberInput.value > 1) {
                numberInput.stepDown();
            }
        });

        var thumbnailImages = document.querySelectorAll('.thumbnail-image');
        thumbnailImages.forEach(function (image) {
            image.addEventListener('click', function () {
                var smallImageUrl = this.src;
                document.getElementById('largeImage').src = smallImageUrl;
            });
        });

        document.getElementById("productForm").addEventListener("submit", function (event) {
            var sizeSelected = document.querySelector('input[name="size"]:checked');
            var colorSelected = document.querySelector('input[name="color"]:checked');

            if (!colorSelected && !sizeSelected) {
                event.preventDefault();
                alert("Vui lòng chọn Màu và Size tiếp tục.");
            }

            if (!sizeSelected && colorSelected) {
                event.preventDefault();
                alert("Vui lòng chọn Size tiếp tục.");
            }
            if (!colorSelected && sizeSelected) {
                event.preventDefault();
                alert("Vui lòng chọn Màu tiếp tục.");
            }

        });




    </script>
</body>
</html>
