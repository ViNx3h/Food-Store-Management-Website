<%-- 
    Document   : UpdateCategorys
    Created on : 11-Jun-2024, 14:41:49
    Author     : lecon
--%>

<%@page import="Models.Categories"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            if (request.getAttribute("data") != null) {
                Categories rs = (Categories) request.getAttribute("data");

        %>



        <form action="UpdateCategories" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="categoryID" class="form-label">Category ID</label>
                <input type="number" class="form-control" id="categoryID" name="categoryID" value="<%=rs.getId_category()%>" readonly="" required>
            </div>


            <div class="mb-3">
                <label for="categoryname" class="form-label">Category Name</label>
                <input type="text" class="form-control" id="categoryname" name="categoryname" value="<%=rs.getName_category()%>" required>
            </div>

            <div class="mb-3">
                <label for="picture" class="form-label">Picture</label>
                <input type="file" class="form-control" id="picture" name="picture" required value="<%=rs.getImg_category()%>" src="<%=rs.getImg_category()%>">
            </div>

            <button type="submit" class="btn btn-primary">Update Food</button>
        </form>

        <% 
            }
        %>
    </body>
</html>
