<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="Models.Customers"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="Models.Foods"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page import="DAOs.OrdersDAO"%>
<%@page import="DAOs.OrdersDAO"%>
<%@page import="DAOs.BillsDAO"%>
<%@page import="DAOs.BillsDAO"%>
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
            .navbar-brand img {
                width: 90px; /* Adjust the width as needed */
                height: auto; /* Maintain aspect ratio */
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
                    <a href="/FoodStoreManagement" class="navbar-brand"><img  id="logo" src="<%= request.getContextPath()%>/images/logo.png" alt="Hame Logo"></a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <%
                                    ShoppingCartDAO scDAO = new ShoppingCartDAO();
                                %>
                                <a class="nav-link" href="/FoodStoreManagement/CustomersController/ShoppingCart">Shopping Cart (<%= scDAO.getQuantityOrder(value)%>)</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <%
                                    CustomersDAO cDAO = new CustomersDAO();
                                    Customers cus = cDAO.getCustomer(value);
                                %>
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Welcome, <%= cus.getFullName()%></a>
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

        <main class="bg-light">
            <h1 class="text-center pb-5">Your Bill</h1>
            <%
                int id = (int) session.getAttribute("id");
                BillsDAO bDAO = new BillsDAO();
                OrdersDAO oDAO = new OrdersDAO();
                FoodsDAO pDAO = new FoodsDAO();
                ResultSet rsBill = bDAO.getBillById(id);
                while (rsBill.next()) {
            %>
            <div class="container border border-3 border-success p-2 mb-5" style="">
                <div class="d-flex justify-content-between">
                    <p style="margin-bottom: 0"><em><%= rsBill.getDate("orderDate")%></em></p>
                    <label for="note" class="form-label">Address: <%= bDAO.getAddress(rsBill.getInt("idOrder"))%></label>
                </div><hr style=""/>

                <%
                    ResultSet rsOrder = oDAO.getOrder(rsBill.getInt("idOrder"));
                    while (rsOrder.next()) {
                        Foods pro = pDAO.getProduct(rsOrder.getInt("idFood"));
                %>
                <div class="row p-2">
                    <div class="col-sm-12 col-lg-4">
                        <h4><%= pro.getName_food()%> x<%= rsOrder.getInt("quantity")%> </h4> 
                        <p><%= oDAO.getPrice(rsOrder.getInt("idFood"), rsBill.getInt("idOrder"))%> VND</p>

                    </div>
                    <div class="col-sm-12 col-lg-4">
                        <p class="d-flex justify-content-end"><strong><%= oDAO.getAmount(rsOrder.getInt("idFood"), rsBill.getInt("idOrder"))%> VND</strong></p>
                    </div>
                </div><hr style=""/>
                <%
                    }
                %>
                <div class="mb-3">
                    <label for="note" class="form-label">Note: <%= bDAO.getNote(rsBill.getInt("idOrder"))%></label>
                    <br>
                    <label for="note" class="form-label">Address <%= bDAO.getAddress(rsBill.getInt("idOrder"))%></label>
                    <br>
                    <label for="note" class="form-label">Phone: <%= bDAO.getPhone(rsBill.getInt("idOrder"))%></label>
                </div>
                <p class="d-flex justify-content-end" style="color: #dc3545; font-size: x-large"><strong>Total: <%= oDAO.getTotalPrice(rsBill.getInt("idOrder"))%> VND</strong></p>
            </div>

            <%
                }
            %>
        </main>                        

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