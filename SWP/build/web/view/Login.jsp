<%-- 
    Document   : Login
    Created on : May 21, 2024, 3:49:35 PM
    Author     : Laptop K1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    </head>
    <style>
        .logo {
            max-width: 40%;
            height: auto;
        }
        .slogan {
            text-align: center;
            margin-top: 10px;
            color: white;
        }
        body {
            background: url('https://images.unsplash.com/photo-1563580853176-38535245e8b6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fGZvb3RiYWxsJTIwc3RhZGl1bSUyMGFyc2VuYWx8ZW58MHx8MHx8fDA%3D') no-repeat center center fixed;
            background-size: cover;
            color: white;
        }
        .container {
            background-color: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            color: white;
        }
        .form-control {
            background-color: rgba(255, 255, 255, 0.8);
            color: black;
        }
        .form-label1 {
            color: black;
        }
    </style>
    <body>
        <h3 style="text-align: center">WELCOME TO AESPORT!!!!</h3>
        <div class="container mt-5 w-75">
            <div class="row">
                <div class="col-md-6 text-center">
                    <img src="https://files.oaiusercontent.com/file-sY9HJFIZ3CtsazxwUPrE5dmh?se=2024-05-25T14%3A21%3A25Z&sp=r&sv=2023-11-03&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Dd7aa5c46-1724-47d3-9047-b45716e9e2af.webp&sig=eXEFS9k3AflvDYSNXvr%2BCFblpFHhpFPLl89bDiP8jHs%3D" alt="AESport Logo" class="logo">
                    <div class="slogan">
                        <h4>AESport</h4>
                        <p>Nơi mua bán đồ thể thao hàng đầu tại Hòa Lạc</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="tab-login" data-mdb-pill-init href="#pills-login" role="tab"
                            aria-controls="pills-login" aria-selected="true">Login</a>
                        </li>
                        <li class="nav-item" role="presentation">
                               <a class="nav-link active" data-toggle="modal" data-target="#registerModal" role="tab"
                            aria-selected="true">Register</a>
                            <!-- Modal -->
                            <div class="modal fade" id="registerModal" tabindex="0" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content border rounded-5 p-3 bg-white shadow box-area">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="registerModalLabel">Register</h5>
                                        </div>
                                        <div class="modal-body ">
                                            <!-- Name input -->
                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerName">Full Name</label>
                                                <input type="text" id="registerName" class="form-control" />
                                            </div>

                                            <!-- Username input -->
                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerUsername">Username</label>
                                                <input type="text" id="registerUsername" class="form-control" />
                                            </div>

                                            <!-- Password input -->
                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerEmail">Password</label>
                                                <input type="password" id="registerPass" class="form-control" />
                                            </div>

                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerEmail">Confirm password</label>
                                                <input type="password" id="registercfPass" class="form-control" />
                                            </div>

                                            <!-- Email input -->
                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerEmail">Email</label>
                                                <input type="email" id="registerEmail" class="form-control" />
                                            </div>

                                            <!-- Phone Number input -->
                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerPassword">Phone Number</label>
                                                <input type="text" id="registerPhone" class="form-control" />
                                            </div>

                                            <!-- Address input -->
                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <label class="form-label1" for="registerRepeatPassword">Address</label>
                                                <input type="text" id="registerAddress" class="form-control" />
                                            </div>
                                            <div class="row mb-3 fade bg-danger" id="registerMessageBox">
                                                <div class="col-sm-12 text-secondary">
                                                    <p class="text-white text-center" id="registerMessage"></p>
                                                </div>
                                            </div>
                                            <div class="input-group mb-3">
                                                <button class="btn btn-lg btn-primary w-100 fs-6" onclick="register()">Sign Up</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <!-- Pills navs -->

                    <!-- Pills content -->
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                            <form>
                                <p id="mess" class="bg-danger text-center fade"></p>

                                <!-- Email input -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="email" id="UserName" class="form-control" />
                                    <label class="form-label" for="loginName">Username</label>
                                </div>

                                <!-- Password input -->
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="password" id="Password" class="form-control" />
                                    <label class="form-label" for="loginPassword">Password</label>
                                </div>

                                <!-- 2 column grid layout -->
                                <div class="row mb-4">
                                    <div class="col-md-6 d-flex justify-content-center">
                                        <!-- Checkbox -->
                                        <div class="form-check mb-3 mb-md-0">
                                            <input class="form-check-input" type="checkbox" value="" id="loginCheck" checked />
                                            <label class="form-check-label" for="loginCheck"> Remember me </label>
                                        </div>
                                    </div>

                                    <div class="col-md-6 d-flex justify-content-center">
                                        <!-- Simple link --><small>
                                            <a href="#" data-toggle="modal" data-target="#forgotModal">Forgot Password?</a>
                                        </small>
                                        <div class="modal fade mt-5 pt-5" id="forgotModal" tabindex="0" role="dialog" aria-labelledby="forgotModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content border rounded-5 p-3 bg-white shadow box-area">
                                                    <div class="modal-body " >
                                                        <div class="input-group mb-3">
                                                            <input type="email" id="resetEmail" class="form-control form-control-lg bg-light fs-6" placeholder="Your Email">
                                                        </div>
                                                        <div class="row mb-3 fade bg-danger" id="resetMessageBox">
                                                            <div class="col-sm-12 text-secondary">
                                                                <p class="text-white text-center" id="resetMessage"></p>
                                                            </div>
                                                        </div>
                                                        <div class="input-group mb-3">
                                                            <button type="button" class="btn btn-lg btn-primary w-100 fs-6" onclick="sendRequest()">Send</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="MessageLogin" class="mt-3 text-danger"></div>
                                <!-- Submit button -->
                                <button id="BtnLogin" type="button" onclick="Login()" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-block mb-4">Sign in</button>
                            </form>
                        </div>
                    </div>
                    <!-- Pills content -->
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="../Asset/js/Login.js"></script>
    </body>
</html>
