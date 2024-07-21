<%-- 
    Document   : ViewOrderHistory
    Created on : Jun 17, 2024, 11:30:29 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<%@page import="java.util.List"%>
<%@page import="Models.Orders"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .container {
                margin-top: 50px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
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
            .table thead {
                background-color: #007bff;
                color: white;
            }
            .table tfoot {
                background-color: #f8f9fa;
            }
            .form-label {
                margin-bottom: 0.5rem;
            }
        </style>
    </head>
    <body>
        <%
            Cookie[] cList = request.getCookies(); // Lay tat ca cookie cua website nay tren may nguoi dung
            boolean flagAdmin = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) { // Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("admin")) { // Nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagAdmin = true;
                        break; // Thoat khoi vong lap
                    }
                }
                if (flagAdmin) {
        %>
        <%
            CustomersDAO cDAO = new CustomersDAO();
            String user = (String) session.getAttribute("user");
        %>
        <div class="container p-4 mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Order History</h1>
                <a class="btn btn-outline-secondary" href="/FoodStoreManagement/Customers.jsp"><i class="fas fa-arrow-left"></i> Back</a>
            </div>
            <h2 class="text-center pb-4">Bill of <%= cDAO.getfullName(user) %></h2>
            <%
                BillsDAO bDAO = new BillsDAO();
                OrdersDAO oDAO = new OrdersDAO();
                FoodsDAO pDAO = new FoodsDAO();
                ResultSet rsBill = bDAO.getBill(user);
                while (rsBill.next()) {
            %>
            <div class="mb-4 p-4 border rounded">
                <div class="d-flex justify-content-between">
                    <p><strong>Bill: <%= rsBill.getInt("idOrder") %></strong></p>
                    <p class="mb-0"><em><%= rsBill.getDate("orderDate") %></em></p>
                </div>
                <hr>
                <%
                    ResultSet rsOrder = oDAO.getOrder(rsBill.getInt("idOrder"));
                    while (rsOrder.next()) {
                        Foods pro = pDAO.getProduct(rsOrder.getInt("idFood"));
                %>
                <div class="row mb-3">
                    <div class="col-lg-6">
                        <h5><%= pDAO.getNameFoodById(rsOrder.getInt("idFood")) %> x<%= rsOrder.getInt("quantity") %></h5>
                        <p><%= oDAO.getPrice(rsOrder.getInt("idFood"), rsBill.getInt("idOrder")) %> VND</p>
                    </div>
                    <div class="col-lg-6 text-end">
                        <p><strong><%= oDAO.getAmount(rsOrder.getInt("idFood"), rsBill.getInt("idOrder")) %> VND</strong></p>
                        <p><strong>Status: <%= rsBill.getString("Confirm") %></strong></p>
                    </div>
                </div>
                <hr>
                <%
                    }
                %>
                <div class="mb-3">
                    <p class="form-label"><strong>Note:</strong> <%= bDAO.getNote(rsBill.getInt("idOrder")) %></p>
                    <p class="form-label"><strong>Address:</strong> <%= bDAO.getAddress(rsBill.getInt("idOrder")) %></p>
                    <p class="form-label"><strong>Phone:</strong> <%= bDAO.getPhone(rsBill.getInt("idOrder")) %></p>
                </div>
                <p class="text-end" style="color: #dc3545; font-size: x-large"><strong>Total: <%= oDAO.getTotalPrice(rsBill.getInt("idOrder")) %> VND</strong></p>
            </div>
            <%
                }
            %>
        </div>
        <% } else { %>
        <div class="container text-center">
            <a href="Login.jsp"><h1>Login Before</h1></a>
        </div>
        <% } %>
        <% } %>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>

