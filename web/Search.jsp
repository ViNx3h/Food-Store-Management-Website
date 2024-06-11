<%-- 
    Document   : Search.jsp
    Created on : Jun 4, 2024, 11:45:19 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Foods"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page import="java.util.List"%>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- Custom CSS -->
<link rel="stylesheet" href="css/homepage.css">

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container">
                <a class="navbar-brand" href="ListCategory"><img src="image/logo.png" alt="Logo"></a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <form class="form-inline">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchQuery" placeholder="Search food">
                                    <div class="input-group-append">
                                        <button class="btn btn-danger" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><i class="fas fa-user" id="user-icon"></i></a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Separator -->
        <div class="separator"></div>

        <% 
               String search =request.getParameter("search");
               FoodsDAO dao = new FoodsDAO();
                List<Foods> list = dao.searchFoods(search);  
                request.setAttribute("list", list);

        %>

        <table class="container table table-bordered" style="width: 40%">
            <thead class="thead-dark">
                <tr>
                    <th>Name of Food</th>
                    <th>Price</th>
                    <th>Picture</th>
                    <th>Description</th>   
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${requestScope.list}">
                    <tr>
                        <td>${c.name_food}</td>
                        <td>${c.price}</td>
                        <td><img src="${c.pic}" alt="${c.name_food}" class="img-thumbnail img-fluid" style="max-height: 100px; max-width: 100px;"/></td>
                        <td>${c.description}</td>
                        <td>${c.quantity}</td>
                        <td><a class="btn btn-primary btn-sm" href="#">Add to Cart</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Bootstrap JavaScript và các phụ thuộc -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
