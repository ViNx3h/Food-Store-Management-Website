<%-- 
    Document   : AdminSearchFoodbyName
    Created on : Jun 13, 2024, 11:14:08 PM
    Author     : ADMIN
--%>

<%@page import="Models.Categories"%>
<%@page import="Models.Foods"%>
<%@page import="Models.Foods"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.CategoriesDAO"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/dashBoardAdmin.css">
        <style>
            .img-pro{
                width: auto;
                height: 270px;
            }
        </style>
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
                        <div class="search-container p-3 border rounded shadow-sm">
                            <h4 class="text-center">Search Foods</h4>
                            <form action="AdminSearchFood" class="form-inline" method="doGet">
                                <div class="input-group w-100">
                                    <select id="search-option" name="option" class="form-control form-control-sm">
                                        <option value="name">By Name</option>
                                        <option value="category">By Category</option>
                                    </select>
                                    <input type="text" class="form-control form-control-sm" id="searchQuery" name="query" placeholder="Search Foods...">
                                    <div class="input-group-append">
                                        <button class="btn btn-danger btn-sm" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <h3>Product List</h3>
                    <div class="row">
                        <%
                            List<Foods> list = (List<Foods>) request.getAttribute("list");
                            CategoriesDAO ca = new CategoriesDAO();
                            for (Foods food : list) {
                                Categories category = ca.findCategory(food.getId_category());
                                if (category != null) {
                                    food.setCategoryName(category.getName_category());
                                }
                            }
                            request.setAttribute("list", list);
                        %>
                        <c:forEach var="c" items="${list}">
                            <div class="col-md-4 mb-3 d-flex">
                                <div class="card w-100">
                                    <img src="${c.pic}" class="card-img-top img-fluid img-pro" alt="${c.name_food}">
                                    <div class="card-body">
                                        <p class="card-title">ID: ${c.idFood}</p>
                                        <h5 class="card-title">${c.name_food}</h5>
                                        <p class="card-text">${c.description}</p>
                                        <p class="card-text"><small class="text-muted">${c.categoryName}</small></p>
                                        <p class="card-text"><small class="text-muted">${c.status == 'true' ? 'Available' : 'Unavailable'}</small></p>
                                        <p class="card-text">${c.price} VND</p>
                                        <div class="card-buttons">
                                            <a href="UpdateFood.jsp?id=${c.idFood}" class="btn btn-outline-warning btn-sm">Update</a>
                                            <a href="DeleteFood?id=${c.idFood}" onclick="return confirmDeleteProduct('${c.idFood}')" class="btn btn-outline-danger btn-sm">Delete</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </main>
            </div>
        </div>
        <script>
            function confirmDeleteProduct(id) {
                if (confirm("Are you sure you want to delete this Food with ID = " + id + "?")) {
                    window.location = "DeleteFood?idFood=" + id;
                    return true;
                }
                return false;
            }
        </script>
        <%}
        } else {

        %>
        <a href="Login.jsp"><h1>Login Before</h1></a>
        <%  }%>
    </body>
</html>
