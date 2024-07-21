<%-- 
    Document   : Login
    Created on : Jun 4, 2024, 11:22:25 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login - Food Theme</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            body {
                background: url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
                background-size: cover;
                color: #fff;
            }
            .container {
                background: rgba(0, 0, 0, 0.7);
                padding: 30px;
                border-radius: 10px;
                margin-top: 100px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            }
            .form-group label {
                color: #fff;
            }
            .btn-primary {
                background-color: #ff6347;
                border-color: #ff6347;
            }
            .btn-light {
                background-color: #fff;
                color: #ff6347;
            }
            .separator {
                margin: 20px 0;
                border-bottom: 1px solid #fff;
            }
            .text-center a {
                color: #ff6347;
            }
        </style>
    </head>
    <body>

        <div class="container col-md-4">
            <h2 class="text-center mb-4">Login</h2>
            <form action="Login">
                <div class="form-group mb-3">
                    <label for="username" class="col-sm-3 col-form-label" >Username</label>
                    <input type="text" id="username" class="form-control" name="username" placeholder="Enter username" required>
                </div>
                <div class="form-group mb-3">
                    <label for="password" class="col-sm-3 col-form-label">Password</label>
                    <input type="password" id="password" class="form-control" name="password" placeholder="Enter password" required>
                </div>

                <div class="form-group mb-3">
                    <label for="role" class="col-sm-3 col-form-label">Role</label>
                    <select name="role" id="role" class="form-control">
                        <option value="customer">Customer</option>
                        <option value="employee">Employee</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-block w-100 mb-3">Login</button>
                <c:if test="${not empty loginError}">
                    <p style="color:red;">${loginError}</p>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <p style="color:greenyellow;">${successMessage}</p>
                </c:if>
                <!-- Separator -->
                <div class="separator"></div>
                <div class="text-center mb-2">
                    <a class="btn btn-light border w-100 mb-2" href="SignUp.jsp">Create New Account</a>
                    <a class="btn btn-light border w-100 mb-2" href="Forgotpassword.jsp">Forgot Password?</a>
                    <a class="btn btn-light border w-100" href="/FoodStoreManagement">Back</a>
                </div>
            </form>
        </div>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
