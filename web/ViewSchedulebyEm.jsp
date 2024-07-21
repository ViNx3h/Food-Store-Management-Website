<%-- 
    Document   : ViewSchedulebyEm
    Created on : 01-Jul-2024, 08:50:30
    Author     : lecon
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.List"%>
<%@page import="Models.WorkingSchedule"%>
<%@page import="DAOs.WorkingSchedulesDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/ViewSchedule.css">

        <title>Working Schedule</title>
    </head>
    <body>
        <%
            Cookie[] cList = request.getCookies();
            boolean loggedIn = false;
            String username = "";

            if (cList != null) {
                for (Cookie cookie : cList) {
                    if (cookie.getName().equals("employee")) {
                        username = cookie.getValue();
                        loggedIn = true;
                        break;
                    }
                }
            }

            if (loggedIn && username != null && !username.isEmpty()) {
                WorkingSchedulesDAO dao = new WorkingSchedulesDAO();
                List<WorkingSchedule> list = dao.EmWorkingSchedule(username);

                request.setAttribute("list", list);
                list.sort(Comparator.comparing(WorkingSchedule::getDay));
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
                    <h1 class="text-center">Working Schedule</h1>

                    <table class="table table-striped table-hover">
                        <thead class="table-dark text-center">
                            <tr>
                                <th scope="col">Id</th>
                                <th scope="col">User Name</th>
                                <th scope="col">Full Name</th>
                                <th scope="col">Day</th>
                                <th scope="col">Time</th>

                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="schedule" items="${requestScope.list}">
                                <tr class="text-center">
                                    <td> ${schedule.id}</td>
                                    <td>${schedule.userEmployee}</td>
                                    <%
                                    String a = dao.getFullName(username);
                                    String user = dao.getUserEmployee(username);
                                    %>
                                    <td><%= a%></td>
                                    <td>${schedule.day}</td>
                                    <td>${schedule.time}</td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </main>
            </div>
        </div>


        <% } else { %>
        <div class="container mt-5">
            <p class="text-center">You are not logged in or no valid username found.</p>
        </div>
        <% }%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </body>
</html>