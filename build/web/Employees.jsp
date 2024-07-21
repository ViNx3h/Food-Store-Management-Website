<%-- 
    Document   : Employees
    Created on : Jun 9, 2024, 10:38:11 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAOs.EmployeesDAO"%>
<%@page import="Models.Employees"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Employees</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .sidebar {
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                background-color: #343a40;
                padding-top: 20px;
            }

            .sidebar .nav-link {
                font-size: 1.1em;
                margin-bottom: 1em;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }

            .sidebar .nav-link.active {
                background-color: #ffc107;
                color: #fff;
            }

            .sidebar .nav-link:hover {
                background-color: #e0a800;
                color: #fff;
            }

            .content {
                margin-left: 250px;
                padding: 20px;
            }

            .container {
                margin-top: 50px;
            }

            .btn-light {
                background-color: #fff3cd;
                border-color: #ffc107;
            }

            table {
                background-color: #fff;
            }

            thead {
                background-color: #ffc107;
            }

            th, td {
                text-align: center;
                vertical-align: middle;
            }

            img {
                border-radius: 8px;
            }

            .table th, .table td {
                padding: 1rem;
            }

            .btn-group a {
                margin-right: 5px;
            }

            .card-body {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .card {
                border: 1px solid #ccc;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: box-shadow 0.3s ease, transform 0.3s ease;
            }

            .card:hover {
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                transform: translateY(-5px);
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: bold;
            }

            .card-text {
                color: #555;
            }

            .card img {
                border-radius: 8px 8px 0 0;
            }

            .card-buttons {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .btn-primary {
                background-color: #ffc107;
                border: none;
            }

            .btn-primary:hover {
                background-color: #e0a800;
            }

            .btn-outline-secondary {
                border-color: #ffc107;
                color: #ffc107;
            }

            .btn-outline-secondary:hover {
                background-color: #ffc107;
                color: #fff;
            }

            .list-group-item {
                font-size: 1.1em;
            }

            .list-group-item span {
                font-weight: bold;
            }

            .btn-success, .btn-warning, .btn-secondary {
                margin-top: 1em;
            }

        </style>
    </head>
    <body>
        <%
        Cookie[] cList = request.getCookies();  
        boolean flagCustomer = false;
        if (cList != null) {
            for (Cookie cookie : cList) { 
                if (cookie.getName().equals("admin")) { 
                    flagCustomer = true;
                    break;  
                }
            }
            if (flagCustomer) {
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
                    <div class="container">
                        <h2 class="text-center mb-4">Manage Employees</h2>
                        <div class="mb-3">
                            <a class="btn btn-light" href="DashBoardAdmin.jsp"><em>Back</em></a>
                            <a class="btn btn-primary" href="AddEm.jsp">Create New Employee Account</a>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Full Name</th>
                                    <th>Birthday</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Gender</th>
                                    <th>Address</th>
                                    <th>Image</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                EmployeesDAO dao = new EmployeesDAO();
                                List<Employees> list = dao.getAllEmployees();
                                request.setAttribute("list", list);
                                %>     
                                <c:forEach var="c" items="${requestScope.list}">
                                    <tr>
                                        <td>${c.getUserEmployee()}</td>
                                        <td>${c.getFullName()}</td>
                                        <td>${c.getBirthday()}</td>
                                        <td>${c.getEmail()}</td>
                                        <td>${c.getPhone()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${c.isGender()}">Male</c:when>
                                                <c:otherwise>Female</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${c.getAddress()}</td>
                                        <td><img src="${c.getImg()}" alt="${c.getUserEmployee()}" class="img-thumbnail img-fluid" style="max-height: 80px; max-width: 80px;"/></td>      
                                        <td>
                                            <a href="DeleteEm?userEmployee=${c.getUserEmployee()}" class="btn btn-outline-danger btn-sm ms-2" onclick="return confirmDeletion();">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <script type="text/javascript">
                            function confirmDeletion() {
                                return confirm('Are you sure you want to delete this Employee?');
                            }
                        </script>
                    </div>
                </main>
                <%
                    }
                } else {
                %>
                <div class="container text-center mt-5">
                    <h1>You need to login first</h1>
                    <a href="Login.jsp" class="btn btn-warning">Login</a>
                </div>
                <%
                }
                %>
                <!-- Bootstrap Bundle with Popper -->
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
                </body>
                </html>