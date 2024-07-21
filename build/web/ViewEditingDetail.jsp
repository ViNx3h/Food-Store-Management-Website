<%-- 
    Document   : ViewEditingDetail
    Created on : Jun 9, 2024, 3:20:53 PM
    Author     : ADMIN
--%>

<%@page import="java.util.Collections"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.EditingDetail"%>
<%@page import="DAOs.EditingDetailDAO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Editing Detail</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <link rel="stylesheet" href="css/editingDetail.css">
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
                EditingDetailDAO dao = new EditingDetailDAO();
                List<EditingDetail> list = dao.getAllEditingDetail();
                request.setAttribute("list", list);
                Collections.reverse(list);
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
                    <div class="container mt-5">
                        <h1 class="text-center">List of Editing Details</h1>
                        <table class="table table-striped table-hover">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th scope="col">Employee</th>
                                    <th scope="col">Food ID</th>
                                    <th scope="col">Add Detail</th>
                                    <th scope="col">Delete Detail</th>
                                    <th scope="col">Update Detail</th>
                                    <th scope="col">Date Editing</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${requestScope.list}">
                                    <tr>
                                        <td class="text-center">${c.getUserEmployee()}</td>
                                        <td class="text-center">${c.getIdFood()}</td>
                                        <td>${c.getAdd_food()}</td>
                                        <td>${c.getDelete_food()}</td>
                                        <td>${c.getUpdate_food()}</td>
                                        <td>${c.getDate_editing()}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <a href="DashBoardAdmin.jsp" class="btn btn-outline-secondary mt-3">Back</a>

                    </div>
                </main>
                <%}}else{%>     
                <a href="Login.jsp"><h1>Login Before</h1></a>
                <%}%> 
                <!-- Bootstrap Bundle with Popper -->
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
                </body>
                </html>