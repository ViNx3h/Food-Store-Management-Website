<%-- 
    Document   : FoodDetail
    Created on : Jun 28, 2024, 5:52:34 PM
    Author     : VINH
--%>

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
        <link rel="stylesheet" href="css/homepage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.css" type="text/css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.js"></script>
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
                    rating: <%= rate %>,
                    readOnly: true
                });
            });
        </script>


    </head>
    <body>

        <%            FoodsDAO pDAO = new FoodsDAO();

            CategoriesDAO cDAO = new CategoriesDAO();
            ResultSet rs = pDAO.getAll(id);
            while (rs.next()) {

        %>
        <div class="Container fluid">
            <Row>
                <div class="col-12 col-sm-6">
                    <div class="card p-1">
                        <a href="/FoodStoreManagement/CustomersController/FoodDetail_Process/<%= pDAO.getFoodById(rs.getInt("idFood"))%>" > <img class="card-img-top " src="<%= rs.getString("pic")%>" alt="Card image"> </a>
                        <div class="card-body text-center">
                            <h4 class="card-title"><%= rs.getString("name_food")%></h4>
                            <div class="card-text">
                                <small class="mt-3"><em><%= rs.getString("description")%></em></small><br/>
                                <small>Quantity: <%= rs.getInt("quantity")%></small>
                                <h5><strong><%= rs.getInt("price")%>VND</strong></h5>

                                <div id="rateyo-overall"></div>
                                <small>Overall rating: <%= rate %> stars</small>
                            </div>
                            <a href="CustomersController/AddCart/<%= rs.getInt("idFood")%>" class="btn btn-primary btn-sm">Add Cart</a>
                        </div>
                    </div>
                </div>
                <form action="" method="post">
                    <table>
                        <tr>
                            <td>Rating</td>
                            <td>
                                <div id="rating">

                                </div>
                                <input type="hidden" name="hdrating" id="hdrating">
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">Content</td>
                            <td><textarea id="content" name="content" rows="5" cols="20"></textarea></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <button type="submit" class="btn btn-primary" name="btnFeedBack">Send</button>
                                <input type="hidden" name="productID" value="<%= pDAO.getFoodById(rs.getInt("idFood"))%>">
                            </td>
                        </tr>
                    </table>
                </form>
                <%
                    }

                %>

            </Row>
            <Row>
                <h2>Related Category of food</h2>
                <%    while (rs.next()) {
                        int value = pDAO.getCategoryById(id);
                        rs = pDAO.getAllByCategory(value);
                        ResultSet rs2 = pDAO.getTop4(rs.getInt("id_category"));


                %>
                <a href="/FoodStoreManagement/Foods.jsp?id=<%= rs.getInt("id_category")%>"><h1 class="text-center"><%= rs.getString("name_category")%></h1></a>
                <div class="row" id="card-wool">
                    <% while (rs2.next()) {%>
                    <div class="col-sm-6 col-md-3">
                        <div class="card p-1">
                            <a href="/FoodStoreManagement/CustomersController/FoodDetail_Process/<%= pDAO.getFoodById(rs2.getInt("idFood"))%>" > <img class="card-img-top" src="<%= rs2.getString("pic")%>" alt="Card image"> </a>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= rs2.getString("name_food")%></h4>
                                <div class="card-text">
                                    <small class="mt-3"><em><%= rs2.getString("description")%></em></small><br/>
                                    <small>Quantity: <%= rs2.getInt("quantity")%></small>
                                    <h5><strong><%= rs2.getInt("price")%>VND</strong></h5>
                                </div>
                                <a href="CustomersController/AddCart/<%= rs2.getInt("idFood")%>" class="btn btn-primary btn-sm">Add Cart</a>
                            </div>
                        </div>
                    </div>
                    <% }
                        }%>
                </div>

            </Row>
        </div>
    </body>

</html>
