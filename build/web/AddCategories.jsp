<%-- 
    Document   : AddCategorys
    Created on : 10-Jun-2024, 22:42:23
    Author     : lecon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body>
        <h1>Add New Category</h1>
        <form action="AddCategories" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="category" class="form-label">Enter Name</label>
                <input type="text" class="form-control" id="category" name="category" required>
            </div>
            <div class="mb-3">
                <label for="img" class="form-label">Image</label>
                <input type="file" class="form-control" id="img" name="img" required>
            </div>
            <button type="submit" class="btn btn-primary">Add New</button>
        </form>
    </body>
</html>
