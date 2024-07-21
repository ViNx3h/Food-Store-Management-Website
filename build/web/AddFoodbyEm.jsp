<%-- 
    Document   : AddFoodbyEm
    Created on : Jun 7, 2024, 8:59:10 PM
    Author     : ADMIN
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DAOs.CategoriesDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Food</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- add food CSS -->
        <link rel="stylesheet" href="css/addfoodbyEm.css">
        <style>


            .container {
                margin-top: 50px;
            }

            .form-control, .form-select {
                margin-bottom: 15px;
            }


            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .sidebar {
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                background-color: #343a40;
                padding-top: 20px;
            }
            .sidebar .nav-link {
                font-size: 1.1em;
                margin-bottom: 1em;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .sidebar .nav-link.active {
                background-color: #ffc107;
                color: #fff;
            }
            .sidebar .nav-link:hover {
                background-color: #e0a800;
                color: #fff;
            }
            .content {
                margin-left: 250px;
                padding: 20px;
            }
            .card-body {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .card {
                border: 1px solid #ccc;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: box-shadow 0.3s ease, transform 0.3s ease;
            }
            .card:hover {
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                transform: translateY(-5px);
            }
            .card-title {
                font-size: 1.25rem;
                font-weight: bold;
            }
            .card-text {
                color: #555;
            }
            .card img {
                border-radius: 8px 8px 0 0;
            }
            .card-buttons {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .btn-primary {
                background-color: #ffc107;
                border: none;
            }
            .btn-primary:hover {
                background-color: #e0a800;
            }
          
            .list-group-item {
                font-size: 1.1em;
            }
            .list-group-item span {
                font-weight: bold;
            }
            .btn-success, .btn-warning, .btn-secondary {
                margin-top: 1em;
            }
        </style>
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
        %>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="DashBoardEmployee.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AddFoodbyEm.jsp">
                                    <i class="fas fa-plus-circle"></i> Add New Food
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="ProfileEm.jsp">
                                    <i class="fas fa-user-circle"></i> View Profile
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="ViewSchedulebyEm.jsp">
                                    <i class="fas fa-calendar-alt"></i> Working Schedule
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ManageStatus.jsp">
                                    <i class="fas fa-calendar-alt"></i> Status Order
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Logout">
                                    <i class="fas fa-sign-out-alt"></i> Log Out
                                </a>
                            </li>

                        </ul>
                    </div>
                </nav>
                <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4">
                    <div class="container mt-5">
                        <div class="row justify-content-center">
                            <div class="col-md-12">
                                <div class="card mt-3">
                                    <h1 class="card-header text-center">Add new Food</h1>
                                    <div class="card-body">
                                        <form action="AddFoodbyEm" method="post" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-4">
                                                        <label for="foodId" class="form-label">ID</label>
                                                        <input type="number" min="1" class="form-control" id="foodId" name="idFood" required>
                                                    </div>
                                                    <c:if test="${not empty AddError}">
                                                        <p style="color:red;">${AddError}</p>
                                                    </c:if>
                                                    <div class="mb-4">
                                                        <label for="foodName" class="form-label">Food Name</label>
                                                        <input type="text" class="form-control" id="foodName" name="name_Food" required>
                                                    </div>
                                                    <div class="mb-4">
                                                        <label for="price" class="form-label">Price</label>
                                                        <input type="number" min="1000" class="form-control" id="price" name="price" required>
                                                    </div>
                                                    <div class="mb-4">
                                                        <label for="quantity" class="form-label">Quantity</label>
                                                        <input type="number" class="form-control" id="quantity" name="quantity" required>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="mb-4">
                                                        <label for="picture" class="form-label">Picture</label>
                                                        <input type="file" class="form-control" id="picture" name="pic" required>
                                                    </div>
                                                    <div class="mb-4">
                                                        <label for="description" class="form-label">Description</label>
                                                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                                                    </div>
                                                    <div class="mb-4">
                                                        <label for="status" class="form-label">Status</label>
                                                        <select class="form-select form-control" id="status" name="status" required>
                                                            <option value="available">Available</option>
                                                            <option value="unavailable">Unavailable</option>
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
                                                            <option value="<%= rs.getString("id_category") %>"><%= rs.getString("name_category") %></option>
                                                            <%
                                                                    }
                                                                    rs.close();
                                                                }
                                                                cDAO.closeConnection();
                                                            %>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-outline-secondary">Add Food</button>
                                                <a class="btn btn-outline-secondary" href="DashBoardEmployee.jsp">Back</a>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <%
                }
            }
        %>
        <!-- Bootstrap JavaScript và các phụ thuộc -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>