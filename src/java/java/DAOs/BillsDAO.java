/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBcontext.DBConnection;
import Models.Bills;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VINH
 */
public class BillsDAO {
    Connection conn;

    public BillsDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Bills addNew(Bills newBill) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into [Order] values (?,GETDATE(),?,?,?,?)");
            ps.setString(1, newBill.getUserCus());
            ps.setInt(2, newBill.getTotal_quantity());
            ps.setString(3, newBill.getNote());
            ps.setString(4, newBill.getAddress());
            ps.setString(5, newBill.getPhone());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newBill;
    }

    public int getID() {
        int id = 0;
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT TOP 1 idOrder FROM [Order] ORDER BY idOrder DESC");
            if(rs.next()) {
                id = rs.getInt("idOrder");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

    public ResultSet getBill(String cus_us) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM [Order] where userCus = ?");
            ps.setString(1, cus_us);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getBill_byDate(Date date) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM [Order] where orderDate = ?");
            ps.setDate(1, date);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public long total_income_a_date(Date date) {
        long total_income = 0;
        ResultSet rs;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT SUM(total_quantity) as total FROM [Order] WHERE orderDate = ?");
            ps.setDate(1, date);
            rs = ps.executeQuery();
            if(rs.next()) {
                total_income = rs.getLong("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total_income;
    }

    public ResultSet getBill_byMonth(Date date) {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM [Order] WHERE Month(orderDate) = Month('" + date + "') AND Year(orderDate) = Year('" + date + "')");
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public long total_income_a_month(Date date) {
        long total_income = 0;
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT SUM(total_quantity) as total FROM [Order] WHERE Month(orderDate) = Month('" + date + "') AND Year(orderDate) = Year('" + date + "')");
            if(rs.next()) {
                total_income = rs.getLong("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total_income;
    }

    public ResultSet getBill_byYear(int year) {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM [Order] WHERE Year(orderDate) = " + year);
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public long total_income_a_year(int year) {
        long total_income = 0;
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT SUM(total) as total FROM [Order] WHERE Year(orderDate) = " + year);
            if(rs.next()) {
                total_income = rs.getLong("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total_income;
    }

    public String getNote(String value) {
        String note = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT note FROM [Order] WHERE userCus = ?");
            ps.setString(1, value);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                note = rs.getString("note");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return note;
    }
    
    public String getAddress(String value) {
        String address = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT address FROM [Order] WHERE userCus = ?");
            ps.setString(1, value);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                address = rs.getString("address");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return address;
    }
    
    public String getPhone(String value) {
        String phone = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT phone FROM [Order] WHERE userCus = ?");
            ps.setString(1, value);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                phone = rs.getString("phone");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return phone;
    }
}
