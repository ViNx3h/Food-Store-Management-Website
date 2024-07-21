<%-- 
    Document   : EmployeeSearchFoodbyCategory
    Created on : Jun 14, 2024, 8:02:26 PM
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
        <link rel="stylesheet" href="css/dashBoardEmployee.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>body {
                background-color: #f8f9fa; /* Màu nền */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Font chữ */
            }

            .container-fluid {
                margin-top: 50px; /* Khoảng cách từ đỉnh trang xuống nội dung */
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
            .search-container {
                margin-bottom: 20px; /* Khoảng cách dưới của khối tìm kiếm */
                background-color: #ffffff; /* Màu nền */
                border: 1px solid #ced4da; /* Viền */
                border-radius: 5px; /* Bo góc */
                padding: 15px; /* Khoảng cách bên trong */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Đổ bóng */
            }

            .search-container h4 {
                margin-bottom: 10px; /* Khoảng cách dưới của tiêu đề tìm kiếm */
            }

            .form-control {
                font-size: 1em; /* Cỡ chữ */
            }

            .btn-danger {
                background-color: #dc3545; /* Màu nền nút Danger */
                border: none; /* Loại bỏ viền */
            }

            .btn-danger:hover {
                background-color: #c82333; /* Màu nền nút Danger khi hover */
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

            .btn-warning, .btn-danger {
                margin-top: 1em;
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
if (cList[i].getName().equals("employee")) { 
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
                                <a class="nav-link active" aria-current="page" href="DashBoardEmployee.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AddFoodbyEm.jsp">
                                    <i class="fas fa-plus-circle"></i> Add New Food
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="ProfileEm.jsp">
                                    <i class="fas fa-user-circle"></i> View Profile
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="ViewSchedulebyEm.jsp">
                                    <i class="fas fa-calendar-alt"></i> Working Schedule
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ManageStatus.jsp">
                                    <i class="fas fa-calendar-alt"></i> Status Order
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
                            <form action="EmployeeSearchFood" class="form-inline" method="doGet">
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
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Food Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Picture</th>
                                <th scope="col">Description</th>
                                <th scope="col">Status</th>
                                <th scope="col">ID of Category</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Product items will be dynamically added here -->
                            <c:forEach var="c" items="${requestScope.list}">
                                <tr>
                                    <th scope="row">${c.idFood}</th>
                                    <td>${c.name_food}</td>
                                    <td>${c.price} VND</td>
                                    <td>${c.quantity}</td>
                                    <td><img style="max-width: 230px" src="${c.pic}" alt="${c.name_food}" class="img-thumbnail img-fluid" style="max-height: 100px; max-width: 100px;"/></td>
                                    <td style="max-width: 230px">${c.description}</td>
                                    <td> ${(c.status ? "Available" : "Unavailable") }</td>
                                    <td>${c.categoryName}</td>
                                    <td>
                                        <a href="UpdateFoodbyEm.jsp?id=${c.idFood}" type="button" class="btn btn-outline-warning btn-sm btn-custom">Update</a>
                                        <a href="DeleteFood?id=${c.idFood}" onclick="return confirmDeleteProduct('${c.idFood}')" type="button" class="btn btn-outline-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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
<%}}
else{
                    
%>
<a href="Login.jsp"><h1>Login Before</h1></a>
<%  }%>
</body>
</html>
