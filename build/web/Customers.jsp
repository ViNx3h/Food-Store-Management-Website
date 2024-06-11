<%-- 
    Document   : Customers
    Created on : Jun 10, 2024, 12:18:40 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="Models.Customers"%>
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
            <div class="container">
                <h2>Manage Customers</h2>
                <div class="container">
                    <a class="btn btn-light" href="DashBoardAdmin.jsp"><em>Back</em></a>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Password</th>
                            <th>Full Name</th>
                            <th>Birthday</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Address</th>
                            <th>Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <%
                    CustomersDAO dao = new CustomersDAO();
                    List<Customers> list = dao.getAllCustomers();
                    request.setAttribute("list", list);
                    %>
                    <c:forEach var="c" items="${requestScope.list}">
                        <tbody>
                        <td>${c.getUserCus()}</td>
                        <td>${c.getPassword()}</td>
                        <td>${c.getFullName()}</td>
                        <td>${c.getBirthday()}</td>
                        <td>${c.getEmail()}</td>
                        <td>${c.getPhone()}</td>
                        <td>
                            <c:choose>
                                <c:when test="${c.isGender()}">
                                    Male
                                </c:when>
                                <c:otherwise>
                                    Female
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${c.getAddress()}</td>
                        <td><img src="${c.getImg()}" alt="${c.getUserCus()}"  class="img-thumbnail img-fluid" style="max-height: 80px; max-width: 80px;""/></td>      
                        <td>
                            <a  href="DeleteCus?userCus=${c.getUserCus()}"
                                onclick="return confirmDeletion();" >Delete</a>
                        </td>
                    </c:forEach>
                    </tbody>
                </table>
                <script type="text/javascript">
                    function confirmDeletion() {
                        return confirm('Are you sure you want to delete this Customer?');
                    }
                </script>
            </c:if>      
            <c:if test="${empty username}">
                <a href="Login.jsp"><h1>Login Before</h1></a>
            </c:if>
            <!-- Bootstrap Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
