<%-- 
    Document   : SignUp
    Created on : Jun 5, 2024, 1:50:53 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>RegisterCustomer</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
              integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>
        <div>
            <div class="container" style="margin-top: 10px;">
                <div class="row" style="border: 1px darkgrey solid; border-radius: 10px;width: 50%; margin: 0 auto; padding: 20px;">
                    <div class="col-sm-12">

                        <h2>Register Account</h2>
                        
                        <form action="CustomersController" method="post">
                            <div class="form-group">
                                <label>UserName</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="Enter userName" required>
                            </div>
                            <div class="form-group">
                                <label>Password:</label>
                                <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required>
                            </div>
                            <div class="form-group">
                                <label>FullName</label>
                                <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Enter fullname" required>                         
                            </div>
                            <div class="form-group">
                                <label>Birthday</label>
                                <input type="date" id="birthday" name="birthday" class="form-control" required>                         
                            </div>
                            <div class="form-group">
                                <label for="email-for-pass">Enter your email address</label> 
                                <input class="form-control" type="text" name="email" id="email-for-pass" required="">
                                <small class="form-text text-muted">Enter the registered email address. Then we'll email an OTP to this address.</small>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" id="phone" name="phone" class="form-control" placeholder="Enter your phone number" required>
                            </div>
                            <div class="form-group mb-0">
                                <label>Gender</label>
                                <div>
                                    <label>
                                        <input type="radio" name="gender" value="true" id="male" required>
                                        Male
                                    </label>
                                    <label>
                                        <input type="radio" name="gender" value="false" id="female" required>
                                        Female
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" id="address" name="address" class="form-control" placeholder="Enter your address" required>
                            </div>                    
                            <div class="">
                                <button type="submit" class="btn btn-primary ml-3 mr-4 mt-3" name="btnSubmit">Submit</button>
                                <button type="reset" class="btn btn-primary mr-4 mt-3">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
