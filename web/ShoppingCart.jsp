<%-- 
    Document   : ShoppingCart
    Created on : Jun 11, 2024, 9:28:24 PM
    Author     : ADMIN
--%>

<%-- 
    Document   : ShoppingCart
    Created on : Nov 5, 2023, 5:27:43 PM
    Author     : Admin
--%>

<%@page import="Models.Foods"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="Models.Customers"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoriesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home_product.css">
        <style>
            .shopping-cart-container {
                border: 1px solid #ccc;
                padding: 0;
                margin-bottom: 20px;
            }
            .product-image {
                height: 100px;
                object-fit: cover;
            }
            .product-details {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 15px;
            }
            .product-name {
                font-weight: bold;
                font-size: 1.2em;
            }
            .quantity-input {
                width: 50px;
                text-align: center;
            }
            .total-price {
                font-size: 1.2em;
                font-weight: bold;
                color: #dc3545;
            }
            .delete-link {
                color: #000;
                text-decoration: none;
            }
            .custom-button {
                background-color: #007bff; /* Màu nền */
                color: #ffffff; /* Màu chữ */
                border: none; /* Bỏ viền */
                padding: 10px 20px; /* Kích thước nút */
                cursor: pointer; /* Con trỏ khi rê chuột */
                border-radius: 5px; /* Bo góc */
                text-decoration: none; /* Bỏ gạch chân nếu nút dùng thẻ a */
                display: inline-block;
                transition: background-color 0.3s ease; /* Hiệu ứng hover */
            }

            .custom-button:hover {
                background-color: #0056b3; /* Màu nền khi hover */
            }
            .separator {
                width: 100%;
                height: 2px;
                background-color: #ccc;
                margin: 20px 0;
            }
            .footer {
                background-color: #f8f9fa; /* Light background color */
                padding: 10px 0; /* Padding for the footer */
                position: relative; /* Ensure footer stays at the bottom */
                bottom: 0; /* Align to bottom */
                width: 100%; /* Full width */
                margin-top: auto; /* Push to bottom when content is short */
            }
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            main {
                flex: 1;
            }

        </style>
    </head>
    <body>
        <%
            Cookie[] cList = request.getCookies();  
            if (cList != null) {
                boolean flagCustomer = false;
                String value = "";
                for (int i = 0; i < cList.length; i++) { 
                    if (cList[i].getName().equals("customer")) { 
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break;  
                    }
                }
                if (flagCustomer) {
        %>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container">
                    <a href="/FoodStoreManagement" class="navbar-brand" style="display: inline-block; width: 90px;">
                        <img id="logo" src="<%= request.getContextPath()%>/images/logo.png" alt="HomePage" style="width: 100%; height: auto;">
                    </a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">
                            </li>
                        </ul>
                        <ul class="navbar-nav" id="Cart">
                            <li class="nav-item">
                                <%
                                    ShoppingCartDAO scDAO = new ShoppingCartDAO();
                                %>
                            </li>
                            <li class="nav-item dropdown">
                                <%
                                    CustomersDAO cDAO = new CustomersDAO();
                                %>
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" id="logBox">Welcome, <%= cDAO.getfullName(value)%></a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/FoodStoreManagement/ProfileCus.jsp">My Account</a></li>
                                    <li><a class="dropdown-item" href="/FoodStoreManagement/CustomersController/ViewOrderHistory">View Order</a></li>
                                    <li><a class="dropdown-item" href="/FoodStoreManagement/Logout">Sign out</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <!-- Separator -->
        <div class="separator"></div>
        <main>
            <h1 class="text-center m-5">Shopping Cart</h1>
            <%
                int count = 0;
                FoodsDAO pDAO = new FoodsDAO();
                ResultSet rs2 = scDAO.getAll(value);
                while (rs2.next()) {
                    ++count;
                    Foods pro = pDAO.getProduct(rs2.getInt("idFood"));
            %>
            <div class="container shopping-cart-container">
                <div class="row product-details">
                    <div class="col-md-2">
                        <img src="<%= request.getContextPath()%>/<%= pro.getPic()%>" class="product-image" alt="<%= pro.getName_food()%>">
                    </div>
                    <div class="col-md-3 product-name">
                        <%= pro.getName_food()%>
                    </div>
                    <div class="col-md-3">
                        <form class="d-flex">
                            <div class="input-group">
                                <a class="btn btn-light" href="/FoodStoreManagement/CustomersController/downQuantity/<%=rs2.getInt("idFood")%>/<%= rs2.getInt("quantity")%>" name="downQuantity">-</a>
                                <input id="quantity" class="quantity-input border" type="text" value="<%= rs2.getInt("quantity")%>" readonly>
                                <a class="btn btn-light" href="/FoodStoreManagement/CustomersController/upQuantity/<%=rs2.getInt("idFood")%>/<%= rs2.getInt("quantity")%>/<%= pro.getQuantity()%>" name="upQuantity">+</a>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3 total-price">
                        <%= scDAO.getTotalPrice(rs2.getInt("idFood"))%> VND
                    </div>
                    <div class="col-md-1">
                        <button class="btn btn-outline-danger " onclick="window.location.href = '/FoodStoreManagement/CustomersController/DeleteShoppingCart/<%= value%>/<%= pro.getIdFood()%>'">Delete</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>

            <%
                if (count > 0) {
            %>
            <form action="" method="post">
                <div class="container border border-1 mb-5">
                    <div class="form-group">
                        <label for="noteTXT">Note:</label>
                        <input type="text" class="form-control" id="noteTXT" placeholder="What's your note?" name="noteTXT">
                    </div>
                    <div class="form-group">
                        <label for="addressTXT">Address:</label>
                        <input required="" type="text" class="form-control" id="addressTXT" placeholder="What's your address?" name="addressTXT">
                    </div>
                    <div class="form-group">
                        <label for="phoneTXT">Phone:</label>
                        <input required="" type="text" class="form-control" id="phoneTXT" placeholder="What's your phone?" name="phoneTXT">
                    </div>
                </div>
                <!-- Back to Index Button -->

                <div class="text-center">
                    <a class="btn btn-outline-secondary" href="/FoodStoreManagement">Back</a>

                    <button type="submit" href="/FoodStoreManagement/CustomersController/ViewOrder_Process" class="btn btn-primary" name="btnCheckOut">Check out</button>
                </div>
            </form>
            <%
            } else {
            %>

            <p class="text-center text-danger">Your Shopping Cart is empty! Look at some products <a href="/FoodStoreManagement">here</a>.</p>

            <%
                }
            %>
        </main>
        <!-- Separator -->
        <div class="separator"></div>
        <footer class="bg-info text-white py-3 justify-content-end mt-auto footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-8">
                        <h5>Contact information</h5>
                        <p>Street 30/04, Hung Loi Ward, Ninh Kieu District, Can Tho Province</p>
                        <p>Email: ToanLTCE172023@fpt.edu.vn</p>
                        <p>Phone: 0949415422</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <p>&copy; 2024 Food Store.</p>
                    </div>
                </div>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
        <%
            }
            } else {
                response.sendRedirect("/index.jsp");
            }
        %>
    </body>
</html>

