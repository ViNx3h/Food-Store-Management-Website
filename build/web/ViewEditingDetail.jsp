<%-- 
    Document   : ViewEditingDetail
    Created on : Jun 9, 2024, 3:20:53 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Models.EditingDetail"%>
<%@page import="DAOs.EditingDetailDAO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom CSS -->
        <!-- Custom CSS -->
        <link rel="stylesheet" href="editingDetail.css">
    </head>
    <body>
        <%
    Cookie[] cookies = request.getCookies();
    String username = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
    }
    request.setAttribute("username", username);
        %>
        <c:if test="${not empty username}">
            <%
                EditingDetailDAO dao = new EditingDetailDAO();
                List<EditingDetail> list = dao.getAllEditingDetail();
                request.setAttribute("list", list);
            %>
            <div class="container mt-5">
                <h1 class="text-center">List of Editing Details</h1>
                <table class="table table-striped table-hover">
                    <thead class="table-dark text-center">
                        <tr>
                            <th scope="col">Employee</th>
                            <th scope="col">Food ID</th>
                            <th scope="col" class="col-add-detail">Add Detail</th>
                            <th scope="col" class="col-delete-detail">Delete Detail</th>
                            <th scope="col" class="col-update-detail">Update Detail</th>
                            <th scope="col">Date Editing</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${requestScope.list}">
                            <tr>
                                <td class="text-center">${c.getUserEmployee()}</td>
                                <td class="text-center">${c.getIdFood()}</td>
                                <td>${c.getAdd_food()}</td>
                                <td>${c.getDelete_food()}</td>
                                <td>${c.getUpdate_food()}</td>
                                <td>${c.getDate_editing()}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${empty username}">
            <a href="Login.jsp"><h1>Login Before</h1></a>
        </c:if>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
