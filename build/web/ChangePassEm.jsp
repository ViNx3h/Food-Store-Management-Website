<%-- 
    Document   : ChangePassEm
    Created on : 14-Jun-2024, 01:32:55
    Author     : lecon
--%>

<%@page import="Models.Employees"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>





        <div class="container">
            
            
            <form action="ChangePassEm" method="post" >
                <%
                    if (request.getAttribute("data") != null) {
                        Employees rs = (Employees) request.getAttribute("data");
                %>

                <h3>Enter Name</h3>
                <input type="text" name="username" minlength="6" readonly="" required value="<%= rs.getUserEmployee()%>">

                <h3>Password Old</h3>
                <input type="password" name="oldpassword" minlength="6" placeholder="Enter oldpassword " required value="">

                <h3>Password New</h3>
                <input type="password" name="newpassword" minlength="6" placeholder="Enter newpassword" required value="">

                <h3>Confirm Password</h3>
                <input type="password" name="confirmpassword" minlength="6" placeholder="Enter confirmpassword" required value="" >
                
                
                <input type="submit"  value="Save">
                
            </form>
        </div>

        <%}%>
        <a class="btn btn-light" href="Employees.jsp"><em>Back</em></a>

    </body>
</html>
