<%-- 
    Document   : ProfileAdmin
    Created on : Jun 10, 2024, 10:09:22 PM
    Author     : ADMIN
--%>

<%@page import="DAOs.AdminDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Admin"%>

<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Admin</title>      
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/profileAdmin.css">
        <style>
            body {
                background-color: #f8f9fa; /* Màu nền */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Font chữ */
            }

            .sidebar {
                height: 100vh; /* Chiều cao bằng toàn bộ màn hình */
                position: fixed; /* Cố định ở vị trí */
                top: 0;
                left: 0;
                width: 250px; /* Độ rộng */
                background-color: #343a40; /* Màu nền sidebar */
                padding-top: 20px; /* Khoảng cách từ trên xuống cho nội dung trong sidebar */
            }

            .sidebar .nav-link {
                font-size: 1.1em; /* Cỡ chữ */
                margin-bottom: 1em; /* Khoảng cách dưới của mỗi nav-link */
                border-radius: 5px; /* Bo góc */
                transition: background-color 0.3s, color 0.3s; /* Hiệu ứng chuyển đổi màu nền và màu chữ */
            }

            .sidebar .nav-link.active {
                background-color: #ffc107; /* Màu nền khi nav-link được chọn */
                color: #fff; /* Màu chữ khi nav-link được chọn */
            }

            .sidebar .nav-link:hover {
                background-color: #e0a800; /* Màu nền khi hover vào nav-link */
                color: #fff; /* Màu chữ khi hover vào nav-link */
            }

            .content {
                margin-left: 250px; /* Khoảng cách bên trái của nội dung chính so với sidebar */
                padding: 20px; /* Khoảng cách bên trong của nội dung chính */
            }

            .card {
                border: 1px solid #ccc; /* Viền card */
                border-radius: 8px; /* Bo góc */
                box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Đổ bóng */
                transition: box-shadow 0.3s ease, transform 0.3s ease; /* Hiệu ứng chuyển đổi đổ bóng và transform */
            }

            .card:hover {
                box-shadow: 0 8px 16px rgba(0,0,0,0.2); /* Đổ bóng khi hover vào card */
                transform: translateY(-5px); /* Di chuyển lên trên một chút */
            }

            .card-title {
                font-size: 1.25rem; /* Cỡ chữ tiêu đề card */
                font-weight: bold; /* Đậm chữ tiêu đề card */
            }

            .card-text {
                color: #555; /* Màu chữ nội dung card */
            }

            .card img {
                border-radius: 8px 8px 0 0; /* Bo góc ảnh trong card */
            }

            .card-buttons {
                display: flex; /* Hiển thị các nút button theo chiều ngang */
                justify-content: space-between; /* Căn giữa các nút button */
                align-items: center; /* Căn dọc các nút button */
            }

            .btn-primary {
                background-color: #ffc107; /* Màu nền nút primary */
                border: none; /* Loại bỏ viền */
            }

            .btn-primary:hover {
                background-color: #e0a800; /* Màu nền nút primary khi hover */
            }

            .btn-outline-secondary {
                border-color: #ffc107; /* Màu viền nút outline secondary */
                color: #ffc107; /* Màu chữ nút outline secondary */
            }

            .btn-outline-secondary:hover {
                background-color: #ffc107; /* Màu nền nút outline secondary khi hover */
                color: #fff; /* Màu chữ nút outline secondary khi hover */
            }

            .list-group-item {
                font-size: 1.1em; /* Cỡ chữ của mỗi item trong list-group */
            }

            .list-group-item span {
                font-weight: bold; /* Đậm chữ của mỗi span trong list-group */
            }

            .btn-success, .btn-warning, .btn-secondary {
                margin-top: 1em; /* Khoảng cách từ trên xuống cho các nút success, warning, secondary */
            }

        </style>

    </head>
    <body class="bg-gray">


        <%
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            boolean flagCustomer = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("admin")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagCustomer) {
                    AdminDAO dao = new AdminDAO();
                    Admin profile = dao.getProfileAdmin(value);
                    request.setAttribute("profile", profile);
        %>

        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="DashBoardAdmin.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AddFood.jsp">
                                    <i class="fas fa-plus-circle"></i> Add New Food
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewEditingDetail.jsp">
                                    <i class="fas fa-edit"></i> View Editing Detail
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewCategories.jsp">
                                    <i class="fas fa-th-list"></i> View Category
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Employees.jsp">
                                    <i class="fas fa-users"></i> View Employee
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Customers.jsp">
                                    <i class="fas fa-user"></i> View Customer
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ProfileAdmin.jsp">
                                    <i class="fas fa-user-circle"></i> View Profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewStatus.jsp">
                                    <i class="fas fa-chart-line"></i> View Status
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewSchedulebyAdmin.jsp">
                                    <i class="fas fa-calendar-alt"></i> Working Schedule
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Logout">
                                    <i class="fas fa-sign-out-alt"></i> Log Out
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
                <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4">
                    <div class="mt-3 bg-gray">

                        <div class="row justify-content-center ">
                            <div class="col-md-11">
                                <div class="card shadow-sm">
                                    <div class="card-header text-center bg-light text-dark">
                                        <h2> Hello, ${profile.getFullName()}</h2>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6 text-center mb-5">
                                                <div class="mt-3">
                                                    <img src="${profile.getImg()}" class="profile-img" alt="${profile.getUserAdmin()}">
                                                </div>

                                                <div class="mt-3">
                                                    <div class="mb-5 row">
                                                        <label for="userCus" class="col-sm-4 col-form-label fw-semibold fs-5">Username : </label>
                                                        <div class="col-sm-5">
                                                            <input type="text" readonly class="form-control-plaintext text-center fs-5" id="userCus" value="${profile.getUserAdmin()}">
                                                        </div>
                                                    </div>

                                                    <div class="mb-5 row">
                                                        <label for="password" class="col-sm-4 col-form-label fw-semibold fs-5">Password : </label>
                                                        <div class="col-sm-8">
                                                            <input type="password" readonly class="form-control-plaintext fs-5" id="password" value="${profile.getPassword()}">
                                                        </div>
                                                    </div>
                                                    <div class="mb-3 row">
                                                        <% String errorMessage = (String) request.getAttribute("errorMessage"); 
                                                           String successMessage = (String) request.getAttribute("errorMessagee");
                                                           if (errorMessage != null) { %>
                                                        <div class="offset-sm-3 text-danger col-sm-6">
                                                            <%= errorMessage %>
                                                        </div>
                                                        <% } else if (successMessage != null) { %>
                                                        <div class=" offset-sm-3 text-success col-sm-6">
                                                            <%= successMessage %>
                                                        </div>
                                                        <% } %>
                                                    </div>
                                                    <div class="offset-sm-3 col-sm-6 ">

                                                        <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#modalChangePassword">
                                                            Change Password
                                                        </button>

                                                        <a  href="UpdateProfile?name=${profile.getUserAdmin()}"><button class="btn btn-outline-success">Edit Profile</button></a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6 mt-3">
                                                <div class="mb-5 row">
                                                    <label for="fullName" class="col-sm-4 col-form-label fw-semibold fs-5">Full Name : </label>
                                                    <div class="col-sm-8">
                                                        <input type="text" readonly class="form-control-plaintext fs-5" id="fullName" value="${profile.getFullName()}">
                                                    </div>
                                                </div>
                                                <div class="mb-5 row">
                                                    <label for="birthday" class="col-sm-4 col-form-label fw-semibold fs-5">Birthday : </label>
                                                    <div class="col-sm-8">
                                                        <input type="date" readonly class="form-control-plaintext fs-5" id="birthday" value="${profile.getBirthday()}">
                                                    </div>
                                                </div>
                                                <div class="mb-5 row">
                                                    <label for="email" class="col-sm-4 col-form-label fw-semibold fs-5">Email : </label>
                                                    <div class="col-sm-8">
                                                        <input type="email" readonly class="form-control-plaintext fs-5" id="email" value="${profile.getEmail()}">
                                                    </div>
                                                </div>
                                                <div class="mb-5 row">
                                                    <label for="phone" class="col-sm-4 col-form-label fw-semibold fs-5">Phone : </label>
                                                    <div class="col-sm-8">
                                                        <input type="tel" readonly class="form-control-plaintext fs-5" id="phone" value="${profile.getPhone()}">
                                                    </div>
                                                </div>
                                                <div class="mb-5 row">
                                                    <label for="gender" class="col-sm-4 col-form-label fw-semibold fs-5">Gender : </label>
                                                    <div class="col-sm-8">
                                                        <input type="text" readonly class="form-control-plaintext fs-5" id="gender" value="${profile.isGender() ? 'Male' : 'Female'}">
                                                    </div>
                                                </div>
                                                <div class="mb-4     row">
                                                    <label for="address" class="col-sm-4 col-form-label fw-semibold fs-5">Address : </label>
                                                    <div class="col-sm-8">
                                                        <input type="text" readonly class="form-control-plaintext fs-5" id="address" value="${profile.getAddress()}">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Change Password Modal -->
                    <div class="modal fade" id="modalChangePassword" tabindex="-1" aria-labelledby="modalChangePasswordLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="ChangePassword" method="post">
                                    <div class="modal-header text-center">
                                        <h5 class="modal-title fs-3" id="modalChangePasswordLabel">Change Password</h5>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="username" class="form-label">User Name</label>
                                            <input type="text" class="form-control" name="username" readonly value="${profile.getUserAdmin()}">
                                        </div>
                                        <div class="mb-3 position-relative">
                                            <label for="oldpassword" class="form-label">Enter Old Password</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="oldpassword" name="oldpassword" pattern=".{6,12}" placeholder="Enter old password" required oninvalid="this.setCustomValidity('Password cannot be empty and must be 6 to 12 characters long.')" oninput="this.setCustomValidity('')">
                                                <span class="input-group-text toggle-password" toggle="#oldpassword"><i class="bi bi-eye-slash"></i></span>
                                            </div>
                                        </div>
                                        <div class="mb-3 position-relative">
                                            <label for="newpassword" class="form-label ml-3">Enter New Password</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="newpassword" name="newpassword" minlength="6" placeholder="Enter new password" required>
                                                <span class="input-group-text toggle-password" toggle="#newpassword"><i class="bi bi-eye-slash"></i></span>
                                            </div>
                                        </div>
                                        <div class="mb-3 position-relative">
                                            <label for="confirmpassword" class="form-label">Enter Confirm Password</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="confirmpassword" name="confirmpassword" minlength="6" placeholder="Enter confirm password" required>
                                                <span class="input-group-text toggle-password" toggle="#confirmpassword"><i class="bi bi-eye-slash"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-0">
                                        <button type="button" class=" btn btn-primary" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="javascript/Changepassword.js"></script>

        <%
                }
            }
        %>    
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>