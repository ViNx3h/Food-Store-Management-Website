/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.Employees;
import DAOs.EmployeesDAO;
import jakarta.servlet.annotation.MultipartConfig;
import java.sql.Date;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author ADMIN
 */
@MultipartConfig()
@WebServlet(name = "AddEm", urlPatterns = {"/AddEm"})
public class AddEm extends HttpServlet {

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
            out.println("<title>Servlet AddEm</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddEm at " + request.getContextPath() + "</h1>");
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
        try {
            String userEmployee = request.getParameter("userEmployee");
            String password_raw = request.getParameter("password");
            EmployeesDAO hash = new EmployeesDAO();
            String password = hash.hashPasswordMD5(password_raw);
            String fullName = request.getParameter("fullName");
            String birthday_raw = request.getParameter("birthday");
            Date birthday = Date.valueOf(birthday_raw);
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String gender_raw = request.getParameter("gender");
            boolean gender;
            if (gender_raw.equals("male")) {
                gender = true;
            } else {
                gender = false;
            }
            String address = request.getParameter("address");

            // Handle file upload
            Part part = request.getPart("img");
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();

            // Get the real path for saving the file
            String realPath = getServletContext().getRealPath("/images");
            Files.createDirectories(Paths.get(realPath)); // Ensure directory exists
            String filePath = Paths.get(realPath, filename).toString();
            part.write(filePath);
            String absolutePath = "images/" + filename;

            EmployeesDAO dao = new EmployeesDAO();
            Employees check = dao.findEmbyUser(userEmployee);
            if (check == null) {
                Employees add = new Employees(userEmployee, password, fullName, birthday, email, phone, gender, address, absolutePath);
                dao.addnewEm(add);
                response.sendRedirect("Employees.jsp");
            } else {
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
