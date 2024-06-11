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
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/profileAdmin.css">
    </head>
    <body>
        <%
                 Cookie[] cookies = request.getCookies();
                 String username = null;
                 if (cookies != null) {
                 for (Cookie cookie : cookies) {
                 if (cookie.getName().equals("username")) {
                 username = cookie.getValue();
                 break;}}}
                 request.setAttribute("username", username);
        %>    
        <c:if test="${not empty username}">
            <%
            AdminDAO dao = new AdminDAO();
            Admin profile = dao.getProfileAdmin(username);
            request.setAttribute("profile", profile);
            %>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header text-center">
                                <h2>${profile.getFullName()}</h2>
                            </div>
                            <div class="card-body">
                                <div class="text-center mb-4">
                                    <img src="${profile.getImg()}" class="profile-img" alt="${profile.getUserAdmin()}">
                                </div>
                                <div class="mb-3 row">
                                    <label for="username" class="col-sm-3 col-form-label">Username</label>
                                    <div class="col-sm-9">
                                        <input type="text" readonly class="form-control-plaintext" id="username" value="${profile.getUserAdmin()}">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="password" class="col-sm-3 col-form-label">Password</label>
                                    <div class="col-sm-9">
                                        <input type="password" readonly class="form-control-plaintext" id="password" value="${profile.getPassword()}">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="birthday" class="col-sm-3 col-form-label">Birthday</label>
                                    <div class="col-sm-9">
                                        <input type="date" readonly class="form-control-plaintext" id="birthday" value="${profile.getBirthday()}">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="email" class="col-sm-3 col-form-label">Email</label>
                                    <div class="col-sm-9">
                                        <input type="email" readonly class="form-control-plaintext" id="email" value="${profile.getEmail()}">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="phone" class="col-sm-3 col-form-label">Phone</label>
                                    <div class="col-sm-9">
                                        <input type="tel" readonly class="form-control-plaintext" id="phone" value="${profile.getPhone()}">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="gender" class="col-sm-3 col-form-label">Gender</label>
                                    <div class="col-sm-9">
                                        <input type="text" readonly class="form-control-plaintext" id="gender" value="${profile.isGender() ? 'Male' : 'Female'}">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label for="address" class="col-sm-3 col-form-label">Address</label>
                                    <div class="col-sm-9">
                                        <input type="text" readonly class="form-control-plaintext" id="address" value="${profile.getAddress()}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>      
        <c:if test="${empty username}">
            <a href="Login.jsp"><h1>Login Before</h1></a>
        </c:if>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    </body>
</html>
