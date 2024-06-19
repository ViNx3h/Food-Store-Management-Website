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
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            boolean flagAdmin = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("admin")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagAdmin = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagAdmin) {
        %>
        <div class="container border border-3 border-success p-2 mb-5 bg-white">
            <h1>Order History</h1>
            <table class="table table-striped">
                <%
                    OrdersDAO odao = new OrdersDAO();
                    List<Orders> list = odao.getAllOrderFoods();
                        BillsDAO bDAO = new BillsDAO();
                        OrdersDAO oDAO = new OrdersDAO();
                        FoodsDAO pDAO = new FoodsDAO();
                        String user = (String) session.getAttribute("user");
                        ResultSet rsBill = bDAO.getBill(user);
                        while (rsBill.next()) {
                %>
                <thead>
                    <tr>
                        <th>Order Date</th>
                        <th>Bill</th>
                        <th>Name Food</th>
                        <th>Customer</th>
                        <th>Quantity</th>
                        <th>Note</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>

                    <tr>       
                        <td><%= rsBill.getDate("orderDate")%></td>
                        <td><%= rsBill.getInt("idOrder")%></td>
                        <%
                            ResultSet rsOrder = oDAO.getOrder(rsBill.getInt("idOrder"));
                            while (rsOrder.next()) {
                                Foods pro = pDAO.getProduct(rsOrder.getInt("idFood"));
                        %>
                        <td><%= pro.getName_food()%></td>
                        <td><%= rsBill.getString("userCus")%></td>
                        <td><%= rsBill.getInt("total_quantity")%></td>
                        <td><%= rsBill.getString("note")%></td>
                        <td><%= rsBill.getString("address")%></td>
                        <td><%= rsBill.getString("phone")%></td>
                        <td><%= oDAO.getTotalPrice(rsBill.getInt("idOrder"))%></td>
                        <%
                            }
                        %>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <a href="/FoodStoreManagement/AdminController/ListCustomer">Back</a>
        </div>
        <%} else {%>     
        <a href="Login.jsp"><h1>Login Before</h1></a>
        <%}
            }%> 
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
