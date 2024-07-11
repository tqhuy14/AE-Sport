let attemptCount = 0;
const maxAttempts = 5;
const lockoutTime = 10000;

function Login() {
    let userName = $('#UserName').val()
    let password = $('#Password').val()
    // gửi request tới controller ( chạy ngầm dưới network )
    $.ajax({
            url: '/SWP/Login',
        method: 'POST',
        data: {Action: "Login", userName: userName, password: password},
        success: function (data) {
            if (data.length > 6) {
                let mess = $("#mess")
                IncorrectPass(); // mỗi đănng nhập sai gọi hàm để giới hạn số lần đăng nhập
                mess.removeClass("fade").text(data)

                setTimeout(() => {
                    mess.addClass("fade")
                }, 2000);
                return;
            }
            window.location.href = "../HomePage";
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function register() {
    var userName = $('#registerUsername').val(); // lấy giá trị theo id tabserEmail = $('#Emailrs').val();
    var userPhone = $('#registerPhone').val();
    var userAddress = $('#registerAddress').val();
    var fullName = $('#registerName').val();
    var email = $('#registerEmail').val();
    var usserPass = $('#registerPass').val();
    var cfPass = $('#registercfPass').val();


    var boxMess = $('#registerMessageBox');
    var Mess = $('#registerMessage'); // validate giá trị nhập vào
    if (userName == '' || userPhone == '' || userAddress == '' || fullName == '' || email == '') {
        boxMess.removeClass("bg-success").addClass("bg-danger")
        Mess.text("Please enter your infor");
        boxMess.removeClass("fade")
        setTimeout(() => {
            boxMess.addClass("fade")
        }, 3000)
        return;
    }
    // validate giá trị nhập vào
    if (!ValidatePassword(usserPass) || !validateEmail(email) || !validatePhoneNumber(userPhone) || usserPass !== cfPass) {
        let textMess = !ValidatePassword(usserPass) ? "Incorret form Password xample : Abcdef123@" : !validateEmail(email) ? "Please enter form Email" : !validatePhoneNumber(userPhone) ? "Please enter phone number" : usserPass !== cfPass ? "password and confirm password not same" : ""

        boxMess.removeClass("bg-success").addClass("bg-danger")
        Mess.text(textMess);
        boxMess.removeClass("fade")
        setTimeout(() => {
            boxMess.addClass("fade")
        }, 3000)
        return;
    }

    $.ajax({// call api
        url: "/SWP/Login",
        method: "POST",
        data: {
            Action: "Register",
            userName: userName,
            userPhone: userPhone,
            userAddress: userAddress,
            email: email,
            fullName: fullName,
            usserPass: usserPass
        },
        success: function (data) {
            Mess.text(data);
            boxMess.removeClass("fade")
            if (data.toLowerCase().includes("incorrect")) {
                boxMess.removeClass("bg-success").addClass("bg-danger")
            } else {
                boxMess.removeClass("bg-danger").addClass("bg-success")
            }

            setTimeout(() => {
                boxMess.addClass("fade")
            }, 3000)
        },
        error: function (Error) {
            console.log(Error)
        }
    });
}

function sendRequest() {
    var userEmail = $('#resetEmail').val();

    var boxMess = $('#resetMessageBox');
    var Mess = $('#resetMessage');
    if (userEmail == '' || !validateEmail(userEmail)) {
        Mess.text("Please enter your email")
        boxMess.removeClass("fade")
        boxMess.removeClass("bg-success").addClass("bg-danger")
        setTimeout(() => {
            boxMess.addClass("fade")
        }, 3000)
        return
    }

    $.ajax({// call api
        url: "/SWP/Login",
        method: "POST",
        data: {
            Action: "ForgetPasswork",
            userEmail: userEmail,
        },
        success: function (data) {
            boxMess.removeClass("fade")

            if (data.toLowerCase().includes("incorrect")) {
                boxMess.removeClass("bg-success").addClass("bg-danger")
                if (data.length < 50) {
                    Mess.text(data)
                } else {
                    Mess.text("Send request success, please check your mail")
                }
            } else {
                Mess.text("Send request success, please check your mail")
                boxMess.removeClass("bg-danger").addClass("bg-success")
            }
            // hide message action
            setTimeout(() => {
                boxMess.addClass("fade")
            }, 5000)
        },
        error: function (Error) {

        }
    });
}

function ValidatePassword(pass) {
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return passwordPattern.test(pass);
}

function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function validatePhoneNumber(phoneNumber) {
    const phoneRegex = /^0\d{9}$/;
    return phoneRegex.test(phoneNumber);
}

function IncorrectPass(){
    let btnLogin = document.querySelector("#BtnLogin")
    let messageDiv = document.querySelector('#MessageLogin')
    attemptCount++; // đếm số lần sai mật khẩu
      if (attemptCount >= maxAttempts) { //nếu vực quá số lần cho phép
          // hiện thông báo đợi
        messageDiv.innerHTML = 'Too many incorrect attempts. Please wait 10 seconds.';
        btnLogin.disabled = true; // tắt trạng thái nút login kh cho bấm
        this.disabled = true;

        setTimeout(() => { // sau 10s thì bặt trạng thái login lại và xóa message
          btnLogin.disabled = false;
          this.disabled = false;
          attemptCount = 0;
          messageDiv.innerHTML = '';
        }, lockoutTime);
      } else {
        messageDiv.innerHTML = `Incorrect password. You have ${maxAttempts - attemptCount} attempts left.`;
      }
}