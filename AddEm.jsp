<%-- 
    Document   : AddCus
    Created on : Jun 10, 2024, 12:47:33 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create New Employee Account</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <div class="container mb-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <h1 class="text-center mb-4">Create New Employee Account</h1>
                    <form action="AddEm" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="userEmployee" class="form-label">Enter Username:</label>
                            <input type="text" class="form-control" id="userEmployee" name="userEmployee" placeholder="Example: nguyenvana123" required>
                            <div id="usernameError" class="text-danger"></div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Enter Password:</label>
                            <input type="password" minlength="6" class="form-control" id="password" name="password" placeholder="Example: Nguyenvana123" required>
                        </div>

                        <div class="mb-3">
                            <label for="confirmpassword" class="form-label">Confirm Password:</label>
                            <input type="password" minlength="6" class="form-control" id="confirmpassword" name="confirmpassword" required>
                        </div>

                        <span class="text-danger">
                            <%= request.getAttribute("errorPassword") != null ? request.getAttribute("errorPassword") : "" %>
                        </span>

                        <div class="mb-3">
                            <label for="fullName" class="form-label">Enter Full Name:</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Example: Nguyen Van A" required>
                            <div id="fullNameError" class="text-danger"></div>
                        </div>

                        <div class="mb-3">
                            <label for="birthday" class="form-label">Choose Birthday</label>
                            <input type="date" class="form-control" id="birthday" name="birthday" required>
                            <div id="birthdayError" class="text-danger"></div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Enter Email:</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Example: nguyenvana123@gmail.com" required>
                            <div id="emailError" class="text-danger"></div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Enter Phone Number:</label>
                            <input type="text" minlength="10" maxlength="11" class="form-control" id="phone" name="phone" placeholder="Example: 0381234567" required>
                            <div id="phoneError" class="text-danger"></div>
                        </div>

                        <div class="mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Enter Address:</label>
                            <input type="text" class="form-control" id="address" name="address" placeholder="Example: Vinh Long" required>
                            <div id="addressError" class="text-danger"></div>
                        </div>

                        <div class="mb-3">
                            <label for="img" class="form-label">Picture</label>
                            <input type="file" class="form-control" id="img" name="img" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </form>
                    <a href="ViewEmployees.jsp" class="btn btn-secondary mt-3"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
            </div>
        </div>
                         <script src="javascript/UpdateProfile.js"></script>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
    </body>
</html>