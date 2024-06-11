/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class ShoppingCartDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public ShoppingCartDAO() throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAll(String cus_us) throws Exception {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("select * from Cart where userCus = ?");
            ps.setString(1, cus_us);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int getQuantity(String cus_us) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(idFood) as count FROM Cart WHERE userCus=?");
            ps.setString(1, cus_us);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count") + 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public Cart addNew(Cart newSC) throws Exception {
        int count = 0;

        int quantity = getQuantity(newSC.getCus_us());
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Insert into Cart values (?,?,?,?)");
            ps.setString(1, newSC.getCus_us());
            ps.setInt(2, newSC.getPro_id());
            ps.setInt(3, quantity);
            ps.setInt(4, newSC.getPrice());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newSC;
    }

    public void delete(String cus_us) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareCall("Delete from Cart Where userCus=?");
            ps.setString(1, cus_us);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteProduct(String cus_us, int pro_id) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareCall("Delete from Cart Where userCus=? and idFood=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean existProduct(String cus_us, int pro_id) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Cart WHERE userCus=? AND idFood=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void updateQuantity(String cus_us, int pro_id) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareCall("update Cart set quantity = quantity + 1 Where userCus=? and idFood=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean downQuantity(int pro_id, int quantity) throws Exception {
        if (quantity > 1) {
            try {
                conn = DBcontext.DBConnection.connect();
                PreparedStatement ps = conn.prepareStatement("update Cart set quantity = quantity - 1 Where idFood=?");
                ps.setInt(1, pro_id);
                ps.executeUpdate();
                return true;
            } catch (SQLException ex) {
                Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public boolean upQuantity(int pro_id, int quantity, int pro_quantity) throws Exception {
        if (quantity < pro_quantity) {
            try {
                conn = DBcontext.DBConnection.connect();
                PreparedStatement ps = conn.prepareStatement("update Cart set quantity = quantity + 1 Where idFood=?");
                ps.setInt(1, pro_id);
                ps.executeUpdate();
                return true;
            } catch (SQLException ex) {
                Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public int getPrice(int idFood) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT price FROM Food WHERE idFood=?");
            ps.setInt(1, idFood);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("price");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int getQuantityOrder(String cus_us) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(idFood) as count FROM Cart WHERE userCus=?");
            ps.setString(1, cus_us);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
