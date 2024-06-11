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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <h1>Manage Categories</h1>

        <a href="AddCategories.jsp"> <button>Add New</button></a>
        <div class="profile-container">
            <table border="1px" >

                <tr>
                    <th>Id</th>
                    <th>Category Name</th>
                    <th>Image</th>
                    <th></th>

                </tr>


                <%
                    CategoriesDAO dao = new CategoriesDAO();
                    List<Categories> list = dao.getAllCategory();
                    if (list != null) {
                        for (Categories rs : list) {
                            int id = rs.getId_category();
                %>     

                <tr>
                    <td><%= rs.getId_category()%> </td>
                    <td><%= rs.getName_category()%> </td>

                    <td><img src="<%=rs.getImg_category()%>"  class="img-thumbnail img-fluid" style="max-height: 80px; max-width: 80px;"></td>  

                    <td>

                        <a  href= "UpdateCategories?id=<%= id%>" >  Update </a>
                        <a  href="DeleteCategories?id=<%=id%>"> Delete </a>

                    </td>
                    <!--onclick="return confirmDeletion();"-->
                </tr>

                <script type="text/javascript">
                    function confirmDeletion() {
                        return confirm('Are you sure you want to delete this Category?');
                    }
                </script>

                <%
                }
                }
                %>
            </table>
            <a href="DashBoardAdmin.jsp"><button> Back </button> </a>
        </div>

    </body>
</html>
