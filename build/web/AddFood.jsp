<%-- 
    Document   : AddFood
    Created on : Jun 5, 2024, 5:17:37 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- add food CSS -->
        <link rel="stylesheet" href="addfood.css">
    </head>
    <body>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h1 class="text-center">Add new Food</h1>
                    <form action="AddFood" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="foodId" class="form-label">ID</label>
                            <input type="number" class="form-control" id="foodId" name="idFood" required>
                        </div>
                        <div class="mb-3">
                            <label for="foodName" class="form-label">Food Name</label>
                            <input type="text" class="form-control" id="foodName" name="name_Food" required>
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" min="1000" class="form-control" id="price" name="price" required>
                        </div>
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" required>
                        </div>
                        <div class="mb-3">
                            <label for="picture" class="form-label">Picture</label>
                            <input type="file" class="form-control" id="picture" name="pic" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="available">Available</option>
                                <option value="unavailable">Unavailable</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="categoryId" class="form-label">ID of Category</label>
                            <input type="number" class="form-control" id="categoryId" name="id_category" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Add Food</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JavaScript và các phụ thuộc -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
