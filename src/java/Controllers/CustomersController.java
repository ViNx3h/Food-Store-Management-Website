/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CustomersDAO;
import DAOs.ShoppingCartDAO;
import Models.Cart;
import Models.Categories;
import Models.Customers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VINH
 */
@WebServlet("/Relay")
@MultipartConfig
public class CustomersController extends HttpServlet {

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
            out.println("<title>Servlet CustomersController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomersController at " + request.getContextPath() + "</h1>");
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
        String path = request.getRequestURI();
        if (path.endsWith("/FoodStoreManagement/CustomersController/ShoppingCart")) {
            request.getRequestDispatcher("/ShoppingCart.jsp").forward(request, response);
        } else if (path.startsWith("/FoodStoreManagement/CustomersController/AddCart")) {
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                boolean flagCustomer = false;
                String value = null;
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    }
                }
                if (flagCustomer == true) {
                    String[] s = path.split("/");
                    try {
                        int pro_id = Integer.parseInt(s[s.length - 1]);

                        for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                            if (cList1.getName().equals("customer")) { //nguoi dung da dang nhap
                                value = cList1.getValue();
                                break; //thoat khoi vong lap
                            }
                        }
                        ShoppingCartDAO scDAO = new ShoppingCartDAO();
                        boolean existProduct = scDAO.existProduct(value, pro_id);
                        if (existProduct) {
                            scDAO.updateQuantity(value, pro_id);
//                    response.sendRedirect("/CustomersController/ShoppingCart");
                            response.sendRedirect("/FoodStoreManagement/CustomersController/ShoppingCart");
                        } else {
                            int quantityOrder = scDAO.getQuantity(value);
                            int price = scDAO.getPrice(pro_id);
                            Cart scNew = new Cart(value, pro_id, quantityOrder, price);
                            Cart sc = scDAO.addNew(scNew);
                            if (sc == null) {
                                HttpSession session = request.getSession();
                                Categories type = (Categories) session.getAttribute("Category");
//                        response.sendRedirect("/CustomersController/Food/" + type.getId_category());
                                response.sendRedirect("/FoodStoreManagement/CustomersController/ShoppingCart");
                            } else {
//                        response.sendRedirect("/CustomersController/ShoppingCart");
                                response.sendRedirect("/FoodStoreManagement/CustomersController/ShoppingCart");
                            }
                        }
                    } catch (Exception e) {
                        HttpSession session = request.getSession();
                        Categories type = (Categories) session.getAttribute("Category");
                        response.sendRedirect("/FoodStoreManagement" + type.getId_category());
                    }
                } else {
                    response.sendRedirect("/FoodStoreManagement");
                }
            }
        } else if (path.endsWith("/Home")) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (path.startsWith("/FoodStoreManagement/CustomersController/upQuantity")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 3]);
                int quantity = Integer.parseInt(s[s.length - 2]);
                int pro_quantity = Integer.parseInt(s[s.length - 1]);

                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                boolean up = scDAO.upQuantity(id, quantity, pro_quantity);
                if (up) {
                    request.getRequestDispatcher("FoodStoreManagement/CustomersController/ShoppingCart").forward(request, response);
                } else {
                    request.getSession().setAttribute("upEror", "false");
                    request.getRequestDispatcher("FoodStoreManagement/CustomersController/ShoppingCart").forward(request, response);
                }

            } catch (NumberFormatException e) {
            } catch (Exception ex) {
                Logger.getLogger(CustomersController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (path.startsWith("/FoodStoreManagement/CustomersController/downQuantity")) {
            String[] s = path.split("/");
            try {
                int id = Integer.parseInt(s[s.length - 2]);
                int quantity = Integer.parseInt(s[s.length - 1]);

                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                boolean down = scDAO.downQuantity(id, quantity);
                if (down) {
                    request.getRequestDispatcher("FoodStoreManagement/CustomersController/ShoppingCart").forward(request, response);
                } else {
                    request.getSession().setAttribute("downError", "false");
                    request.getRequestDispatcher("FoodStoreManagement/CustomersController/ShoppingCart").forward(request, response);
                }
            } catch (NumberFormatException e) {
            } catch (Exception ex) {
                Logger.getLogger(CustomersController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (path.startsWith("/FoodStoreManagement/CustomersController/DeleteShoppingCart")) {
            String[] s = path.split("/");
            try {
                String cus_us = s[s.length - 2];
                int pro_id = Integer.parseInt(s[s.length - 1]);
                ShoppingCartDAO scDAO = new ShoppingCartDAO();
                scDAO.deleteProduct(cus_us, pro_id);
                response.sendRedirect("FoodStoreManagement/CustomersController/ShoppingCart");
            } catch (Exception e) {
                response.sendRedirect("FoodStoreManagement/CustomersController/ShoppingCart");
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
//        processRequest(request, response);
        if (request.getParameter("btnSubmit") != null) {

            CustomersDAO cDAO = new CustomersDAO();
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullname");
            String birthday = request.getParameter("birthday");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");

            if (username.isEmpty() || password.isEmpty() || fullname.isEmpty() || birthday.isEmpty() || email.isEmpty() || phone.isEmpty() || gender == null || address.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Please fill in all the information!");
                response.sendRedirect("/FoodStoreManagement/Login.jsp");
                if (gender == null) {
                    request.getSession().setAttribute("genderMessage", "Gender must not be empty!");
                }
                if (birthday.equals("")) {
                    request.getSession().setAttribute("birthdayMessage", "Birthday must not be empty!");
                    response.sendRedirect("/FoodStoreManagement/Login.jsp");
                }
            } else {
                try {
                    Customers checkCus = cDAO.getCustomer(username);
                    if (checkCus != null) {
                        request.getSession().setAttribute("checkMessage", "The account is already exist!");
                        response.sendRedirect("/FoodStoreManagement/Login.jsp");
                    } else {

                        Date date = Date.valueOf(birthday);
                        Boolean isMale = Boolean.valueOf(gender);
                        String pass_md5 = cDAO.getPwdMd5(password);
                        Customers newCus = new Customers(username, pass_md5, fullname, date, email, phone, isMale, address);
                        Customers rs = cDAO.addNew(newCus);
                        if (rs == null) {
                            request.getSession().setAttribute("errorMessage", "Create Fail!");
                            response.sendRedirect("/FoodStoreManagement/Login.jsp");
                        } else {
                            request.getSession().setAttribute("successMessage", "Create Successfully!");
                            response.sendRedirect("/FoodStoreManagement/Login.jsp");
                        }
                    }
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(CustomersController.class.getName()).log(Level.SEVERE, null, ex);
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
        return "CustomersController Servlet";
    }// </editor-fold>

}
