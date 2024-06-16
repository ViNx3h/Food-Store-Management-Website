/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AdminDAO;
import DAOs.CustomersDAO;
import DAOs.EmployeesDAO;
import Models.Admin;
import Models.Customers;
import Models.Employees;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);

        String username = request.getParameter("username");
        String password_raw = request.getParameter("password");
        String role = request.getParameter("role");
        if (role.equals("admin")) {
            AdminDAO dao = new AdminDAO();
            String password = dao.hashPasswordMD5(password_raw);
            List<Admin> account = dao.checkLogin(username, password);
            if (!account.isEmpty()) {
                // set session
                HttpSession session = request.getSession(); // tao session cho username
                session.setAttribute("username", username); // save username

                // set username cookie
                Cookie user_name = new Cookie("admin", username);
                user_name.setMaxAge(60 * 60 * 72);
                response.addCookie(user_name);

                response.sendRedirect("DashBoardAdmin.jsp");
            } else {
                response.sendRedirect("Login.jsp");
            }
        } else if (role.equals("employee")) {
            EmployeesDAO dao = new EmployeesDAO();
            String password = dao.hashPasswordMD5(password_raw);
            List<Employees> account = dao.checkLogin(username, password);
            if (!account.isEmpty()) {
                // set session
                HttpSession session = request.getSession(); // tao session cho username
                session.setAttribute("username", username); // save username

                // set username cookie
                Cookie user_name = new Cookie("employee", username);
                user_name.setMaxAge(60 * 60 * 72);
                response.addCookie(user_name);

                response.sendRedirect("DashBoardEmployee.jsp");
            } else {
                response.sendRedirect("Login.jsp");
            }
        } else if (role.equals("customer")) {
            CustomersDAO dao = new CustomersDAO();
            String password = dao.hashPasswordMD5(password_raw);
            List<Customers> account = dao.checkLogin(username, password);
            if (!account.isEmpty()) {
                // set session
                HttpSession session = request.getSession(); // tao session cho username
                session.setAttribute("username", username); // save username

                // set username cookie
                Cookie user_name = new Cookie("customer", username);
                user_name.setMaxAge(60 * 60 * 72);
                response.addCookie(user_name);

                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("Login.jsp");
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
        processRequest(request, response);
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
