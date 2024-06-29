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
import java.util.ArrayList;
import java.util.List;
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

    public int getAmount(int idFood) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT price, quantity FROM OrderFood WHERE idFood=?");
            ps.setInt(1, idFood);
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
    
    

}
