/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.WorkingSchedulesDAO;
import Models.WorkingSchedule;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AddSchedule", urlPatterns = {"/AddSchedule"})
public class AddSchedule extends HttpServlet {

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
            out.println("<title>Servlet AddSchedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSchedule at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("id");
        int id = Integer.valueOf(id_raw);
        String username = request.getParameter("username");
//        String fullName = request.getParameter("fullName");
        WorkingSchedulesDAO eDAO = new WorkingSchedulesDAO();
        String fullName = eDAO.getFullName(username);

        String day_raw = request.getParameter("day");
        Date day = Date.valueOf(day_raw);
        String time = request.getParameter("time");

        Cookie[] cList = null;
        cList = request.getCookies();
        String role = "";
        if (cList != null) {
            String value = "";
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("admin")) {
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

                WorkingSchedulesDAO dao = new WorkingSchedulesDAO();
                WorkingSchedule add = new WorkingSchedule(id, username, fullName, day, time);
                dao.addnewSchedule(add);
                dao.reorderIds();
                response.sendRedirect("ViewSchedulebyAdmin.jsp");
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
