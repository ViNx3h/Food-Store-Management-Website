<%-- 
    Document   : UpdateFoodbyEm
    Created on : Jun 9, 2024, 3:07:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.Foods"%>
<%@page import="DAOs.FoodsDAO"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DAOs.CategoriesDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Food</title>
         
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
         
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- add food CSS -->
        <link rel="stylesheet" href="updateFoodbyEm.css">
    </head>
    <body>
        <%
             Cookie[] cList = null;
                    cList = request.getCookies();  
                    boolean flagCustomer = false;
                    if (cList != null) {
                        String value = "";
                        for (int i = 0; i < cList.length; i++) { 
                            if (cList[i].getName().equals("employee")) { 
                                value = cList[i].getValue();
                                flagCustomer = true;
                                break;  
                            }
                        }
                        if (flagCustomer) {
                        
            String idFood_raw = request.getParameter("id");
            try { 
                int idFood = Integer.parseInt(idFood_raw);
                FoodsDAO dao = new FoodsDAO();
                Foods food = dao.findFoodsById(idFood);
                request.setAttribute("food", food);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                // Xử lý khi idFood không phải là số hợp lệ
            }
        %>
        <c:set var="p" value="${requestScope.food}" ></c:set>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-12">
                        <div class="card mt-3">
                            <h1 class="card-header text-center">Update Food</h1>
                            <div class="card-body">
                                <form action="UpdateFoodbyEm" method="post" enctype="multipart/form-data">

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-4">
                                                <label for="foodId" class="form-label">Food ID</label>
                                                <input type="number" class="form-control" id="foodId" name="idFood" value="${p.getIdFood()}" readonly>
                                        </div>
                                        <div class="mb-4">
                                            <label for="foodName" class="form-label">Food Name</label>
                                            <input type="text" class="form-control" id="foodName" name="name_food" value="${p.getName_food()}" required>
                                        </div>
                                        <div class="mb-4">
                                            <label for="price" class="form-label">Price</label>
                                            <input type="number" min="1000" class="form-control" id="price" name="price" value="${p.getPrice()}" required>
                                        </div>
                                        <div class="mb-4">
                                            <label for="quantity" class="form-label">Quantity</label>
                                            <input type="number" class="form-control" id="quantity" name="quantity" value="${p.getQuantity()}" required>
                                        </div>
                                    </div>


                                    <div class="col-md-6">
                                        <div class="mb-4">
                                            <label for="picture" class="form-label">Picture</label>
                                            <input type="file" class="form-control" id="picture" name="pic" required value="${p.getPic()}" src="${p.getPic()}">
                                        </div>
                                        <div class="mb-4">
                                            <label for="description" class="form-label">Description</label>
                                            <textarea class="form-control" id="description" name="description" rows="3" required>${p.getDescription()}</textarea>
                                        </div>
                                        <div class="mb-4">
                                            <label for="status" class="form-label">Status</label>
                                            <select class="form-select" id="status" name="status" required>
                                                <option value="available" ${p.getStatus() ? 'selected' : ''}>Available</option>
                                                <option value="unavailable" ${!p.getStatus() ? 'selected' : ''}>Unavailable</option>
                                            </select>
                                        </div>
                                        <div class="mb-4">
                                            <label for="id_category" class="form-label">Category</label>
                                            <select class="form-select form-control" id="id_category" name="id_category" aria-label="Select Category" required>
                                                <%
                                                    CategoriesDAO cDAO = new CategoriesDAO();
                                                    ResultSet rs = cDAO.getCategories();
                                                    if (rs != null) {
                                                        while (rs.next()) {
                                                %>
                                                <option value="<%= rs.getString("id_category") %>">  <%= rs.getString("name_category") %></option>
                                                <%
                                                        }
                                                        rs.close();
                                                    }
                                                    cDAO.closeConnection();
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Update Food</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div
        <%}}else{%>   
        <a href="Login.jsp"><h1>Login Before</h1></a>
        <%}
        %>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>


    </body>
</html>
