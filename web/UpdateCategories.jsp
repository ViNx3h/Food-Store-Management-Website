<%-- 
    Document   : UpdateCategorys
    Created on : 11-Jun-2024, 14:41:49
    Author     : lecon
--%>

<%@page import="Models.Categories"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Update Category</title>
    </head>
    <body>
        <%
            Cookie[] cList = request.getCookies();  
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
                    if (request.getAttribute("data") != null) {
                        Categories rs = (Categories) request.getAttribute("data");
        %>
        <div class="container my-5">
            <h1 class="text-center mb-4">Update Category</h1>
            <form action="UpdateCategories" method="post" enctype="multipart/form-data" class="border p-4 shadow-sm rounded">
                <div class="mb-3">
                    <label for="categoryID" class="form-label">Category ID</label>
                    <input type="number" class="form-control" id="categoryID" name="categoryID" value="<%=rs.getId_category()%>" readonly required>
                </div>
                <div class="mb-3">
                    <label for="categoryname" class="form-label">Category Name</label>
                    <input type="text" class="form-control" id="categoryname" name="categoryname" value="<%=rs.getName_category()%>" required>
                </div>
                <div class="mb-3">
                    <label for="picture" class="form-label">Picture</label>
                    <input type="file" class="form-control" id="picture" name="picture" required>
                    <img src="<%=rs.getImg_category()%>" class="img-thumbnail mt-2" style="max-height: 150px;" alt="Current Image">
                </div>
                <button type="submit" class="btn btn-primary">Update Category</button>
            </form>
            <a href="ViewCategories.jsp"><button class="btn btn-secondary mt-3">Back</button></a>
        </div>
        <% 
                    }
                }
            } else { 
        %>    
        <div class="container my-5 text-center">
            <a href="Login.jsp" class="btn btn-primary">Login Before</a>
        </div>
        <%  
            }
        %> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>