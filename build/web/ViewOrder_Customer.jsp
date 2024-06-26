<%-- 
    Document   : ViewOrder
    Created on : Nov 5, 2023, 5:27:53 PM
    Author     : Admin
--%>

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
        <!-- Add css -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home_product.css">
    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                boolean flagCustomer = false;
                String value = "";
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagCustomer) {
        %>
        <header>
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <a href="/FoodStoreManagement" class="navbar-brand"><img id="logo" src="<%= request.getContextPath()%>/imgs/Logo.jpg" alt="Hame Logo"></a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">

                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Product</a>
                                <ul class="dropdown-menu">
                                    <%
                                        CategoriesDAO tDAO = new CategoriesDAO();
                                        ResultSet rs = tDAO.getAll();
                                        while (rs.next()) {
                                    %>
                                    <li><a class="dropdown-item" href="CustomersController/Food/<%= rs.getInt("id_category")%>"><%= rs.getString("name_category")%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </li>
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
                                    <li><a class="dropdown-item" href="#">My Account</a></li>
                                    <li><a class="dropdown-item" href="/FoodStoreManagement/CustomersController/ViewOrder">View Order History</a></li>
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
                BillsDAO bDAO = new BillsDAO();
                OrdersDAO oDAO = new OrdersDAO();
                FoodsDAO pDAO = new FoodsDAO();
                ResultSet rsBill = bDAO.getBill(value);
                while (rsBill.next()) {
            %>
            <div class="container border border-3 border-success p-2 mb-5" style="">
                <div class="d-flex justify-content-between">
                    <p><strong>Bill: <%= rsBill.getInt("idOrder")%></strong></p>
                    <p style="margin-bottom: 0"><em><%= rsBill.getDate("orderDate")%></em></p>
                </div><hr style=""/>

                <%
                    ResultSet rsOrder = oDAO.getOrder(rsBill.getInt("idOrder"));
                    while (rsOrder.next()) {
                        Foods pro = pDAO.getProduct(rsOrder.getInt("idFood"));
                %>
                <div class="row p-2">
                    <div class="col-sm-2 col-lg-3">
                        <img src="<%= request.getContextPath()%>/imgs/<%= pro.getPic()%>" style="width: 40%" alt="<%= pro.getName_food()%>"/>
                    </div>
                    <div class="col-sm-6 col-lg-6">
                        <h4><%= pro.getName_food()%></h4>
                        <p>x<%= rsOrder.getInt("quantity")%></p>
                    </div>
                    <div class="col-sm-4 col-lg-3">
                        <p class="d-flex justify-content-end"><strong><%= rsOrder.getInt("price")%>$</strong></p>
                    </div>

                    <div class="mb-3">
                        <label for="note" class="form-label">Note: <%= bDAO.getNote(value)%></label>
                        <label for="note" class="form-label">Address: <%= bDAO.getAddress(value)%></label>
                        <label for="note" class="form-label">Phone: <%= bDAO.getPhone(value)%></label>
                        <textarea class="form-control" id="note" rows="3"></textarea>
                    </div>

                </div><hr style=""/>
                <%
                    }
                %>

                <p class="d-flex justify-content-end" style="color: #dc3545; font-size: x-large"><strong>Total: <%= rsBill.getInt("total_quantity")%>$</strong></p>
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
