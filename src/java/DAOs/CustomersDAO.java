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

    public void deleteCus(String userCus) {
        String sql = "delete from Customer where userCus = ?";

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userCus);
            ps.executeUpdate();
        } catch (Exception e) {
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

    public static void main(String[] args) {
        CustomersDAO dao = new CustomersDAO();
        Customers cus = dao.getProfileCus("toan");
        System.out.println(cus);
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

}
