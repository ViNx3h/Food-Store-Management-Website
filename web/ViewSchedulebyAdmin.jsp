<%-- 
    Document   : ViewSchedule
    Created on : 30-Jun-2024, 17:45:18
    Author     : lecon
--%>

<%@page import="DAOs.EmployeesDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Comparator"%>

<%@page import="java.util.Collections"%>
<%@page import="Models.WorkingSchedule"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.WorkingSchedulesDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/ViewSchedule.css">
        <title>Working Schedule</title>
        <style>
            .button-container {
                display: flex;
                gap: 5px; /* Adjust gap to control spacing */

            }

            .button-same-size {
                flex: 1;
                margin: 0 2px;
                max-width: 80px; /* Set a fixed width */
                text-align: center; /* Ensure the text is centered */
                white-space: nowrap; /* Prevent text from wrapping */
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
                    if (cList[i].getName().equals("admin")) {
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break;
                    }
                }
                if (flagCustomer) {
                    WorkingSchedulesDAO dao = new WorkingSchedulesDAO();
                    List<WorkingSchedule> list = dao.getAllWorkingSchedule();

                    request.setAttribute("list", list);
                    list.sort(Comparator.comparing(WorkingSchedule::getDay));
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


                <!-- The Modal -->
                <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4">
                    <div class="modal fade" id="modalAddSchedule" tabindex="-1" aria-labelledby="modalAddSchedule" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">

                                <form action="AddSchedule" method="post">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalAddSchedule">Add Schedule</h5>


                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="form-group">
                                        <label for="id">ID</label>
                                        <input type="text" class="form-control" id="id" name="id"  required>
                                    </div>
                                    <div class="mb-4">
                                        <label for="userEmployee" class="form-label">User Name</label>
                                        <select class="form-select form-control" id="userEmployee" name="username" aria-label="Select Employee" required>
                                            <%
                                                EmployeesDAO eDAO = new EmployeesDAO();
                                                ResultSet rs = eDAO.getUserEmployees();
                                                if (rs != null) {
                                                    while (rs.next()) {
                                            %>
                                            <option value="<%= rs.getString("userEmployee")%>"><%= rs.getString("userEmployee")%></option>
                                            <%
                                                    }
                                                    rs.close();
                                                }
                                                eDAO.closeConnection();
                                            %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="day">Day</label>
                                        <input type="date" class="form-control" id="day" name="day" required >
                                    </div>
                                    <div class="form-group">
                                        <label for="time">Time</label>
                                        <select class="form-control" id="time" name="time"  required >
                                            <option value="Morning  : 07h - 12h">07h - 12h</option>
                                            <option value="Afternoon: 12h - 17h">12h - 17h</option>
                                            <option value="Evening  : 17h - 22h">17h - 22h</option>
                                        </select>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>











                    <div class="container mt-5">
                        <h1 class="text-center">Working Schedule</h1>

                        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#modalAddSchedule">
                            Add Schedule
                        </button>
                        <table class="table table-striped table-hover">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th scope="col" class="col-add-detail">ID</th>
                                    <th scope="col" class="col-add-detail">user name</th>
                                    <th scope="col" class="col-delete-detail">Full Name</th>
                                    <th scope="col" class="col-delete-detail">Day</th>
                                    <th scope="col" class="col-update-detail">time</th>
                                    <th>

                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${requestScope.list}">
                                    <tr>
                                        <td class="text-center">${c.getId()}</td>
                                        <td class="text-center">${c.getUserEmployee()}</td>
                                        <td class="text-center">${c.getFullName()}</td>
                                        <td class="text-center">${c.getDay()}</td>
                                        <td class="text-center">${c.getTime()}</td>
                                        <td>
                                            <div class="button-container">
                                                <a href="UpdateSchedule?id=${c.getId()}" class="btn btn-outline-warning btn-sm button-same-size">Update</a> |
                                                <a href="DeleteSchedule?id=${c.getId()}" class="btn btn-outline-danger btn-sm button-same-size" onclick="return confirm('Are you sure you want to delete this Schedule?');">Delete</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </div>
        <%
                }
            }
        %> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </body>
</html>