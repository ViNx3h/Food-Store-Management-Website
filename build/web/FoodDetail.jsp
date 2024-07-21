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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Food Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.css" type="text/css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.js"></script>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
        <style>
            .card-img-top {
                max-height: 350px;
                margin: auto;
                display: block;
            }
        </style>
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

        <style>
            #rateyo-overall {
                display: block;
                margin: 0 auto; /* Căn giữa theo chiều ngang */
            }
        </style>


    </head>
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
                        <li class="nav-item">
                        </li>
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
                                if(flagCustomer){
                            %>
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" id="logBox">Welcome, <%= cDAO.getfullName(value)%></a>
                            <%}%>
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
    <body>

        <%
FoodsDAO pDAO = new FoodsDAO();


            ResultSet rs = pDAO.getAll(id);
            while (rs.next()) {

        %>
        <div class="container mt-5">
            <div class="row">
                <div class="col-12 col-sm-6 card mx-auto">
                    <!-- Paste your existing HTML snippet here -->
                    <div class="card p-1">
                        <a href="/FoodStoreManagement/CustomersController/FoodDetail_Process/<%= pDAO.getFoodById(rs.getInt("idFood")) %>">
                            <img class="card-img-top" src="<%= request.getContextPath() %>/<%= rs.getString("pic") %>" alt="Card image" >
                        </a>
                        <div class="card-body text-center">
                            <h4 class="card-title"><%= rs.getString("name_food") %></h4>
                            <div class="card-text">
                                <small class="mt-3"><em><%= rs.getString("description") %></em></small><br/>
                                <small>Quantity: <%= rs.getInt("quantity") %></small>
                                <h5><strong><%= rs.getInt("price") %>VND</strong></h5>

                                <div id="rateyo-overall"></div>
                                <small>Overall rating: <%= rate %> stars</small>
                            </div>
                            <a href="/FoodStoreManagement/CustomersController/AddCart/<%= rs.getInt("idFood") %>" class="btn btn-primary btn-sm">Add Cart</a>
                        </div>
                    </div>
                </div>

                <%}
                    
                %>

                <Row>
                    <h2>Comments: </h2>
                    <hr>
                    <%                        
                        int index = 0;
                        while (rs1.next()) {
                            String username = rs1.getString("userCus");
                            double ratingOfCus = fDAO.getRatingOfFood(username, id);
                            double var = rs1.getDouble("rating");
                    %>
                    <script type="text/javascript">
                        $(function () {
                            $("#rateyo-cus-<%= index%>").rateYo({
                                rating: <%= var%>,
                                readOnly: true
                            });
                        });
                    </script>
                    <div>
                        <%= cDAO.getfullName(rs1.getString("userCus"))%>
                    </div> 
                    <div id="rateyo-cus-<%= index%>"></div>              
                    <div>
                        <%= rs1.getDate("dateFeedback")%>
                    </div>
                    <div>
                        <%= rs1.getString("feedback")%>
                    </div>
                    <hr>
                    <%
                                index++;
                            }
                        }

                    %>
                </Row>
            </div>
        </div>
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
    </body>
</html>