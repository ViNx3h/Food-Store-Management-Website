/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Admin;
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
public class AdminDAO {

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

    public List<Admin> checkLogin(String user, String pass) {

        List<Admin> list = new ArrayList<>();
        try {
            String sql = "select * from Admin where userAdmin=? and password=?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                Admin a = new Admin();
                a.setUserAdmin(rs.getString("userAdmin"));
                a.setPassword(rs.getString("password"));
                list.add(a);
            }

        } catch (Exception e) {
        }

        return list;
    }

    public Admin getProfileAdmin(String username) {
        Admin em = new Admin();
        try {
            String sql = "select * from Admin where userAdmin = '" + username + "'";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                em.setUserAdmin(rs.getString("userAdmin"));
                em.setPassword(rs.getString("password"));
                em.setFullName(rs.getString("fullName"));
                em.setBirthday(rs.getDate("birthday"));
                em.setEmail(rs.getString("email"));
                em.setPhone(rs.getString("phone"));
                em.setGender(rs.getBoolean("gender"));
                em.setAddress(rs.getString("address"));
                em.setImg(rs.getString("img"));
            }
        } catch (Exception e) {

        }
        return em;
    }

    public static void main(String[] args) {
        AdminDAO dao = new AdminDAO();
        List<Admin> a = dao.checkLogin("toan", "e10adc3949ba59abbe56e057f20f883e");
        if (a.isEmpty()) {
            System.out.println("a");
        }
    }
}
