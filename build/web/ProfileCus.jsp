<%-- 
    Document   : ProfileCus
    Created on : Jun 10, 2024, 4:43:03 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="Models.Customers"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ShoppingCartDAO"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Customer</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/index.css">
        <link rel="stylesheet" href="css/Changepassword.css">
        <style>
            .navbar-brand img{
                width: 90px; /* Adjust the width as needed */
                height: auto;
            }
            .profile-img{
                width: 100px; /* Adjust the width as needed */
                height: auto;
            }
        </style>
    </head>
    <body>
        <%
            Cookie[] cList = request.getCookies(); // Lay tat ca cookie cua website nay tren may nguoi dung
            boolean flagCustomer = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) { // Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) { // nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; // thoat khoi vong lap
                    }
                }
                if (flagCustomer) {
                    CustomersDAO dao = new CustomersDAO();
                    Customers profile = dao.getProfileCus(value);
                    request.setAttribute("profile", profile);
        %>

    </head>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container">
            <a class="navbar-brand" href="/FoodStoreManagement"><img src="images/logo.png" alt="Logo"></a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <%
                            ShoppingCartDAO scDAO = new ShoppingCartDAO();
                        %>
                        <a class="nav-link" href="CustomersController/ShoppingCart"><i class="fas fa-shopping-cart"></i> (<%= scDAO.getQuantityOrder(value) %>)</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="#" id="user-icon" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user"></i>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="user-icon">
                            <li><a class="dropdown-item" href="ProfileCus.jsp">Profile</a></li>
                            <a class="dropdown-item" href="/FoodStoreManagement/CustomersController/ViewOrderHistory">View Order</a>
                            <li><a class="dropdown-item" href="Logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Separator -->
    <div class="separator"></div>
    <div class="mt-3 bg-gray">

        <div class="row justify-content-center ">
            <div class="col-md-11">
                <div class="card shadow-sm">
                    <div class="card-header text-center bg-light text-dark">
                        <h2>Your Profile</h2>
                        <div class="card-footer text-end">
                            <a class="btn btn-secondary" href="index.jsp">Back</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 text-center mb-5">
                                <div class="mt-3">
                                    <img src="${profile.getImg()}" class="profile-img" alt="${profile.getUserCus()}">
                                </div>

                                <div class="mt-3">
                                    <div class="mb-5 row">
                                        <label for="userCus" class="col-sm-4 col-form-label fw-semibold fs-5">Username : </label>
                                        <div class="col-sm-5">
                                            <input type="text" readonly class="form-control-plaintext text-center fs-5" id="userCus" value="${profile.getUserCus()}">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="password" class="col-sm-4 col-form-label fw-semibold fs-5">Password : </label>
                                        <div class="col-sm-8">
                                            <input type="password" readonly class="form-control-plaintext fs-5" id="password" value="${profile.getPassword()}">
                                        </div>
                                    </div>
                                    <div class="mb-2 row">
                                        <% String errorMessage = (String) request.getAttribute("errorMessage"); 
                                           String successMessage = (String) request.getAttribute("errorMessagee");
                                           if (errorMessage != null) { %>
                                        <div class="offset-sm-2 text-danger col-sm-6">
                                            <%= errorMessage %>
                                        </div>
                                        <% } else if (successMessage != null) { %>
                                        <div class=" offset-sm-2 text-success col-sm-6">
                                            <%= successMessage %>
                                        </div>
                                        <% } %>
                                    </div>
                                    <div class="offset-sm-3 col-sm-6 ">
                                        <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#modalChangePassword">
                                            Change Password
                                        </button>
                                        <a  href="UpdateProfile?name=${profile.getUserCus()}"><button class="btn btn-outline-success">Edit Profile</button></a>
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
                            <input type="text" class="form-control" name="username" readonly value="${profile.getUserCus()}">
                        </div>
                        <div class="mb-3 position-relative">
                            <label for="oldpassword" class="form-label">Enter Old Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="oldpassword" name="oldpassword" placeholder="Enter old password" required oninvalid="this.setCustomValidity('Password cannot be empty.')" oninput="this.setCustomValidity('')">
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
    <!-- Separator -->
    <div class="separator"></div>
    <footer class="bg-info text-white py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h5>Contact information</h5>
                    <p>Street 30/04, Hung Loi Ward, Ninh Kieu District, Can Tho Province</p>
                    <p>Email: ToanLTCE172023@fpt.edu.vn</p>
                    <p>Phone: 0949415422</p>
                </div>
                <div class="col-md-4 text-center">
                    <p>&copy; 2024 Food Store.</p>
                </div>
            </div>
        </div>
    </footer>
    <script src="javascript/Changepassword.js"></script>

    <%        
        }
}
    %>




    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>