/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CategoriesDAO;
import DAOs.EmployeesDAO;
import DAOs.FoodsDAO;
import Models.Categories;
import Models.Foods;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 *
 * @author ADMIN
 */
@MultipartConfig()
@WebServlet(name = "AddFoodbyEm", urlPatterns = {"/AddFoodbyEm"})
public class AddFoodbyEm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddFoodbyEm</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddFoodbyEm at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        Cookie[] cList = null;
        cList = request.getCookies();
        boolean flagEmployee = false;
        if (cList != null) {
            String value = "";
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("employee")) {
                    value = cList[i].getValue();
                    flagEmployee = true;
                    break;
                }
            }

            if (flagEmployee) {
                try {
                    String idFood_raw = request.getParameter("idFood");
                    int idFood = Integer.parseInt(idFood_raw);
                    String name_Food = request.getParameter("name_Food");
                    String price_raw = request.getParameter("price");
                    int price = Integer.parseInt(price_raw);
                    String description = request.getParameter("description");
                    String quantity_raw = request.getParameter("quantity");
                    int quantity = Integer.parseInt(quantity_raw);
                    String status_raw = request.getParameter("status");
                    boolean status = "available".equalsIgnoreCase(status_raw);
                    String id_category_raw = request.getParameter("id_category");
                    int id_category = Integer.parseInt(id_category_raw); // Ensure id_category is parsed correctly

                    // Handle file upload
                    Part part = request.getPart("pic");
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String realPath = getServletContext().getRealPath("/images");
                    Files.createDirectories(Paths.get(realPath));
                    String filePath = Paths.get(realPath, filename).toString();
                    part.write(filePath);
                    String absolutePath = "images/" + filename;

                    // Create Foods object and save to database
                    FoodsDAO dao = new FoodsDAO();
                    Foods check = dao.findFoodsById(idFood);
                    if (check == null) {
                        Foods f = new Foods();
                        f.setIdFood(idFood);
                        f.setName_food(name_Food);
                        f.setPrice(price);
                        f.setPic(absolutePath);
                        f.setDescription(description);
                        f.setQuantity(quantity);
                        f.setStatus(status);
                        f.setId_category(id_category);
                        // Add other properties as needed
                        dao.addNewFood(f);
                        EmployeesDAO eDAO = new EmployeesDAO();
                        eDAO.detailAdd(value, idFood, price, absolutePath, description, id_category, quantity);
                        // Redirect to dashboard or other page upon success
                        response.sendRedirect("DashBoardEmployee.jsp");
                    } else {
                        // Handle case where food item already exists
                        // response.getWriter().println("Food item with the given ID already exists.");
                        request.setAttribute("AddError", "Food item with the given ID already exists");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("AddFoodbyEm.jsp");
                        dispatcher.forward(request, response);
                    }

                } catch (NumberFormatException e) {
                    // Handle number format exceptions
                    e.printStackTrace();
                } catch (IOException e) {
                    // Handle file IO exceptions
                    e.printStackTrace();
                } catch (Exception e) {
                    // Handle other exceptions
                    e.printStackTrace();
                }
            } else {
                response.sendRedirect("/FoodStoreManagement"); // Redirect to login or appropriate page
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
