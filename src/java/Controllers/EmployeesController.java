package Controllers;

import DAOs.BillsDAO;
import DAOs.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author VINH
 */
public class EmployeesController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EmployeesController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmployeesController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.startsWith("/FoodStoreManagement/EmployeesController/ConfirmOrder_Process")){
            String[] s = path.split("/");
            try {
                String userCus = s[s.length - 1];
                CustomersDAO cDAO = new CustomersDAO();
                if (userCus == null) {
                    response.sendRedirect("/ManageStatus.jsp");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", userCus);
                    response.sendRedirect("/FoodStoreManagement/EmployeesController/ConfirmOrder");
                }
            } catch (Exception e) {
                response.sendRedirect("/FoodStoreManagement/AdminController/Dashboard");
            }
        } else if (path.endsWith("/FoodStoreManagement/EmployeesController/ConfirmOrder")){
request.getRequestDispatcher("/ConfirmOrder.jsp").forward(request, response);
        } else if (path.startsWith("/FoodStoreManagement/EmployeesController/ManageOrder_Process/OnGoing")){
            String[] s = path.split("/");
            try {
                int id = Integer.valueOf(s[s.length - 1]);
                String status = s[s.length -2];
                BillsDAO bDAO = new BillsDAO();
                if (id == 0) {
                    response.sendRedirect("/FoodStoreManagement/EmployeesController/ConfirmOrder");
                } else {
                    bDAO.updateStatus(status, id);
                    HttpSession session = request.getSession();
                    session.setAttribute("id", id);
                    response.sendRedirect("/FoodStoreManagement/EmployeesController/ConfirmOrder");
                }
            } catch (Exception e) {
                response.sendRedirect("/FoodStoreManagement/AdminController/Dashboard");
            }
        }
        else if (path.startsWith("/FoodStoreManagement/EmployeesController/ManageOrder_Process/Confirm")){
            String[] s = path.split("/");
            try {
                int id = Integer.valueOf(s[s.length - 1]);
                String status = s[s.length -2];
                BillsDAO bDAO = new BillsDAO();
                if (id == 0) {
                    response.sendRedirect("/FoodStoreManagement/EmployeesController/ConfirmOrder");
                } else {
                    bDAO.updateStatus(status, id);
                    HttpSession session = request.getSession();
                    session.setAttribute("id", id);
                    response.sendRedirect("/FoodStoreManagement/EmployeesController/ConfirmOrder");
                }
            } catch (Exception e) {
                response.sendRedirect("/FoodStoreManagement/AdminController/Dashboard");
            }
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}