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
        <!-- Add css -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/homepage.css">
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
                    <a href="/FoodStoreManagement" class="navbar-brand"><img id="logo" src="<%= request.getContextPath()%>/image/logo.jpg" alt="Hame Logo"></a>
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
                                    <li><a class="dropdown-item" href="/AnimeStore/Product/<%= rs.getInt("id_category")%>"><%= rs.getString("name_category")%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </li>

                        </ul>
                        <ul class="navbar-nav" id="Cart">
                            <li class="nav-item" >
                                <%
                                    ShoppingCartDAO scDAO = new ShoppingCartDAO();
                                %>
                                <a  class="nav-link active" href="/AnimeStore/ShoppingCart"><img class="navbar-brand" id="logoOrder" src="<%= request.getContextPath()%>/imgs/cart.png" alt="Logo Order"> (<%= scDAO.getQuantityOrder(value)%>)</a>
                            </li>
                            <li class="nav-item dropdown">


                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" id="logBox">Welcome, </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/AnimeStore/MyAccount">My Account</a></li>
                                    <li><a class="dropdown-item" href="/AnimeStore/ViewOrder">View Order History</a></li>
                                    <li><a class="dropdown-item" href="Logout">Sign out</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <h1 class="text-center m-5">Shopping Cart</h1>
            <%
                int count = 0;
                FoodsDAO pDAO = new FoodsDAO();
                
                ResultSet rs2 = scDAO.getAll(value);
                while ( rs2.next() ) {
                    ++count;
                    Foods pro = pDAO.getProduct(rs2.getInt("idFood"));
            %>
            <div class="container d-flex border border-1 mb-5" style="padding: 0">
                <div class="col-sm-5 col-md-2 d-flex align-content-center p-3">
                    <img src="<%= pro.getPic()%>" style="height: 100px;" alt="<%= pro.getName_food()%>">
                </div>
                <div class="col-sm-7 col-md-10 pt-1">
                    <h4 class=""> <%= pro.getName_food()%></h4>
                    <form class="d-flex mt-3 mb-3" >
                        <div class="input-group">
                            <a class="text-center border btn btn-light" href="/FoodStoreManagement/CustomersController/downQuantity/<%=rs2.getInt("idFood")%>/<%= rs2.getInt("quantity")%>"name="downQuantity">-</a>
                            <input id="quantity" class="text-center border" type="text" value="<%= rs2.getInt("quantity")%>" style="width: 50px" readonly="">
                            <a class="text-center border btn btn-light" href="/FoodStoreManagement/CustomersController/upQuantity/<%=rs2.getInt("idFood")%>/<%= rs2.getInt("quantity")%>/<%= pro.getQuantity()%>" name="upQuantity">+</a>
                        </div>
                    </form>
                    <%
                        String upEror = (String) request.getSession().getAttribute("upEror");
                        String downError = (String) request.getSession().getAttribute("downError");
                        if (upEror == "false") {%>

                    <script type="text/javascript">
                        var up = '<%=session.getAttribute("upEror")%>';
                        if (up === "false") {
                            function alertUp() {
                                alert("Cannot increase");
                            }
                        }
                    </script>

                    <script type="text/javascript"> window.onload = alertUp;</script>

                    <%
                            request.getSession().removeAttribute("upEror");

                        }
                        if (downError == "false") {
                    %>
                    <script type="text/javascript">
                        var down = '<%=session.getAttribute("downError")%>';
                        if (down === "false") {
                            function alertDown() {
                                alert("Cannot be reduced");
                            }
                        }
                    </script>

                    <script type="text/javascript"> window.onload = alertDown;</script>

                    <%
                            request.getSession().removeAttribute("downError");
                        }
                    %>
                    <p><span class="text-danger" style="font-size: larger; font-weight: bold"><%= rs2.getInt("price")%>$</span>  |  <a href="/FoodStoreManagement/CustomersController/DeleteShoppingCart/<%= value%>/<%= pro.getIdFood()%>" class="text-dark">Delete</a></p>
                </div>
            </div>
            <%
                }
            %>

            <%
                if (count > 0) {
            %>
            <div class="text-center">
                <a class="btn btn-dark text-light mb-5" href="/AnimeStore/ViewOrder_Process">Check out</a>
            </div>
            <%
            } else {
            %>

            <p class="text-center text-danger">Your Shopping Cart is empty! Looking at some product at <a href="/FoodStoreManagement">here.</a></p>

            <%
                }
            %>

        </main>

        <script src="
                https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous">
        </script>
        <%      }
            } else {
                response.sendRedirect("/index.jsp");
            }
        %>
    </body>
</html>
