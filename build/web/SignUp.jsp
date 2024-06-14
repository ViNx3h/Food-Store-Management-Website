<%-- 
    Document   : SignUp
    Created on : Jun 5, 2024, 1:50:53 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
              integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>
        <div>
            <div class="container" style="margin-top: 10px;">
                <div class="row" style="border: 1px darkgrey solid; border-radius: 10px;width: 50%; margin: 0 auto; padding: 20px;">
                    <div class="col-sm-12">

                        <h2>Register Account</h2>

                        <span  style="color:red;">
                            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
                        </span>

                        <form action="CustomersController" method="post"  enctype="multipart/form-data">
                            <div class="form-group">
                                <label>UserName</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="Enter userName" required>
                                <div id="usernameError" style="color: red;"></div>
                            </div>
                            <script>
                                var userEmployeeInput = document.getElementById('username');
                                var usernameError = document.getElementById('usernameError');
                                userEmployeeInput.addEventListener('input', function () {
                                    var inputValue = userEmployeeInput.value;
                                    // Kiểm tra nếu có kí tự đặc biệt
                                    if ((/[^a-zA-Z0-9]/.test(inputValue)) || (/\s/.test(inputValue))) {


                                        userEmployeeInput.value = inputValue.replace(/[^a-zA-Z0-9]/g, '');
                                        usernameError.innerHTML = 'Username Khong hop le';
                                    }

//                                if (/\s/.test(inputValue)) {
//                                    usernameError.innerHTML = 'khong su dung khoang trang';
//                                    userEmployeeInput.value = inputValue.replace(/\s/g, '');}
                                    else {
                                        usernameError.innerHTML = ''; // Xóa thông báo lỗi nếu không có lỗi
                                    }
                                });
                            </script>


                            <div class="form-group">
                                <label>Password:</label>
                                <input type="password" minlength="6" id="password" name="password" class="form-control" placeholder="Enter password" required>
                            </div>

                            <div class="form-group">
                                <label>Confirm Password:</label>
                                <input type="password" minlength="6" id="confirmpassword" name="confirmpassword" class="form-control" placeholder="Enter confirm password" required>
                            </div>


                            <div class="form-group">
                                <label>FullName</label>
                                <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Enter fullname" required>                         
                                <div id="fullNameError" style="color: red;"></div>
                            </div>
                            <script>
                                var fullNameInput = document.getElementById('fullname');
                                var fullNameError = document.getElementById('fullNameError');
                                // Thêm sự kiện 'input' để kiểm tra giá trị sau khi người dùng nhập vào
                                fullNameInput.addEventListener('input', function () {
                                    var inputValue = fullNameInput.value;
                                    // Kiểm tra nếu có số
                                    if (/[0-9]/.test(inputValue)) {
                                        fullNameError.innerHTML = 'Không được sử dụng số.';
                                        // Xóa số khỏi input
                                        fullNameInput.value = inputValue.replace(/[0-9]/g, '');
                                    } else if (/[^a-zA-Z\s]/.test(inputValue)) { // Kiểm tra nếu có kí tự đặc biệt
                                        fullNameError.innerHTML = 'Không được sử dụng kí tự đặc biệt.';
                                        // Xóa kí tự đặc biệt khỏi input
                                        fullNameInput.value = inputValue.replace(/[^a-zA-Z\s]/g, '');
                                    } else {
                                        fullNameError.innerHTML = ''; // Xóa thông báo lỗi nếu không có lỗi
                                    }
                                });
                            </script>




                            <div class="form-group">
                                <label>Birthday</label>
                                <input type="date" id="birthday" name="birthday" class="form-control" required>    
                                <div id="birthdayError" style="color: red;"></div>
                            </div>
                            <script>
                                document.getElementById('birthday').addEventListener('change', function () {
                                    const birthday = new Date(this.value);
                                    const today = new Date();
                                    const age = today.getFullYear() - birthday.getFullYear();
                                    const monthDifference = today.getMonth() - birthday.getMonth();
                                    const dayDifference = today.getDate() - birthday.getDate();

                                    let actualAge = age;
                                    if (monthDifference < 0 || (monthDifference === 0 && dayDifference < 0)) {
                                        actualAge--;
                                    }

                                    const errorElement = document.getElementById('birthdayError');
                                    if (actualAge < 12) {
                                        errorElement.textContent = "You must be at least 12 years old.";
                                    } else {
                                        errorElement.textContent = "";
                                    }
                                });
                            </script>


                            <div class="form-group">
                                <label for="email-for-pass">Enter your email address</label> 
                                <input class="form-control" type="text" name="email" id="email-for-pass" required="">
                                <!-- <small class="form-text text-muted">Enter the registered email address. Then we'll email an OTP to this address.</small>-->
                            </div>


                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" id="phone" minlength="10" maxlength="11" name="phone" class="form-control" placeholder="Enter your phone number" required>
                                <div id="phoneError" style="color: red;"></div>
                            </div>
                            <script>
                                // Lấy thẻ input và phần tử chứa thông báo lỗi
                                var phoneInput = document.getElementById('phone');
                                var phoneError = document.getElementById('phoneError');

                                // Thêm sự kiện 'input' để kiểm tra giá trị sau khi người dùng nhập vào
                                phoneInput.addEventListener('input', function () {
                                    var inputValue = phoneInput.value;
                                    // Kiểm tra xem số điện thoại có bắt đầu bằng số 0 hoặc "+84" không và chỉ chứa số
                                    if (!/^(\+84|0)\d{9,10}$/.test(inputValue)) {
                                        phoneError.innerHTML = 'Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại bắt đầu bằng số 0 hoặc "+84" và chỉ chứa số.';
                                    } else {
                                        phoneError.innerHTML = ''; // Xóa thông báo lỗi nếu hợp lệ
                                    }
                                });
                            </script>





                            <div class="form-group mb-0">
                                <label>Gender</label>
                                <div>
                                    <label>
                                        <input type="radio" name="gender" value="true" id="male" required>
                                        Male
                                    </label>

                                    <label>
                                        <input type="radio" name="gender" value="false" id="female" required>
                                        Female
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" id="address" name="address" class="form-control" placeholder="Enter your address: " required>
                                <div id="addressError" style="color: red;"></div>
                            </div>                          
                            <script>
                                var addressInput = document.getElementById('address');
                                var addressError = document.getElementById('addressError');
                                // Thêm sự kiện 'input' để kiểm tra giá trị sau khi người dùng nhập vào
                                addressInput.addEventListener('input', function () {
                                    var inputValue = addressInput.value;
                                    // Kiểm tra nếu có số
                                    if (/[0-9]/.test(inputValue)) {
                                        addressError.innerHTML = 'Không được sử dụng số.';
                                        // Xóa số khỏi input
                                        addressInput.value = inputValue.replace(/[0-9]/g, '');
                                    } else if (/[^a-zA-Z\s]/.test(inputValue)) { // Kiểm tra nếu có kí tự đặc biệt
                                        addressError.innerHTML = 'Không được sử dụng kí tự đặc biệt.';
                                        // Xóa kí tự đặc biệt khỏi input
                                        addressInput.value = inputValue.replace(/[^a-zA-Z\s]/g, '');
                                    } else {
                                        addressError.innerHTML = ''; // Xóa thông báo lỗi nếu không có lỗi
                                    }
                                });
                            </script>  




                            <div class="mb-3">
                                <label for="img" class="form-label">Picture </label>
                                <input type="file" class="form-control" id="img" name="img" required>
                            </div>

                            <div class="">
                                <button type="submit" class="btn btn-primary ml-3 mr-4 mt-3" name="btnSubmit">Submit</button>

                                <button type="reset" class="btn btn-primary mr-4 mt-3">Cancel</button>
                            </div>
                        </form>
                        <a href="Login.jsp">Back</a>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
