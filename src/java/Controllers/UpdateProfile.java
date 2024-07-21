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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;

/**
 *
 * @author lecon
 */
@MultipartConfig()
@WebServlet(name = "UpdateProfile", urlPatterns = {"/UpdateProfile"})
public class UpdateProfile extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfile at " + request.getContextPath() + "</h1>");
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
        String name = request.getParameter("name");

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
        }
        if (role.equals("admin")) {
            AdminDAO dao = new AdminDAO();
            Admin st = dao.getProfileAdmin(name);
            request.setAttribute("admin", st);
            request.getRequestDispatcher("UpdateProfileAdmin.jsp").forward(request, response);
        }
        if (role.equals("employee")) {
            EmployeesDAO dao = new EmployeesDAO();
            Employees st = dao.getProfileEm(name);
            request.setAttribute("employee", st);
            request.getRequestDispatcher("UpdateProfileEm.jsp").forward(request, response);
        }
        if (role.equals("customer")) {
            CustomersDAO dao = new CustomersDAO();
            Customers st = dao.getProfileCus(name);
            request.setAttribute("customer", st);
            request.getRequestDispatcher("UpdateProfileCus.jsp").forward(request, response);
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
        AdminDAO dao = new AdminDAO();
        String name = request.getParameter("username");
        String password_raw = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String birthday_raw = request.getParameter("birthday");
        Date birthday = Date.valueOf(birthday_raw);
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender_raw = request.getParameter("gender");
        boolean gender;
        if (gender_raw.equalsIgnoreCase("Male")) {
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
        }
        if (role.equals("admin")) {
            Admin add = new Admin(name, password_raw, fullName, birthday, email, phone, gender, address, absolutePath);
            dao.updateAdmin(add);
            response.sendRedirect("ProfileAdmin.jsp");
        }
        if (role.equals("employee")) {
            EmployeesDAO em = new EmployeesDAO();
            Employees addem = new Employees(name, password_raw, fullName, birthday, email, phone, gender, address, absolutePath);
            em.updateEmployee(addem);
            response.sendRedirect("ProfileEm.jsp");
        }

        if (role.equals("customer")) {
            CustomersDAO cus = new CustomersDAO();
            Customers addcus = new Customers(name, password_raw, fullName, birthday, email, phone, gender, address, absolutePath);
            cus.updateCustomer(addcus);
            response.sendRedirect("ProfileCus.jsp");
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
