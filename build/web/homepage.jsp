<%-- 
    Document   : homepage
    Created on : Jun 2, 2024, 6:15:40 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/homepage.css">

        <title>HomePage</title>

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

        <div class="container">
            <div class="row justify-content-start">
                <c:forEach var="c" items="${requestScope.list}">
                    <div class="col-auto category">
                        <h4>${c.name_category}</h4>
                        <a href="ListFood?id=${c.id_category}"><img src="${c.img_category}" class="img-fluid" alt="${c.name_category}">
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- Bootstrap JavaScript và các phụ thuộc -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
