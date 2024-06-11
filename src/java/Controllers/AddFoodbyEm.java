/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.EmployeesDAO;
import DAOs.FoodsDAO;
import Models.Foods;
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
        Cookie[] cookies = request.getCookies();
        String username = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    username = cookie.getValue();
                    break;
                }
            }
        }
        request.setAttribute("username", username);
        try {
            // Retrieve form parameters
            String idFood_raw = request.getParameter("idFood");
            int idFood = Integer.parseInt(idFood_raw);
            String name_Food = request.getParameter("name_Food");
            String price_raw = request.getParameter("price");
            int price = Integer.parseInt(price_raw);
            String description = request.getParameter("description");
            String status_raw = request.getParameter("status");
            boolean status = "available".equalsIgnoreCase(status_raw);
            String id_category_raw = request.getParameter("id_category");
            int id_category = Integer.parseInt(id_category_raw);
            String quantity_raw = request.getParameter("quantity");
            int quantity = Integer.parseInt(quantity_raw);

            // Handle file upload
            Part part = request.getPart("pic");
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();

            // Get the real path for saving the file
            String realPath = getServletContext().getRealPath("/images");
            Files.createDirectories(Paths.get(realPath)); // Ensure directory exists
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
                f.setStatus(status);
                f.setId_category(id_category);
                f.setQuantity(quantity);
                dao.addNewFood(f);
                EmployeesDAO a = new EmployeesDAO();
                a.detailAdd(username, idFood, price, absolutePath, description, id_category, quantity);
                response.sendRedirect("DashBoardEmployee.jsp");
            } else {
                // Handle the case where the food item already exists
                response.getWriter().println("Food item with the given ID already exists.");
            }

        } catch (NumberFormatException e) {
            // Handle the case where numeric values cannot be parsed
            response.getWriter().println("Invalid numeric value provided.");
        } catch (IOException e) {
            // Handle file I/O errors
            response.getWriter().println("Error occurred while processing file upload.");
        } catch (Exception e) {
            // Handle other exceptions
            response.getWriter().println("An error occurred: " + e.getMessage());
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
