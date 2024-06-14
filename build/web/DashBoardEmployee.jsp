<%-- 
    Document   : DashBoardEmployee
    Created on : Jun 7, 2024, 7:30:26 PM
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
                <h1>Employee Dashboard</h1>
                <!-- Product List -->
                <%
                   String id = request.getParameter("id");
                   FoodsDAO dao = new FoodsDAO();
                   List<Foods> list = dao.getAllFoods();
                   request.setAttribute("list", list);
                %>

                <a href="AddFoodbyEm.jsp" type="button" class="btn btn-warning btn-sm me-2">Add new Food</a>
                <a href="ProfileEm.jsp" type="button" class="btn btn-warning btn-sm me-2">Profile</a>
                

                <div>
                    <h3>Product List</h3>
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
                                    <td>${c.price}</td>
                                    <td>${c.quantity}</td>
                                    <td><img style="max-width: 230px" src="${c.pic}" alt="${c.name_food}" class="img-thumbnail img-fluid" style="max-height: 100px; max-width: 100px;"/></td>
                                    <td style="max-width: 230px">${c.description}</td>
                                    <td> ${(c.status ? "Available" : "Unavailable") }</td>
                                    <td>${c.id_category}</td>
                                    <td>
                                        <a href="UpdateFoodbyEm.jsp?id=${c.idFood}" type="button" class="btn btn-warning btn-sm me-2">Update</a>
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        <script>
                                            function confirmDeleteProduct(id) {
                                                if (confirm("Are you sure you want to delete this Food with ID = " + id + "?")) {
                                                    window.location = "DeleteFoodbyEm?idFood=" + id;
                                                }
                                            }
        </script>
    </body>
</html>
