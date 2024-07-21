<%@page import="DAOs.ShoppingCartDAO"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="DAOs.FeedbacksDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoriesDAO"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Food Detail</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/homepage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.css" type="text/css">
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/favicon-32x32.jpg">
        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- RateYo JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.js"></script>
        <style>
            .card-img-top {
                max-height: 350px;
                width:  550px;
                margin: auto;
                display: block;
                align-items: center;
            }
        </style>
        <!-- Custom JavaScript -->
        <script type="text/javascript">

            $(function () {
                $("#rating").rateYo({
                    rating: 0,
                    numStars: 5,
                    maxValue: 5,
                    halfStar: true,
                    onChange: function (rating, rateYoInstance) {
                        $('#hdrating').val(rating);
                    }
                });
            });



        </script>
        <%
            int id = (int) session.getAttribute("id");
            FeedbacksDAO fDAO = new FeedbacksDAO();
            ResultSet rs1 = fDAO.getAll(id);
            double rate = fDAO.getRatingAvg(id);

        %>
        <script type="text/javascript">
            $(function () {
                $("#rateyo-overall").rateYo({
                    rating: <%= rate%>,
                    readOnly: true
                });
            });
        </script>

        <%

            Cookie[] cList = null;
            cList = request.getCookies();
            boolean flagCustomer = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) {
                    if (cList[i].getName().equals("customer")) {
value = cList[i].getValue();
                        flagCustomer = true;
                        break;
                    }
                }
        %>
    </head>




    <body>
        <header>
            <!-- Menu -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container">
                    <a href="/FoodStoreManagement" class="navbar-brand" style="width: 90px;"><img id="logo" src="<%= request.getContextPath()%>/images/logo.png" alt="HomePage" style="width: 100%; height: auto;"></a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <ul class="navbar-nav">
                        </ul>
                        <ul class="navbar-nav" id="Cart">
                            <li class="nav-item" >
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
        <%
            FoodsDAO pDAO = new FoodsDAO();

//            CustomersDAO cDAO = new CustomersDAO();
            ResultSet rs = pDAO.getAll(id);
            while (rs.next()) {

        %>
        <div class="container mt-5">
            <div class="row">
                <div class="col-12 col-md-6">
                    <% while (rs.next()) { %>
                    <div class="card mb-3">
                        <a href="/FoodStoreManagement/CustomersController/FoodDetail_Process/<%= pDAO.getFoodById(rs.getInt("idFood")) %>">
                            <img class="card-img-top" src="<%= rs.getString("pic") %>" alt="Card image">
                        </a>
                        <div class="card-body text-center">
                            <h4 class="card-title"><%= rs.getString("name_food") %></h4>
                            <p class="card-text">
                                <small><em><%= rs.getString("description") %></em></small><br>
                                <small>Quantity: <%= rs.getInt("quantity") %></small><br>
                                <strong><%= rs.getInt("price") %> VND</strong>
                            </p>
                            <a href="CustomersController/AddCart/<%= rs.getInt("idFood") %>" class="btn btn-primary btn-sm">Add to Cart</a>
                        </div>
                    </div>
                    <% } %>
                </div>
                <%}
                    if (flagCustomer) {
                        ResultSet rs2 = pDAO.getAll(id);
                        while (rs2.next()) {
                %>
                <div>
                    <img class="card-img-top border border-1" src="<%= request.getContextPath()%>/<%= rs2.getString("pic") %>" alt="Card image">
                </div>
                <h1 class="mb-5"><%= rs2.getString("name_food") %></h1>
                <form action="" method="post">
                    <div class="mb-3">
                        <label for="rating" class="form-label">Rating</label>
                        <div id="rating"></div>
                        <input type="hidden" id="hdrating" name="hdrating">
                    </div>
                    <div class="mb-3">
                        <label for="content" class="form-label">Content</label>
                        <textarea class="form-control" id="content" name="content" rows="5" cols="20"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" name="btnFeedBack">Send Feedback</button>
                    <input type="hidden" name="productID" value="<%= pDAO.getFoodById(rs2.getInt("idFood")) %>">
                </form>


                <%
                            }
                        }
                    }

                %>
            </div>
        </div>



        <hr>
        <div>
            <footer class="bg-info text-white py-3">
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
        </div>
        </hr>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>




