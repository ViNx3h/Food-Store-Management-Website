<%-- 
    Document   : ProfileAdmin
    Created on : Jun 10, 2024, 10:09:22 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Admin"%>
<%@page import="DAOs.AdminDAO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Admin</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/profileAdmin.css">
    </head>
    <body>


        <%
            Cookie[] cList = null;
            cList = request.getCookies();  
            boolean flagCustomer = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) { 
                    if (cList[i].getName().equals("admin")) { 
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break;  
                    }
                }
                if (flagCustomer) {
                    AdminDAO dao = new AdminDAO();
                    Admin profile = dao.getProfileAdmin(value);
                    request.setAttribute("profile", profile);
        %>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header text-center bg-primary text-white">
                            <h2>${profile.getFullName()}</h2>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-4">
                                <img src="${profile.getImg()}" class="profile-img" alt="${profile.getUserAdmin()}">
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3 row">
                                        <label for="userCus" class="col-sm-4 col-form-label">User Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" readonly class="form-control-plaintext" id="userCus" value="${profile.getUserAdmin()}">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="password" class="col-sm-4 col-form-label">Password</label>
                                        <div class="col-sm-8">
                                            <input type="password" readonly class="form-control-plaintext" id="password" value="${profile.getPassword()}">
                                        </div>
                                        <%
                                  String errorMessage = (String) request.getAttribute("errorMessage");
                                  String successMessage = (String) request.getAttribute("errorMessagee");
                                  if (errorMessage != null) {
                                        %>
                                        <div class="text-danger">
                                            <%= errorMessage %>
                                        </div>
                                        <% } else if (successMessage != null) { %>
                                        <div class="text-success">
                                            <%= successMessage %>
                                        </div>
                                        <% } %>
                                        <div class="offset-sm-4 col-sm-8 mt-2">
                                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modalChangePassword">
                                                Change Password
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="fullName" class="col-sm-4 col-form-label">Full Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" readonly class="form-control-plaintext" id="fullName" value="${profile.getFullName()}">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="birthday" class="col-sm-4 col-form-label">Birthday</label>
                                        <div class="col-sm-8">
                                            <input type="date" readonly class="form-control-plaintext" id="birthday" value="${profile.getBirthday()}">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3 row">
                                        <label for="email" class="col-sm-4 col-form-label">Email</label>
                                        <div class="col-sm-8">
                                            <input type="email" readonly class="form-control-plaintext" id="email" value="${profile.getEmail()}">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="phone" class="col-sm-4 col-form-label">Phone</label>
                                        <div class="col-sm-8">
                                            <input type="tel" readonly class="form-control-plaintext" id="phone" value="${profile.getPhone()}">
                                        </div>
                                    </div>


                                    <!--Sua Css-->
                                    <div class="mb-3 row">
                                        <label for="phone" class="col-sm-4 col-form-label"></label>
                                        <button type="button" class="btn btn-secondary " data-bs-toggle="modal" data-bs-target="#modal">

                                        </button>
                                    </div>


                                    <div class="mb-3 row">
                                        <label for="gender" class="col-sm-4 col-form-label">Gender</label>
                                        <div class="col-sm-8">
                                            <input type="text" readonly class="form-control-plaintext" id="gender" value="${profile.isGender() ? 'Male' : 'Female'}">
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="address" class="col-sm-4 col-form-label">Address</label>
                                        <div class="col-sm-8">
                                            <input type="text" readonly class="form-control-plaintext" id="address" value="${profile.getAddress()}">
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <a class="btn btn-secondary" href="DashBoardAdmin.jsp">Back</a>
                            <a class="btn btn-primary" href="UpdateProfile?name=${profile.getUserAdmin()}">Update</a>
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
                        <div class="modal-header border-0">
                            <h5 class="modal-title" id="modalChangePasswordLabel">Change Password</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="username" class="form-label">User Name</label>
                                <input type="text" class="form-control" name="username" readonly value="${profile.getUserAdmin()}">
                            </div>
                            <div class="mb-3">
                                <label for="oldpassword" class="form-label">Enter Old Password</label>
                                <input type="password" class="form-control" name="oldpassword" minlength="3" placeholder="Enter old password" required>
                            </div>
                            <div class="mb-3">
                                <label for="newpassword" class="form-label">Enter New Password</label>
                                <input type="password" class="form-control" name="newpassword" minlength="6" placeholder="Enter new password" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmpassword" class="form-label">Enter Confirm Password</label>
                                <input type="password" class="form-control" name="confirmpassword" minlength="6" placeholder="Enter confirm password" required>
                            </div>
                        </div>
                        <div class="modal-footer border-0">
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <%
                }
            }%>    
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
