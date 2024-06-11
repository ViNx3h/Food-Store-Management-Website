/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Customers;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
    
}
