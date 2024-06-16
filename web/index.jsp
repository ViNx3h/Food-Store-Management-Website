<%-- 
    Document   : index
    Created on : Jun 4, 2024, 10:07:55 PM
    Author     : ADMIN
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page import="DAOs.ShoppingCartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Categories"%>
<%@page import="DAOs.CategoriesDAO"%>
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
        <link rel="stylesheet" href="css/homepage.css">

    </head>

    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container">
            <a class="navbar-brand" href="/FoodStoreManagement"><img src="image/logo.png" alt="Logo"></a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <form action="Search.jsp" class="form-inline">
                            <div class="input-group">
                                <input type="text" class="form-control" id="searchQuery" name="search" placeholder="Search food">
                                <div class="input-group-append">
                                    <button class="btn btn-danger" type="submit">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </li>
                    <%
                        Cookie[] cList = null;
                        cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
                        boolean flagCustomer = false;
                        if (cList != null) {
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
                    <li class="nav-item">
                        <%
                            ShoppingCartDAO scDAO = new ShoppingCartDAO();
                        %>

                        <a class="nav-link" href="CustomersController/ShoppingCart"><i class="fas fa-shopping-cart"></i> (<%= scDAO.getQuantityOrder(value)%>)</a>
                    </li>
                    <%
                            }
                        } else {
                            response.sendRedirect("/FoodStoreManagement");
                        }
                    %>
                    <%if (flagCustomer) {%>

                    <li class="nav-item">
                        <div class="dropdown-container">
                            <a class="nav-link" href="#"><i class="fas fa-user" id="user-icon"></i></a>
                            <div class="dropdown-menu" id="dropdownMenu">
                                <a href="ProfileCus.jsp">Profile</a>
                                <a href="Logout">Logout</a>
                            </div>
                        </div>    
                    </li>
                    <%} else {
                    %>
                    <a href="Login.jsp">Login</a>
                    <a href="SignUp.jsp">Sign Up</a>
                    <%}%>
            </div>
            </ul>
        </div>
    </div>
</nav>
<!-- Separator -->
<div class="separator"></div>

<div class="container">
    <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
        <!-- Indicators -->
        <ul class="carousel-indicators">
            <li data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#mainCarousel" data-bs-slide-to="1"></li>
        </ul>

        <!-- The slideshow -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="main">
                    <div class="men_text">
                        <h1><span class="fw-bold">Best Seller</span><br> </h1>
                        <h2 class="h2" id="h2">Hamburger</h2>
                        <p>
                            "A hamburger, also known as a burger, is a popular fast food enjoyed worldwide. 
                            It consists of a grilled or fried ground beef patty, typically placed inside a sliced bread roll or bun.
                            It is often accompanied by various toppings such as lettuce, tomato, onion, and sauces like mayonnaise, ketchup, 
                            or mustard. Hamburger is commonly served with side dishes like french fries or salads."
                        </p>
                    </div>
                    <div class="main_image">
                        <img src="image/main_img.png" class="d-block w-100" alt="Fresh Food">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="main">
                    <div class="men_text">
                        <h1><span class="fw-bold">Best Seller</span><br> </h1>
                        <h2 class="h2" id="h2">Hot dog</h2>
                        <p>
                            "Hot dog, also known as a frankfurter or wiener, 
                            is a type of sausage served in a sliced bun. The sausage is usually made
                            from beef, pork, or a combination of meats, and it may be grilled or steamed. 
                            Hot dogs are commonly topped with condiments such as mustard, ketchup,
                            relish, onions, and sometimes sauerkraut or cheese. 
                            They are often enjoyed at sporting events, picnics, and cookouts."
                        </p>
                    </div>
                    <div class="main_image">
                        <img src="image/Hot_dog.jpg" class="d-block w-100" alt="Fresh Food">
                    </div>
                </div>
            </div>
        </div>

        <!-- Left and right controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>
<main>
    <div class="container mt-5">
        <hr>
        <%  
            CategoriesDAO cDAO = new CategoriesDAO();
            FoodsDAO pDAO = new FoodsDAO();
            ResultSet rs = cDAO.getAll();
            while (rs.next()) {
                ResultSet rs2 = pDAO.getTop4(rs.getInt("id_category"));
        %>
        <a href="/FoodStoreManagement/Foods.jsp?id=<%=rs.getInt("id_category")%>"> <h1 class="text-center"><%= rs.getString("name_category")%></h1></a>
        <div class="row" id="card-wool">
            <%
                while (rs2.next()) {
            %>
            <div class="col-sm-6 col-md-3">
                <div class="card p-1">
                    <img class="card-img-top" src="<%= request.getContextPath()%>/imgs/<%= rs2.getString("pic")%>" alt="Card image">
                    <div class="card-body text-center">
                        <h4 class="card-title"><%= rs2.getString("name_food")%></h4>
                        <div class="card-text">
                            <small class="mt-3"><em><%= rs2.getString("description")%></em></small><br/>
                            <small>Quantity: <%= rs2.getInt("quantity")%></small>
                            <h5><strong><%= rs2.getInt("price")%>$</strong></h5>

                        </div>
                        <a href="CustomersController/AddCart/<%= rs2.getInt("idFood")%>" class="btn">Add Cart</a>
                    </div>

                </div>
            </div>
            <%                }
            %>
        </div>
        <div class="text-center m-5">
            <a href="CustomersController/Food/<%= rs.getInt("id_category")%>" class="btn" id="look-all">All items</a>
        </div>
        <hr>
        <%
            }
        %>
    </div>
</main>       
<footer class="bg-primary text-white py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <h5>Contact information</h5>
                <p>Đường 30/04 Phường Hưng Lợi huyện Ninh Kiều tỉnh Cần Thơ</p>
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
<script>
    document.getElementById("user-icon").addEventListener("click", function (event) {
        event.preventDefault();
        var dropdownMenu = document.getElementById("dropdownMenu");
        if (dropdownMenu.style.display === "block") {
            dropdownMenu.style.display = "none";
        } else {
            dropdownMenu.style.display = "block";
        }
    });

    // Close the dropdown if the user clicks outside of it
    window.onclick = function (event) {
        if (!event.target.matches('#user-icon')) {
            var dropdowns = document.getElementsByClassName("dropdown-menu");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.style.display === "block") {
                    openDropdown.style.display = "none";
                }
            }
        }
    }

</script>
<!-- Bootstrap JavaScript và các phụ thuộc -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
