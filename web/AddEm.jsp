<%-- 
    Document   : AddCus
    Created on : Jun 10, 2024, 12:47:33 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <div class="container  mb-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h1 class="text-center">Create New Employee Account</h1>

                    <form action="AddEm" method="Post" enctype="multipart/form-data">

                        <div class="mb-3">
                            <label for="userEmployee" class="form-label">Enter Username:</label>
                            <input type="text" class="form-control" id="userEmployee" name="userEmployee" placeholder="Example: nguyenvana123" required>
                            <div id="usernameError" style="color: red;"></div> <!-- Thẻ HTML để hiển thị thông báo lỗi -->
                            <!--    Check gia tri nhap vao cua userName valid-->
                        </div>
                        <script>
                            var userEmployeeInput = document.getElementById('userEmployee');
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




                        <div class="mb-3">
                            <label for="password" class="form-label">Enter Password:</label>
                            <input type="password" minlength="6" class="form-control" id="password" name="password" placeholder="Example: Nguyenvana123" required>
                        </div>

                        <div class="mb-3">
                            <label for="confirmpassword" class="form-label">Confirm Password:</label>
                            <input type="password" minlength="6" class="form-control" id="confirmpassword" name="confirmpassword"  required>
                        </div>

                        <span  style="color:red;">
                            <%= request.getAttribute("errorPassword") != null ? request.getAttribute("errorPassword") : "" %>
                        </span>

                        <div class="mb-3">
                            <label for="fullName" class="form-label">Enter Full Name:</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Example: Nguyen Van A" required>
                            <div id="fullNameError" style="color: red;"></div>
                        </div>
                        <!--    Check gia tri nhap vao cua fullName valid-->
                        <script>
                            var fullNameInput = document.getElementById('fullName');
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

                        <div class="mb-3">
                            <label for="birthday" class="form-label">Choose Birthday</label>
                            <input type="date" class="form-control" id="birthday" name="birthday" required>
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


                        <div class="mb-3">
                            <label for="email" class="form-label">Enter Email:</label>
                            <input type="text" class="form-control" id="email" name="email" placeholder="Example: nguyenvana123@gmail.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Enter Number Phone:</label>
                            <input type="text" minlength="10" maxlength="11" class="form-control" id="phone" name="phone" placeholder="Example: 0381234567" required>
                            <div id="phoneError" style="color: red;"></div>
                        </div>

                        <!-- Enter phone valid -->
                        <script>
                            // Lấy thẻ input và phần tử chứa thông báo lỗi
                            var phoneInput = document.getElementById('phone');
                            var phoneError = document.getElementById('phoneError');

                            // Thêm sự kiện 'input' để kiểm tra giá trị sau khi người dùng nhập vào
                            phoneInput.addEventListener('input', function () {
                                var inputValue = phoneInput.value;

                                // Kiểm tra xem số điện thoại có bắt đầu bằng số 0 hoặc "+84" không và chỉ chứa số
                                if (!/^0|\d{9,10}$/.test(inputValue)) {
                                    phoneError.innerHTML = 'Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại bắt đầu bằng số 0 hoặc "+84" và chỉ chứa số.';
                                    phoneInput.value = ''; // Xóa nội dung input nếu không hợp lệ
                                } else if (!/^\d*$/.test(inputValue)) {
                                    phoneError.innerHTML = 'Vui lòng chỉ nhập số.';
                                    phoneInput.value = ''; // Xóa nội dung input nếu không hợp lệ
                                } else {
                                    phoneError.innerHTML = ''; // Xóa thông báo lỗi nếu hợp lệ
                                }
                            });
                        </script>
                        <div class="mb-3">
                            <label for="status" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Enter Address:</label>
                            <input type="text" class="form-control" id="address" name="address" placeholder="Example: Vinh Long" required>
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
                        
                        <button type="submit" class="btn btn-primary">Create</button>

                    </form> 
                    <a href="Employees.jsp"><button >Back</button></a>






                </div>           
            </div>
        </div>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>