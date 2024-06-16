/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CategoriesDAO;
import Models.Categories;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 *
 * @author lecon
 */
@MultipartConfig()
@WebServlet(name = "UpdateCategories", urlPatterns = {"/UpdateCategories"})
public class UpdateCategories extends HttpServlet {

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
            out.println("<title>Servlet UpdateCategorys</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCategorys at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("id");
        int id = Integer.valueOf(id_raw);
        CategoriesDAO dao = new CategoriesDAO();
        Categories st = dao.findCategory(id);
        request.setAttribute("data", st);
        request.getRequestDispatcher("UpdateCategories.jsp").forward(request, response);

//        
//        CategoriesDAO dao = new CategoriesDAO();
//        Categorys st = dao.findCategory(id);
//        request.setAttribute("data", st);
//        request.getRequestDispatcher("updateCustomers.jsp").forward(request, response);
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
        String id_raw = request.getParameter("categoryID");
        int id = Integer.valueOf(id_raw);

        String name = request.getParameter("categoryname");

        // Handle file upload
        Part part = request.getPart("picture");
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();

        // Get the real path for saving the file
        String realPath = getServletContext().getRealPath("/images");
        Files.createDirectories(Paths.get(realPath)); // Ensure directory exists
        String filePath = Paths.get(realPath, filename).toString();
        part.write(filePath);
        String absolutePath = "images/" + filename;

        try {

            CategoriesDAO dao = new CategoriesDAO();

            Categories update = new Categories(id, name, absolutePath);

            dao.updateCategorys(update);
            response.sendRedirect("ViewCategories.jsp");

//            request.getRequestDispatcher("listCustomers.jsp").forward(request, response);
//            response.sendRedirect("login");
//            
        } catch (Exception e) {
            e.printStackTrace();
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
