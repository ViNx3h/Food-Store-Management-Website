/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBcontext.DBConnection;
import Models.Bills;
import Models.Orders;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VINH
 */
public class OrdersDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public OrdersDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Orders addNew(Orders newOrder) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into [OrderFood] values (?,?,?,?)");
            ps.setInt(1, newOrder.getIdOrder());
            ps.setInt(2, newOrder.getIdFood());
            ps.setInt(3, newOrder.getQuantity());
            ps.setInt(4, newOrder.getPrice());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newOrder;
    }

    public ResultSet getOrder(int bill_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM [OrderFood] where idOrder = ?");
            ps.setInt(1, bill_id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int getTotalPrice(int idOrder) throws Exception {
        int price = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT price, quantity FROM OrderFood WHERE idOrder=?");
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                price += rs.getInt("price") * rs.getInt("quantity");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return price;
    }

    public int getPrice(int idFood, int idOrder) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT price, quantity FROM OrderFood WHERE idFood=? and idOrder = ?");
            ps.setInt(1, idFood);
            ps.setInt(2, idOrder);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("price");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int getAmount(int idFood, int idOrder) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT price, quantity FROM OrderFood WHERE idFood=? and idOrder = ?");
            ps.setInt(1, idFood);
            ps.setInt(2, idOrder);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("price") * rs.getInt("quantity");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<Orders> getAllOrderFoods() {
        List<Orders> list = new ArrayList<>();
        String sql = "select * from OrderFood";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

            }
        } catch (Exception e) {
        }
        return list;
    }

    public int getRevenueOfMonth() {
        int totalRevenue = 0;
        // Lấy ngày đầu và ngày cuối của tháng hiện tại
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String startDate = dateFormat.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        String endDate = dateFormat.format(calendar.getTime());
        String sql = "SELECT SUM([of].quantity * [of].price) AS totalRevenue "
                + "FROM [Order] o "
                + "JOIN OrderFood [of] ON o.idOrder = [of].idOrder "
                + "WHERE o.orderDate BETWEEN ? AND ?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            rs = ps.executeQuery();
            if (rs.next()) {
                totalRevenue = rs.getInt("totalRevenue");
            }
        } catch (Exception e) {
        }
        return totalRevenue;
    }

    public int getTotalOrders() {
        int totalOrders = 0;
        String sql = "SELECT COUNT(*) AS totalOrders FROM [Order] where Confirm = 'Confirm'";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt("totalOrders");
            }
        } catch (Exception e) {
        }
        return totalOrders;
    }

    public List<Integer> fetchRevenueData() {
        List<Integer> data = new ArrayList<>();
        String sql = "SELECT MONTH(orderDate) AS month,\n"
                + "       YEAR(orderDate) AS year,\n"
                + "       SUM(total_quantity) AS totalRevenue\n"
                + "FROM [Order]\n"
                + "WHERE orderDate >= DATEADD(MONTH, -11, GETDATE()) -- Lấy dữ liệu trong vòng 12 tháng gần đây\n"
                + "GROUP BY YEAR(orderDate), MONTH(orderDate)\n"
                + "ORDER BY year, month;";
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int totalRevenue = rs.getInt("totalRevenue"); // Sử dụng tên đúng của cột
                data.add(totalRevenue);
            }

        } catch (SQLException e) {
            // Xử lý ngoại lệ SQL
            e.printStackTrace(); // In ra lỗi để dễ dàng theo dõi và sửa lỗi
        } catch (Exception e) {
            // Xử lý các ngoại lệ khác
            e.printStackTrace();
        } finally {
            // Đóng các đối tượng ResultSet, PreparedStatement và Connection
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return data;
    }

    public int[] getTotal12Month() {
        int[] revenueArray = new int[12];
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        for (int month = 1; month <= 12; month++) {
            calendar.set(Calendar.MONTH, month - 1);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            String startDate = dateFormat.format(calendar.getTime());
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            String endDate = dateFormat.format(calendar.getTime());

            String sql = "SELECT SUM([of].quantity * [of].price) AS totalRevenue "
                    + "FROM [Order] o "
                    + "JOIN OrderFood [of] ON o.idOrder = [of].idOrder "
                    + "WHERE MONTH(o.orderDate) = ? and Confirm = 'Confirm'";

            try {
                conn = DBcontext.DBConnection.connect();
                ps = conn.prepareStatement(sql);
                ps.setInt(1, month);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int revenue = rs.getInt("totalRevenue");
                    revenueArray[month - 1] = revenue;
                } else {
                    revenueArray[month - 1] = 0; // Đặt giá trị 0 nếu không có dữ liệu danh thu cho tháng này
                }
            } catch (SQLException | ClassNotFoundException e) {
                // Xử lý ngoại lệ nếu có
                e.printStackTrace();
            }
        }
        return revenueArray;
    }

    public static void main(String[] args) {
        OrdersDAO o = new OrdersDAO();
        int[] data = o.getTotal12Month();

        // In ra tổng danh thu của từng tháng
        for (int month = 0; month < 12; month++) {
            System.out.println("Tháng " + (month + 1) + ": " + data[month]);
        }
    }

}
