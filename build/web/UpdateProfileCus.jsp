<%-- 
    Document   : UpdateProfileCus
    Created on : 19-Jun-2024, 20:06:08
    Author     : lecon
--%>

<%@page import="Models.Employees"%>
<%@page import="DAOs.CustomersDAO"%>
<%@page import="Models.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Profile</title>
         
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
         
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        
        <link rel="stylesheet" href="css/profileCus.css">

    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies();  
            boolean flagCustomer = false;
            if (cList != null) {
                String value = "";
                for (int i = 0; i < cList.length; i++) { 
                    if (cList[i].getName().equals("customer")) { 
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break;  
                    }
                }
                if (flagCustomer) {
                    CustomersDAO dao = new CustomersDAO();
                    Customers profile = dao.getProfileCus(value);
                    request.setAttribute("profile", profile);

        %>
    </head>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header text-center">
                        <h2>Update Profile</h2>
                    </div>
                    <div class="card-body">
                        <form action="UpdateProfile" method="post" enctype="multipart/form-data">
                            <div class="mb-3 row">
                                <label for="username" class="col-sm-3 col-form-label">Username</label>
                                <div class="col-sm-9">
                                    <input type="text" readonly class="form-control-plaintext" id="username" name="username" value="${profile.getUserCus()}">
                                </div>
                            </div>
                            <!-- Thêm nút Change Password -->
                            <div class="mb-3 row">
                                <label for="password" class="col-sm-3 col-form-label">Password</label>
                                <div class="col-sm-6">
                                    <input type="password" readonly class="form-control-plaintext" id="password" name="password" value="${profile.getPassword()}">
                                </div>

                            </div>
                            <div class="mb-3 row">
                                <label for="fullName" class="col-sm-3 col-form-label">Full Name</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${profile.getFullName()}">
                                    <div id="fullNameError" class="error-message text-danger"></div>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="birthday" class="col-sm-3 col-form-label">Birthday</label>
                                <div class="col-sm-9">
                                    <input type="date" class="form-control" id="birthday" name="birthday" value="${profile.getBirthday()}">
                                    <div id="birthdayError" class="error-message text-danger"></div>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="email" class="col-sm-3 col-form-label">Email</label>
                                <div class="col-sm-9">
                                    <input type="email" class="form-control" id="email" name="email" value="${profile.getEmail()}">
                                    <div id="emailError" class="error-message text-danger"></div>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="phone" class="col-sm-3 col-form-label">Phone</label>
                                <div class="col-sm-9">
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${profile.getPhone()}">
                                    <div id="phoneError" class="error-message text-danger"></div>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="gender" class="col-sm-3 col-form-label">Gender</label>
                                <div class="col-sm-9">
                                    <select class="form-control" id="gender" name="gender">
                                        <option value="male" ${profile.isGender() ? 'selected' : ''}>Male</option>
                                        <option value="female" ${!profile.isGender() ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="address" class="col-sm-3 col-form-label">Address</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="address" name="address" value="${profile.getAddress()}">
                                    <div id="addressError" class="error-message text-danger"></div>
                                </div>
                            </div>
                            <!-- Profile Picture -->
                            <div class="mb-3 row">
                                <label for="img" class="col-sm-3 col-form-label">Picture</label>
                                <div class="col-sm-9">
                                    <input type="file" class="form-control" name="img">
                                </div>
                            </div>
                    </div>
                </div>
                <div class="text-end">
                    <a class="btn btn-secondary" href="ProfileCus.jsp">Back</a>
                    <input type="submit" class="btn btn-primary" value="Save">
                </div>
                </form>
            </div>
        </div>
    </div>



    <%                }
        }

    %>  
    <script src="javascript/UpdateProfile.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>


</html>