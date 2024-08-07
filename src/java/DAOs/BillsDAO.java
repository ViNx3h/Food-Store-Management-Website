/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBcontext.DBConnection;
import Models.Bills;
import Models.Orders;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VINH
 */
public class BillsDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

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
            PreparedStatement ps = conn.prepareStatement("Insert into [Order] values (?,GETDATE(),?,?,?,?,?)");
            ps.setString(1, newBill.getUserCus());
            ps.setInt(2, newBill.getTotal_quantity());
            ps.setString(3, newBill.getNote());
            ps.setString(4, newBill.getAddress());
            ps.setString(5, newBill.getPhone());
            ps.setString(6, newBill.getConfirm());
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
            if (rs.next()) {
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
            PreparedStatement ps = conn.prepareStatement("select * from [Order] where userCus =? ORDER BY orderDate DESC, "
                    + " CASE \n"
                    + "        WHEN Confirm = 'no' THEN 1\n"
                    + "        WHEN Confirm = 'ongoing' THEN 2\n"
                    + "        WHEN Confirm = 'confirm' THEN 3\n"
                    + "    END;");
            ps.setString(1, cus_us);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

//    public List<Bills> getBillUser(String cus_us) {
//        String sql = "select * from [Order] INNER join [OrderFood] on [Order].idOrder = [OrderFood].idOrder where userCus =" + cus_us;
//        List<Bills> list = new ArrayList<>();
//        try {
//            conn = DBcontext.DBConnection.connect();
//            ps = conn.prepareStatement(sql);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                Bills b = new Bills();
//                Orders o = new Orders();
//                b.setIdOrder(rs.getInt("idOrder"));
//                b.setUserCus(rs.getString("userCus"));
//                b.setOrderDate(rs.getDate("orderDate"));
//                b.setTotal_quantity(rs.getInt("total_quantity"));
//                b.setNote(rs.getString("note"));
//                b.setAddress(rs.getString("[address]"));
//                b.setPhone(rs.getString("[[phone]]"));
//                
//            }
//        } catch (Exception e) {
//        }
//        return null;
//
//    }
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
            if (rs.next()) {
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
            if (rs.next()) {
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
            if (rs.next()) {
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
            if (rs.next()) {
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
            if (rs.next()) {
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
            if (rs.next()) {
                phone = rs.getString("phone");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return phone;
    }

    public String getNote(int value) {
        String note = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT note FROM [Order] WHERE idOrder = ?");
            ps.setInt(1, value);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                note = rs.getString("note");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return note;
    }

    public String getAddress(int value) {
        String address = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT address FROM [Order] WHERE idOrder = ?");
            ps.setInt(1, value);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                address = rs.getString("address");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return address;
    }

    public String getPhone(int value) {
        String phone = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT phone FROM [Order] WHERE idOrder = ?");
            ps.setInt(1, value);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                phone = rs.getString("phone");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return phone;
    }

    public int getBillId(int value) {
        int id = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from [Order] WHERE idOrder = ?");
            ps.setInt(1, value);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt("idOrder");
            }
        } catch (Exception e) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return id;
    }

    public ResultSet getBillById(int id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from [Order]  where idOrder = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public String getConfirm(int value) {
        String phone = "";
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT phone FROM [Order] WHERE idOrder = ?");
            ps.setInt(1, value);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                phone = rs.getString("phone");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return phone;
    }

    public void updateStatus(String status, int idOrder) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareCall("update [Order] set Confirm = ? Where idOrder=?");
            ps.setString(1, status);
            ps.setInt(2, idOrder);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
