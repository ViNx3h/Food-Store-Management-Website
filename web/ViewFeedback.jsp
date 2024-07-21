<%@page import="DAOs.FoodsDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.FeedbacksDAO"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.css" type="text/css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.js"></script>
        <title>View Feedback</title>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .container {
                margin-top: 50px;
            }
            .header {
                margin-bottom: 30px;
            }
            .btn-back {
                background-color: #007bff;
                color: white;
            }
            .btn-back:hover {
                background-color: #0056b3;
                color: white;
            }
            .table th, .table td {
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <%
            CustomersDAO cDAO = new CustomersDAO();
            String user = (String) session.getAttribute("user");
        %>
        <div class="container">
            <div class="header text-center mb-4">
                <h2>Feedback of <%= cDAO.getfullName(user) %></h2>
            </div>
            <div class="mb-3 d-flex justify-content-between">
                <a class="btn btn-back" href="/FoodStoreManagement/Customers.jsp"><i class="fas fa-arrow-left"></i> Back</a>
            </div>
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Name of Food</th>
                        <th>Feedback Date</th>
                        <th>Content</th>
                        <th>Rating</th>                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        FeedbacksDAO fDAO = new FeedbacksDAO();
                        FoodsDAO pDAO = new FoodsDAO();
                        ResultSet rs = fDAO.getAll(user);
                        int count = 0;
                        while (rs.next()) {
                            double var = rs.getDouble("rating");
                    %>
                <script type="text/javascript">
                    $(function () {
                        $("#rateyo-cus-<%= count %>").rateYo({
                            rating: <%= var %>,
                            readOnly: true
                        });
                    });
                </script>
                <tr>
                    <td><%= pDAO.getNameFoodById(rs.getInt("idFood")) %></td>
                    <td><%= rs.getDate("dateFeedback") %></td>
                    <td><%= rs.getString("feedback") %></td>
                    <td>
                        <div id="rateyo-cus-<%= count %>"></div>
                    </td>
                </tr>
                <%
                    count++;
                    }
                %>
                </tbody>
            </table>
        </div>
    </body>
</html>
