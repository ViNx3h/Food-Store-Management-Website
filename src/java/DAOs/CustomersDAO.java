/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Customers;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
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
 * @author ADMIN
 */
public class CustomersDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public String hashPasswordMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashedBytes = md.digest(password.getBytes());

            // Convert byte array to a hexadecimal string
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            // Handle exception (e.g., log or throw)
            e.printStackTrace();
            return null;
        }
    }

    public List<Customers> checkLogin(String user, String pass) {

        List<Customers> list = new ArrayList<>();
        try {
            String sql = "select * from Customer where userCus=? and password=?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setUserCus(rs.getString("userCus"));
                c.setPassword(rs.getString("password"));
                list.add(c);
            }

        } catch (Exception e) {
        }

        return list;
    }

    public List<Customers> getAllCustomers() {
        List<Customers> list = new ArrayList<>();
        try {
            String sql = "select * from Customer";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Customers st = new Customers();
                st.setUserCus(rs.getString("userCus"));
                st.setPassword(rs.getString("password"));
                st.setFullName(rs.getString("fullName"));
                st.setBirthday(rs.getDate("birthday"));
                st.setEmail(rs.getString("email"));
                st.setPhone(rs.getString("phone"));
                st.setGender(rs.getBoolean("gender"));
                st.setAddress(rs.getString("address"));
                st.setImg(rs.getString("img"));
                list.add(st);
            }
        } catch (Exception e) {
        }
        return list;

    }

    public int[] getIdOrderFood(String userCus) {
        List<Integer> idList = new ArrayList<>();
        String sql = "select idOrder from [Order] where userCus = ?";

        try ( Connection conn = DBcontext.DBConnection.connect();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userCus);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int a = rs.getInt("idOrder");
                    idList.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Convert List to array
        int[] id = new int[idList.size()];
        for (int i = 0; i < idList.size(); i++) {
            id[i] = idList.get(i);
        }

        return id;
    }

    public void deleteOrderFood(int id) {
        String sql = "delete from [OrderFood] where idOrder = ?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteCusOrder(String userCus) {
        String sql = "delete from [Order] where userCus = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userCus);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteFeedback(String userCus) {
        String sql = "delete from Feedback where userCus = ?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userCus);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        CustomersDAO c = new CustomersDAO();
        c.deleteCus("toan123");
    }

    public void deleteCus(String userCus) {
        String sql = "delete from Customer where userCus = ?";
        try {
            int[] id = getIdOrderFood(userCus);
            for (int i = 0; i < id.length; i++) {
                deleteOrderFood(id[i]);
            }
            deleteCusOrder(userCus);
            deleteCusOrder(userCus);
            deleteFeedback(userCus);
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userCus);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteCusOrder(int idOrder) {
        String sql = "delete from [OrderFood] where idOrder = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public Customers getProfileCus(String username) {
        Customers cus = new Customers();
        try {
            String sql = "select * from Customer where userCus = '" + username + "'";

            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                cus.setUserCus(rs.getString("userCus"));
                cus.setPassword(rs.getString("password"));
                cus.setFullName(rs.getString("fullName"));
                cus.setBirthday(rs.getDate("birthday"));
                cus.setEmail(rs.getString("email"));
                cus.setPhone(rs.getString("phone"));
                cus.setGender(rs.getBoolean("gender"));
                cus.setAddress(rs.getString("address"));
                cus.setImg(rs.getString("img"));
            }
        } catch (Exception e) {

        }
        return cus;
    }

    public Customers getCustomer(String username) throws ClassNotFoundException {
        Customers cus = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Customer Where userCus = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cus = new Customers(rs.getString("userCus"), rs.getString("password"), rs.getString("fullName"), rs.getDate("birthday"), rs.getString("email"), rs.getString("phone"), rs.getBoolean("gender"), rs.getString("address"), rs.getString("img"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cus;
    }

    public String getPwdMd5(String input) {
        try {

            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public Customers addNew(Customers newCustomer) throws ClassNotFoundException {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Insert into Customer values (?,?,?,?,?,?,?,?,?)");
            ps.setString(1, newCustomer.getUserCus());
            ps.setString(2, newCustomer.getPassword());
            ps.setString(3, newCustomer.getFullName());
            ps.setDate(4, newCustomer.getBirthday());
            ps.setString(5, newCustomer.getEmail());
            ps.setString(6, newCustomer.getPhone());
            ps.setBoolean(7, newCustomer.isGender());
            ps.setString(8, newCustomer.getAddress());
            ps.setString(9, newCustomer.getImg());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newCustomer;
    }

    public String getEmail(String username) throws ClassNotFoundException {
        String email = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select email from Customer Where userCus = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return email;
    }

    public void ChangePassCustomer(String newPass, String username) {
        String sql = "update Customer set password=? where userCus=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, newPass);
            ps.setString(2, username);

            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public String getUserCus(String username) throws ClassNotFoundException {
        String email = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Customer Where userCus = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                email = rs.getString("userCus");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return email;
    }

    public void updateCustomer(Customers st) {
        String sql = "update Customer set userCus=?, password=?,fullName=?, birthday=?, email=?, phone=?, gender=?, address=?, img=? where userCus=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, st.getUserCus());
            ps.setString(2, st.getPassword());
            ps.setString(3, st.getFullName());
            ps.setDate(4, st.getBirthday());
            ps.setString(5, st.getEmail());
            ps.setString(6, st.getPhone());
            ps.setBoolean(7, st.isGender());
            ps.setString(8, st.getAddress());
            ps.setString(9, st.getImg());
            ps.setString(10, st.getUserCus());

            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public void ChangePassCustomer(Customers st) {
        String sql = "update Customer set userCus = ?, password=? where userCus=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, st.getUserCus());
            ps.setString(2, st.getPassword());
            ps.setString(3, st.getUserCus());

            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public Customers findCustomers(String userCus) {
        try {
            String sql = "select * from Customer where userCus=?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userCus);
            rs = ps.executeQuery();
            if (rs.next()) {
                Customers st = new Customers();
                st.setUserCus(rs.getString("userCus"));
                st.setPassword(rs.getString("password"));
                st.setFullName(rs.getString("fullName"));
                st.setBirthday(rs.getDate("birthday"));
                st.setEmail(rs.getString("email"));
                st.setPhone(rs.getString("phone"));
                st.setGender(rs.getBoolean("gender"));
                st.setAddress(rs.getString("address"));

                return st;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public String getfullName(String username) throws ClassNotFoundException {
        String email = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Customer Where userCus = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                email = rs.getString("fullName");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return email;
    }

    public boolean emailExists(String email) throws ClassNotFoundException {
        boolean exists = true;
        Connection conn = null;

        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT email FROM Customer");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String dbEmail = rs.getString("email");
                if (dbEmail.equals(email)) {
                    exists = false; // Email exists
                    break; // Exit loop early since we found the email
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return exists;
    }

    public int totalCustomer() {
        int totalCus = 0;
        String sql = "SELECT COUNT(*) AS totalCus FROM [Customer]";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                totalCus = rs.getInt("totalCus");
            }
        } catch (Exception e) {
        }
        return totalCus;
    }

    public boolean phoneExists(String phone) throws ClassNotFoundException {
        boolean exists = false;

        try {
            Connection conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT phone FROM Customer WHERE phone = ?");
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true; // Phone exists
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exists;
    }

    public ResultSet getAll() throws ClassNotFoundException {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Customer");
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int getQuantityOrderConfirm(String cus_us) throws Exception {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT count(idOrder) as count FROM [Order] WHERE userCus=? and (Confirm= 'No' or Confirm= 'onGoing')");
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
