<%-- 
    Document   : DashBoardAdmin
    Created on : Jun 5, 2024, 4:36:42 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Foods"%>
<%@page import="DAOs.FoodsDAO"%>
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
        <link rel="stylesheet" href="css/dashBoardAdmin.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/2.0.7/css/dataTables.dataTables.css" />

        <link rel="stylesheet" href="https://cdn.datatables.net/2.0.7/css/dataTables.dataTables.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <script src="https://cdn.datatables.net/2.0.7/js/dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table1').DataTable();
            });
        </script>

    </head>
    <body>             
        <%
    Cookie[] cookies = request.getCookies();
    String username = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
    }
    request.setAttribute("username", username);
        %>


        <c:if test="${not empty username}">
            <div class="container mt-5">
                <h1>Admin Dashboard</h1>
                <!-- Product List -->
                <%
                   String id = request.getParameter("id");
                   FoodsDAO dao = new FoodsDAO();
                   List<Foods> list = dao.getAllFoods();
                   request.setAttribute("list", list);
                %>
                <a href="AddFood.jsp" type="button" class="btn btn-warning btn-sm me-2">Add new Food</a>
                <a href="ViewEditingDetail.jsp" type="button" class="btn btn-warning btn-sm me-2">View Editing Detail</a>
                <a href="ViewCategories.jsp" type="button" class="btn btn-warning btn-sm me-2">View Category</a>
                <a href="Employees.jsp" type="button" class="btn btn-warning btn-sm me-2">View Employee</a>
                <a href="Customers.jsp" type="button" class="btn btn-warning btn-sm me-2">View Customer</a>
                <a href="Logout">LogOut</a>
                <div>
                    <h3>Product List</h3>
                    <table class="table" id="table1">
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
                                    <td>${c.price}</td>
                                    <td>${c.quantity}</td>
                                    <td><img style="max-width: 230px" src="${c.pic}" alt="${c.name_food}" class="img-thumbnail img-fluid" style="max-height: 100px; max-width: 100px;"/></td>
                                    <td style="max-width: 230px">${c.description}</td>
                                    <td> ${(c.status ? "Available" : "Unavailable") }</td>
                                    <td>${c.id_category}</td>
                                    <td>
                                        <a href="UpdateFood.jsp?id=${c.idFood}" type="button" class="btn btn-warning btn-sm me-2">Update</a>
                                        <a href="#" onclick="confirmDeleteProduct('${c.idFood}')" type="button" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
        <c:if test="${empty username}">
            <a href="Login.jsp"><h1>Login Before</h1></a>
        </c:if>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
        <script>
                                            function confirmDeleteProduct(id) {
                                                if (confirm("Are you sure you want to delete this Food with ID = " + id + "?")) {
                                                    window.location = "DeleteFood?idFood=" + id;
                                                }
                                            }
        </script>
    </body>
</html>
