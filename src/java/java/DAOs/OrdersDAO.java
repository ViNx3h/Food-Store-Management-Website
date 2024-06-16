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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VINH
 */
public class OrdersDAO {
    Connection conn;

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
}
