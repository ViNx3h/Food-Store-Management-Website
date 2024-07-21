<%@page import="DAOs.FoodsDAO"%>
<%@page import="DAOs.OrdersDAO"%>
<%@page import="DAOs.BillsDAO"%>
<%@page import="Models.Foods"%>
<%@page import="Models.Customers"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="DAOs.CategoriesDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="Models.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Order</title><link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .navbar-brand img {
                width: 90px; /* Adjust the width as needed */
                height: auto; /* Maintain aspect ratio */
            }
            .separator {
                width: 100%;
                height: 2px;
                background-color: #dee2e6;
                margin: 30px 0;
            }
            .container {

                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                padding: 20px;
                margin-bottom: 20px;
            }
            .container h1, .container h2 {
                color: #343a40;
            }
            .container hr {
                border-top: 1px solid #dee2e6;
            }
            .navbar {
                margin-bottom: 20px;
            }
            .navbar-nav .nav-link {
                color: #495057;
            }
            .navbar-nav .nav-link:hover {
                color: #007bff;
            }
            .navbar-nav .dropdown-menu {
                background-color: #fff;
            }
            .navbar-nav .dropdown-item {
                color: #495057;
            }
            .navbar-nav .dropdown-item:hover {
                background-color: #f8f9fa;
            }
            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
            .total {
                color: #dc3545;
                font-size: 1.5rem;
                font-weight: bold;
            }
            footer {
                background-color: #17a2b8;

            }
            footer p {
                margin: 0;
            }
            .back-button {
                margin: 20px 0;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies();  
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
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container">
                    <a href="/FoodStoreManagement" class="navbar-brand">
                        <img src="<%= request.getContextPath()%>/images/logo.png" alt="Food Store Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">
                            <%
                                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                            %>
                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement/CustomersController/ShoppingCart">Shopping Cart (<%= scDAO.getQuantityOrder(value)%>)</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <%
                                CustomersDAO cDAO = new CustomersDAO();
                                Customers cus = cDAO.getCustomer(value);
                            %>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Welcome, <%= cus.getFullName()%></a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/FoodStoreManagement/ProfileCus.jsp">My Account</a></li>
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
        <main class="container bg-light">
            <h1 class="text-center">Order History</h1>
            <!-- Back to Index Button -->
            <div class="text back-button">
                <a class="btn btn-outline-secondary" href="/FoodStoreManagement">Back</a>
            </div>
            <%  
                BillsDAO bDAO = new BillsDAO();
                OrdersDAO oDAO = new OrdersDAO();
                FoodsDAO pDAO = new FoodsDAO();
                ResultSet rsBill = bDAO.getBill(value);

                while (rsBill.next()) {
            %>
            <div class="container border border-3 border-success p-3 mb-4">
                <div class="d-flex justify-content-between">
                    <p class="mb-0"><em><%= rsBill.getDate("orderDate")%></em></p>
                    <p><strong>Address:</strong> <%= bDAO.getAddress(rsBill.getInt("idOrder"))%></p>
                </div>
                <hr/>
                <%
                    ResultSet rsOrder = oDAO.getOrder(rsBill.getInt("idOrder"));
                    while (rsOrder.next()) {
                        Foods pro = pDAO.getProduct(rsOrder.getInt("idFood"));
                %>
                <div class="row mb-3">
                    <div class="col-sm-12 col-lg-4">
                        <h4><%= pDAO.getNameFoodById(rsOrder.getInt("idFood"))%> x<%= rsOrder.getInt("quantity")%></h4> 
                        <p><%= oDAO.getPrice(rsOrder.getInt("idFood"), rsBill.getInt("idOrder"))%> VND</p>
                    </div>
                    <div class="col-sm-12 col-lg-4 text-end">
                        <p><strong><%= oDAO.getAmount(rsOrder.getInt("idFood"), rsBill.getInt("idOrder"))%> VND</strong></p>
                        <p><strong>Status: <%= rsBill.getString("Confirm")%></strong></p>
                    </div>

                    <%
                                            if (rsBill.getString("Confirm").equalsIgnoreCase("Confirm")) {
                    %>

                    <div class="col-sm-12 col-lg-4 text-end">
                        <a href="/FoodStoreManagement/CustomersController/FeedBack_Process/<%= rsOrder.getInt("idFood")%>">
                            <button class="btn btn-outline-success">Feedback</button>
                        </a>
                    </div>
                    <%}%>


                </div><hr style=""/>
                <%
                    }
                %>
                <div class="mb-3">
                    <p><strong>Note:</strong> <%= bDAO.getNote(rsBill.getInt("idOrder"))%></p>
                    <p><strong>Phone:</strong> <%= bDAO.getPhone(rsBill.getInt("idOrder"))%></p>
                    <p class="total text-end"><strong>Total: <%= oDAO.getTotalPrice(rsBill.getInt("idOrder"))%> VND</strong></p>
                </div>
            </div>
            <hr/>
            <%
                }
            %>
        </main>  
    </div>
    <!-- Separator -->
    <div class="separator"></div>
    <footer class="bg-info text-white py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h5>Contact information</h5>
                    <p>Street 30/04, Hung Loi Ward, Ninh Kieu District, Can Tho Province</p>
                    <p>Email: ToanLTCE172023@fpt.edu.vn</p>
                    <p>Phone: 0949415422</p>
                </div>
                <div class="col-md-4">
                    <p class="text-center m-0">&copy; 2024 Food Store.</p>
                </div>
            </div>
        </div>
    </footer>
    <script src="
            https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
    </script>
    <%      } else {
                response.sendRedirect("/index.jsp");
            }
        } else {
            response.sendRedirect("/index.jsp");
        }
    %>
</body>
</html>