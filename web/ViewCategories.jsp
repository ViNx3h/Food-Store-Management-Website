<%-- 
    Document   : ViewCategory
    Created on : 10-Jun-2024, 20:58:35
    Author     : lecon
--%>

<%@page import="Models.Categories"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.CategoriesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/viewcategory.css">

        <title>View Categories</title>
        <style>
            .button-container {
                display: flex;
                    gap: 5px; /* Adjust gap to control spacing */

            }

            .button-same-size {
                flex: 1;
                margin: 0 2px;
                max-width: 100px; /* Set a fixed width */
                text-align: center; /* Ensure the text is centered */
                white-space: nowrap; /* Prevent text from wrapping */
            }

        </style>
    </head>
    <body>
        <%
        Cookie[] cList = request.getCookies();  
        boolean flagCustomer = false;
        if (cList != null) {
            for (int i = 0; i < cList.length; i++) { 
                if (cList[i].getName().equals("admin")) { 
                    flagCustomer = true;
                    break;  
                }
            }
        }
        if (flagCustomer) {
        %>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="DashBoardAdmin.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AddFood.jsp">
                                    <i class="fas fa-plus-circle"></i> Add New Food
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewEditingDetail.jsp">
                                    <i class="fas fa-edit"></i> View Editing Detail
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewCategories.jsp">
                                    <i class="fas fa-th-list"></i> View Category
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Employees.jsp">
                                    <i class="fas fa-users"></i> View Employee
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Customers.jsp">
                                    <i class="fas fa-user"></i> View Customer
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ProfileAdmin.jsp">
                                    <i class="fas fa-user-circle"></i> View Profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewStatus.jsp">
                                    <i class="fas fa-chart-line"></i> View Status
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewSchedulebyAdmin.jsp">
                                    <i class="fas fa-calendar-alt"></i> Working Schedule
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Logout">
                                    <i class="fas fa-sign-out-alt"></i> Log Out
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <main class="col-md-10 ms-sm-auto col-lg-10 px-md-4">
                    <div class="container mt-5">
                        <h3 class="mb-4">Manage Categories</h3>
                        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#modalCreateCategory">
                            Create Category
                        </button>

                        <!-- The Modal -->
                        <div class="modal fade" id="modalCreateCategory" tabindex="-1" aria-labelledby="modalCreateCategoryLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <form action="AddCategories" method="post" enctype="multipart/form-data">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="modalCreateCategoryLabel">Category Management</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label for="category" class="form-label">Enter Name</label>
                                                <input type="text" class="form-control" id="category" name="category" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="img" class="form-label">Image</label>
                                                <input type="file" class="form-control" id="img" name="img" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Save</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <table class="table table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>Id</th>
                                    <th>Category Name</th>
                                    <th>Image</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                CategoriesDAO dao = new CategoriesDAO();
                                List<Categories> list = dao.getAllCategory();
                                if (list != null) {
                                    for (Categories rs : list) {
                                        int id = rs.getId_category();
                                %>     
                                <tr>
                                    <td><%= rs.getId_category() %></td>
                                    <td><%= rs.getName_category() %></td>
                                    <td><img src="<%= rs.getImg_category() %>" class="img-thumbnail img-fluid" style="max-height: 80px; max-width: 80px;"></td>  
                                    <td>
                                        <div class="button-container">
                                            <a href="UpdateCategories?id=<%= rs.getId_category() %>" class="btn btn-outline-warning btn-sm button-same-size">Update</a> |
                                            <a href="DeleteCategories?id=<%= rs.getId_category() %>" class="btn btn-outline-danger btn-sm button-same-size" onclick="return confirm('Are you sure you want to delete this Category?');">Delete</a>
                                        </div>
                                    </td>
                                </tr>

                                <%
                                    }
                                }
                                %>
                            </tbody>
                        </table>
                        <a href="DashBoardAdmin.jsp" class="btn btn-outline-secondary mt-3">Back</a>
                    </div>
                </main>
            </div>
        </div>

        <% } else { %>     
        <div class="container mt-5">
            <div class="alert alert-warning" role="alert">
                <a href="Login.jsp" class="alert-link">Login Before</a>
            </div>
        </div>
        <% } %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>