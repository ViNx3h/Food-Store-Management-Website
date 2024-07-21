<%-- 
    Document   : Search.jsp
    Created on : Jun 4, 2024, 11:45:19 PM
    Author     : ADMIN
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Foods"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ShoppingCartDAO"%>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- Custom CSS -->
<link rel="stylesheet" href="css/index.css">

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/index.css">
        <title>Home Page</title>
    </head>
    <body>
        <%
             // Fetch all cookies
             Cookie[] cList = request.getCookies();  
             boolean flagCustomer = false;
             String customerValue = "";

             // Check for 'customer' cookie
             if (cList != null) {
                 for (Cookie cookie : cList) { 
                     if (cookie.getName().equals("customer")) { 
                         customerValue = cookie.getValue();
                         flagCustomer = true;
                         break;  
                     }
                 }
             }
        %>

        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container">
                <a class="navbar-brand" href="/FoodStoreManagement"><img src="images/logo.png" alt="Logo"></a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <form action="Search.jsp" class="form-inline">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search" id="searchQuery" placeholder="Search food">
                                    <div class="input-group-append">
                                        <button class="btn btn-danger" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </li>

                        <% if(flagCustomer) { %>
                        <li class="nav-item">
                            <%
                                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                            %>
                            <a class="nav-link" href="CustomersController/ShoppingCart"><i class="fas fa-shopping-cart"></i> (<%= scDAO.getQuantityOrder(customerValue) %>)</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link" href="#" id="user-icon" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user"></i>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="user-icon">
                                <li><a class="dropdown-item" href="ProfileCus.jsp">Profile</a></li>
                                <li><a class="dropdown-item" href="/FoodStoreManagement/CustomersController/ViewOrder">View Order</a></li>
                                <li><a class="dropdown-item" href="Logout">Logout</a></li>
                            </ul>
                        </li>
                        <% } else { %>
                        <li class="nav-item dropdown">
                            <a class="nav-link" href="#" id="user-icon" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user"></i>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="user-icon">
                                <li><a class="dropdown-item" href="Login.jsp">Login</a></li>
                                <li><a class="dropdown-item" href="SignUp.jsp">Sign Up</a></li>
                            </ul>
                        </li>
                        <% } %>
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
                                <img src="images/main_img.png" class="d-block w-100" alt="Fresh Food">
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
                                <img src="images/Hot_dog.jpg" class="d-block w-100" alt="Fresh Food">
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
        <!-- Separator -->
        <div class="separator"></div>
        <div class="container">
            <div class="row">
                <% 
                       String search =request.getParameter("search");
                       FoodsDAO dao = new FoodsDAO();
                        List<Foods> list = dao.searchFoods(search);  
                        request.setAttribute("list", list);
                %>
                <c:forEach var="c" items="${requestScope.list}">
                    <div class="col-sm-6 col-md-3 mb-3">
                        <div class="card h-100 p-1">
                            <a href="/FoodStoreManagement/CustomersController/FoodDetail_Process/${c.idFood}"><img class="card-img-top" src="${c.pic}" alt="${c.name_food}"></a>
                            <div class="card-body text-center">
                                <h4 class="card-title">${c.name_food}</h4>
                                <div class="card-text">
                                    <small class="mt-3">
                                        <em>${c.description}</em>
                                    </small><br/>
                                    <small>Quantity: ${c.quantity}</small>
                                    <h5><strong>${c.price} VND</strong></h5>
                                </div>
                                <a href="CustomersController/AddCart/${c.idFood}" class="btn btn-outline-warning">Add to Cart</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <a href="/FoodStoreManagement" class="btn btn-secondary">Back</a>
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

        <!-- Bootstrap JavaScript và các phụ thuộc -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
