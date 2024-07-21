/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.EmployeesDAO;
import DAOs.FoodsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "DeleteFood", urlPatterns = {"/DeleteFood"})
public class DeleteFood extends HttpServlet {

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
            out.println("<title>Servlet DeleteFood</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteFood at " + request.getContextPath() + "</h1>");
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
        String idFood_raw = request.getParameter("id");
        int idFood = Integer.parseInt(idFood_raw);
        Cookie[] cList = null;
        cList = request.getCookies();
        String role = "";
        if (cList != null) {
            String value = "";
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("employee")) {
                    value = cList[i].getValue();
                    role = "employee";
                    break;
                } else if (cList[i].getName().equals("admin")) {
                    value = cList[i].getValue();
                    role = "admin";
                    break;
                }

            }
            FoodsDAO dao = new FoodsDAO();
            if (role.equals("admin")) {
                dao.deleteFood(idFood);
                response.sendRedirect("DashBoardAdmin.jsp");
                
            } else if (role.equals("employee")) {
                dao.deleteFood(idFood);
                EmployeesDAO d = new EmployeesDAO();
                d.detailDelete(value, idFood);
                response.sendRedirect("DashBoardEmployee.jsp");
            }
        }
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
