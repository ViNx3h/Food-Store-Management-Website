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

/**
 *
 * @author lecon
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
        String name = request.getParameter("username");
        String oldpass_raw = request.getParameter("oldpassword");
        String newpass_raw = request.getParameter("newpassword");
        String confirmpass_raw = request.getParameter("confirmpassword");

        Cookie[] cList = null;
        cList = request.getCookies();
        String role = "";
        if (cList != null) {
            String value = "";
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("customer")) {
                    value = cList[i].getValue();
                    role = "customer";
                    break;
                } else if (cList[i].getName().equals("admin")) {
                    value = cList[i].getValue();
                    role = "admin";
                    break;
                } else if (cList[i].getName().equals("employee")) {
                    value = cList[i].getValue();
                    role = "employee";
                    break;
                }
            }

            if (role.equals("admin")) {

                AdminDAO dao = new AdminDAO();
                String oldpass = dao.hashPasswordMD5(oldpass_raw);

                String newpass = dao.hashPasswordMD5(newpass_raw);
                String confirmpass = dao.hashPasswordMD5(confirmpass_raw);

                Admin admin = dao.findAdmin(name);

                if (admin != null) {
                    // Check if the old password is correct
                    if (!admin.getPassword().equals(oldpass)) {
                        // Old password is incorrect
                        request.setAttribute("errorMessage", "You entered your old password incorrectly.");
                        request.setAttribute("data", admin);
                        request.getRequestDispatcher("ProfileAdmin.jsp").forward(request, response);
                    } else if (!newpass.equals(confirmpass)) {
                        // New password and confirm password do not match
                        request.setAttribute("errorMessage", "New password does not match.");
                        request.setAttribute("data", admin);
                        request.getRequestDispatcher("ProfileAdmin.jsp").forward(request, response);
                    } else {
                        // Change the password
                        Admin st = new Admin(name, newpass);
                        dao.ChangePassAdmin(st);

                        // Set success message
                        request.setAttribute("errorMessagee", "Password changed successfully!");
                        request.setAttribute("data", admin);
                        request.getRequestDispatcher("ProfileAdmin.jsp").forward(request, response);
                    }
                } else {
                    // Handle case when admin is null (if needed)
                }
            }
            if (role.equals("employee")) {

                EmployeesDAO dao = new EmployeesDAO();
                String oldpass = dao.hashPasswordMD5(oldpass_raw);

                String newpass = dao.hashPasswordMD5(newpass_raw);
                String confirmpass = dao.hashPasswordMD5(confirmpass_raw);

                Employees employees = dao.findEmbyUser(name);

                if (employees != null) {
                    // Check if the old password is correct
                    if (!employees.getPassword().equals(oldpass)) {
                        // Old password is incorrect
                        request.setAttribute("errorMessage", "You entered your old password incorrectly.");
                        request.setAttribute("data", employees);
                        request.getRequestDispatcher("ProfileEm.jsp").forward(request, response);
                    } else if (!newpass.equals(confirmpass)) {
                        // New password and confirm password do not match
                        request.setAttribute("errorMessage", "New password does not match.");
                        request.setAttribute("data", employees);
                        request.getRequestDispatcher("ProfileEm.jsp").forward(request, response);
                    } else {
                        // Change the password
                        Employees st = new Employees(name, newpass);
                        dao.ChangePassEm(st);
                        // Set success message
                        request.setAttribute("errorMessagee", "Password changed successfully!");
                        request.setAttribute("data", employees);
                        request.getRequestDispatcher("ProfileEm.jsp").forward(request, response);
                    }
                } else {
                    // Handle case when admin is null (if needed)
                }
            }
            if (role.equals("customer")) {

                CustomersDAO dao = new CustomersDAO();
                String oldpass = dao.hashPasswordMD5(oldpass_raw);

                String newpass = dao.hashPasswordMD5(newpass_raw);
                String confirmpass = dao.hashPasswordMD5(confirmpass_raw);

                Customers customers = dao.findCustomers(name);

                if (customers != null) {
                    // Check if the old password is correct
                    if (!customers.getPassword().equals(oldpass)) {
                        // Old password is incorrect
                        request.setAttribute("errorMessage", "You entered your old password incorrectly.");
                        request.setAttribute("data", customers);
                        request.getRequestDispatcher("ProfileCus.jsp").forward(request, response);
                    } else if (!newpass.equals(confirmpass)) {
                        // New password and confirm password do not match
                        request.setAttribute("errorMessage", "New password does not match.");
                        request.setAttribute("data", customers);
                        request.getRequestDispatcher("ProfileCus.jsp").forward(request, response);
                    } else {
                        // Change the password
                        Customers st = new Customers(name, newpass);
                        dao.ChangePassCustomer(st);
                        // Set success message
                        request.setAttribute("errorMessagee", "Password changed successfully!");
                        request.setAttribute("data", customers);
                        request.getRequestDispatcher("ProfileCus.jsp").forward(request, response);
                    }
                } else {
                    // Handle case when admin is null (if needed)
                }
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
