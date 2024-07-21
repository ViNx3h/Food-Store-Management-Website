<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.BillsDAO"%>
<%@page import="DAOs.OrdersDAO"%>
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
        <title>Confirm Order</title>
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
            .btn-outline-secondary {
                border-color: #ffc107;
                color: #ffc107;
            }
            .btn-outline-secondary:hover {
                background-color: #ffc107;
                color: #fff;
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
            String user = (String) session.getAttribute("user");
            CustomersDAO cDAO = new CustomersDAO();
            OrdersDAO oDAO = new OrdersDAO();
            BillsDAO bDAO = new BillsDAO();

        %>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/FoodStoreManagement/DashBoardEmployee.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement/AddFoodbyEm.jsp">
                                    <i class="fas fa-plus-circle"></i> Add New Food
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement/ProfileEm.jsp">
                                    <i class="fas fa-user-circle"></i> View Profile
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement/ViewSchedulebyEm.jsp">
                                    <i class="fas fa-calendar-alt"></i> Working Schedule
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement/ManageStatus.jsp">
                                    <i class="fas fa-calendar-alt"></i> Status Order
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/FoodStoreManagement/Logout">
                                    <i class="fas fa-sign-out-alt"></i> Log Out
                                </a>
                            </li>

                        </ul>
                    </div>
                </nav>
                <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4">
                    <div class="text-center">
                        <h3> Manage Order </h3>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Order</th>
                                    <th>Status</th>
                                    <th>Confirm Order</th>                      
                                </tr>
                            </thead>
                            <%                 
                                ResultSet rs = bDAO.getBill(user);
                                while (rs.next()) {
                                    if (rs.getString("Confirm").equalsIgnoreCase("No") || rs.getString("Confirm").equalsIgnoreCase("onGoing")) {
                            %>
                            <tbody>
                                <tr>
                                    <th><%= rs.getString("idOrder")%></th>
                                    <th><%= rs.getString("Confirm")%></th>
                                    <th>
                                        <%
                                            if(rs.getString("Confirm").equalsIgnoreCase("No")){
                                        %>
                                        <div class="col-12">
                                            <a class="text-decoration-none" href="/FoodStoreManagement/EmployeesController/ManageOrder_Process/OnGoing/<%= rs.getInt("idOrder")%>"><button class="col-2 btn btn btn-outline-info">On Going</button></a>
                                            <a class="text-decoration-none" href="/FoodStoreManagement/EmployeesController/ManageOrder_Process/Confirm/<%= rs.getInt("idOrder")%>"><button class="col-2 btn btn-outline-success">Confirm</button></a>
                                        </div>
                                        <%} else if(rs.getString("Confirm").equalsIgnoreCase("onGoing")){%>

                                        <div class="col-12">
                                            <a class="text-decoration-none" href="/FoodStoreManagement/EmployeesController/ManageOrder_Process/Confirm/<%= rs.getInt("idOrder")%>"><button class="col-4 btn btn-outline-success">Confirm</button></a>
                                        </div>
                                        <%}%>
                                    </th>
                                </tr>
                            </tbody>
                            <%
                                    }
                                }%>
                        </table>
                </main>
            </div>
        </div>
    </body>
</html>