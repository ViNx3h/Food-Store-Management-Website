<%-- 
    Document   : ProfileEm
    Created on : Jun 10, 2024, 10:01:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAOs.EmployeesDAO"%>
<%@page import="Models.Employees"%>
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
        <link rel="stylesheet" href="css/profileEm.css">
    </head>
    <body>     
        <%
                          Cookie[] cList = null;
                    cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
                    boolean flagCustomer = false;
                    if (cList != null) {
                        String value = "";
                        for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                            if (cList[i].getName().equals("employee")) {//nguoi dung da dang nhap
                                value = cList[i].getValue();
                                flagCustomer = true;
                                break; //thoat khoi vong lap
                            }
                        }
                        if (flagCustomer) {
       EmployeesDAO dao = new EmployeesDAO();
       Employees profile = dao.getProfileEm(value);
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
                                <img src="${profile.getImg()}" class="profile-img" alt="${profile.getUserEmployee()}">
                            </div>
                            <div class="mb-3 row">
                                <label for="username" class="col-sm-3 col-form-label">Username</label>
                                <div class="col-sm-9">
                                    <input type="text" readonly class="form-control-plaintext" id="username" value="${profile.getUserEmployee()}">
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="password" class="col-sm-3 col-form-label">Password</label>

                                <div class="col-sm-9">
                                    <input type="password" readonly class="form-control-plaintext" id="password" value="${profile.getPassword()}">
                                    <a href="ChangePassEm?name=${profile.getUserEmployee()}" > <button>Change Password </button></a> 
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
                <a class="btn btn-light" href="DashBoardEmployees.jsp"><em>Back</em></a>
            </div>

        </div>
        <%}}else{%>   
        <a href="Login.jsp"><h1>Login Before</h1></a>
        <%}
        %>    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    </body>
</html>
