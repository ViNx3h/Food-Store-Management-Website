<%-- 
    Document   : Status
    Created on : Jun 15, 2024, 7:29:32 PM
    Author     : ADMIN
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.OrdersDAO"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="DAOs.FeedbacksDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Status</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/viewStatus.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    </head>s
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies();
            boolean flagCustomer = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) {
                    if (cList[i].getName().equals("admin")) {
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break;
                    }
                }
                if (flagCustomer) {
                    OrdersDAO oDao = new OrdersDAO();
                    int totalRevenue = oDao.getRevenueOfMonth();
                    int totalOrders = oDao.getTotalOrders();
                    CustomersDAO cDao = new CustomersDAO();
                    int totalCus = cDao.totalCustomer();
                    FeedbacksDAO fDao = new FeedbacksDAO();
                    int totalFeedback = fDao.totalFeedback();
        %>


        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="DashBoardAdmin.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AddFood.jsp">
                                    <i class="fas fa-plus-circle"></i> Add New Food
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewEditingDetail.jsp">
                                    <i class="fas fa-edit"></i> View Editing Detail
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewCategories.jsp">
                                    <i class="fas fa-th-list"></i> View Category
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Employees.jsp">
                                    <i class="fas fa-users"></i> View Employee
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Customers.jsp">
                                    <i class="fas fa-user"></i> View Customer
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ProfileAdmin.jsp">
                                    <i class="fas fa-user-circle"></i> View Profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewStatus.jsp">
                                    <i class="fas fa-chart-line"></i> View Status
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewSchedulebyAdmin.jsp">
                                    <i class="fas fa-calendar-alt"></i> Working Schedule
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
                    <div class="container mt-4">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="card text-white bg-primary mb-3">
                                    <div class="card-header">Revenue</div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%=totalRevenue%> VND</h5> 
                                        <p class="text-white text-white card-text">Revenue this month</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-success mb-3">
                                    <div class="card-header">Order</div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%=totalOrders%></h5>
                                        <p class="text-white card-text">Total number of products ordered</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-warning mb-3">
                                    <div class="card-header">Customers number</div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%=totalCus%></h5>
                                        <p class="text-white card-text">Total number of customers</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-danger mb-3">
                                    <div class="card-header">Feedback</div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%=totalFeedback%></h5>
                                        <p class="text-white card-text">Total number of feedback</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <div class="container mt-4">
            <div class="row">
                <div class="col-2">
                </div>
                <div class="col-5">
                    <canvas id="revenueChart"></canvas>
                </div>
                <div class="col-5">
                    <canvas id="orderChart"></canvas>
                </div>
            </div>
        </div>
        <%
               int[] a1 = oDao.getTotal12Month();
               double[] a2 = fDao.getAverageRatingFor12Months();
        %>
        <script>

            var revenueData = <%= Arrays.toString(a1) %>;
            var feedbackData = <%= Arrays.toString(a2) %>; // Đảm bảo định dạng dữ liệu đúng
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Month 1', 'Month 2', 'Month 3', 'Month 4', 'Month 5', 'Month 6', 'Month 7', 'Month 8', 'Month 9', 'Month 10', 'Month 11', 'Month 12'],
                    datasets: [{
                            label: 'Revenue',
                            data: revenueData,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            var ctx2 = document.getElementById('orderChart').getContext('2d');
            var orderChart = new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: ['Month 1', 'Month 2', 'Month 3', 'Month 4', 'Month 5', 'Month 6', 'Month 7', 'Month 8', 'Month 9', 'Month 10', 'Month 11', 'Month 12'],
                    datasets: [{
                            label: 'Feedback',
                            data: feedbackData,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>


        <%}
        } else {%>     
        <a href="Login.jsp"><h1>Login Before</h1></a>
        <%}%> 
        <!-- Bootstrap Bundle with Popper -->

    </body>
</html>