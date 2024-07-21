<%-- 
    Document   : UpdateWorkingSchedule
    Created on : 01-Jul-2024, 08:41:53
    Author     : lecon
--%>
<%@page import="Models.WorkingSchedule"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Cookie[] cList = request.getCookies();
            boolean flagCustomer = false;
            if (cList != null) {
                for (Cookie cookie : cList) {
                    if (cookie.getName().equals("admin")) {
                        flagCustomer = true;
                        break;
                    }
                }
                if (flagCustomer) {
                    if (request.getAttribute("data") != null) {
                        WorkingSchedule rs = (WorkingSchedule) request.getAttribute("data");
        %>




        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="border p-4 mx-auto">
                        <h2 class="text-center mb-4">Update Working Schedule</h2>
                        <form id="UpdateSchedule" method="post">
                            <div class="mb-3">
                                <label for="id" class="form-label">ID</label>
                                <input type="text" class="form-control" id="id" name="id" value="<%=rs.getId()%>" required readonly>
                            </div>
                            <div class="mb-3">
                                <label for="userName" class="form-label">User Name</label>
                                <input type="text" class="form-control" id="userName" name="username" value="<%=rs.getUserEmployee()%>" required readonly>
                            </div>
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="<%=rs.getFullName()%>" required readonly>
                            </div>
                            <div class="mb-3">
                                <label for="day" class="form-label">Day</label>
                                <input type="date" class="form-control" id="day" name="day" value="<%=rs.getDay()%>" required>
                            </div>
                            <div class="mb-3">
                                <label for="time" class="form-label">Time</label>
                                <select class="form-control" id="time" name="time" required>
                                    <option value="Morning: 07h - 12h">07h - 12h</option>
                                    <option value="Afternoon: 12h - 17h">12h - 17h</option>
                                    <option value="Evening: 17h - 22h">17h - 22h</option>
                                </select>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3 text-center">
                                    <a href="ViewSchedulebyAdmin.jsp" class="btn btn-outline-secondary">Back</a>
                                </div>
                                <div class="col-md-6 mb-3 text-center">
                                    <button type="submit" class="btn btn-outline-primary">Update Schedule</button>
                                </div>
                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>








        <%
                    }
                }
            }
        %>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
