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

    public void updateAdmin(Admin st) {
        String sql = "update Admin set userAdmin=?, password=?,fullName=?, birthday=?, email=?, phone=?, gender=?, address=?, img=? where userAdmin=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, st.getUserAdmin());
            ps.setString(2, st.getPassword());
            ps.setString(3, st.getFullName());
            ps.setDate(4, st.getBirthday());
            ps.setString(5, st.getEmail());
            ps.setString(6, st.getPhone());
            ps.setBoolean(7, st.isGender());
            ps.setString(8, st.getAddress());
            ps.setString(9, st.getImg());
            ps.setString(10, st.getUserAdmin());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void ChangePassAdmin(Admin st) {
        String sql = "update Admin set userAdmin = ?, password=? where userAdmin=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, st.getUserAdmin());
            ps.setString(2, st.getPassword());
            ps.setString(3, st.getUserAdmin());

            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public Admin findAdmin(String userAdmin) {
        try {
            String sql = "select * from Admin where userAdmin=?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userAdmin);
            rs = ps.executeQuery();
            if (rs.next()) {
                Admin st = new Admin();
                st.setUserAdmin(rs.getString("userAdmin"));
                st.setPassword(rs.getString("password"));
                st.setFullName(rs.getString("fullName"));
                st.setBirthday(rs.getDate("birthday"));
                st.setEmail(rs.getString("email"));
                st.setPhone(rs.getString("phone"));
                st.setGender(rs.getBoolean("gender"));
                st.setAddress(rs.getString("address"));
                st.setImg(rs.getString("img"));

                return st;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        AdminDAO dao = new AdminDAO();
        List<Admin> a = dao.checkLogin("toan", "e10adc3949ba59abbe56e057f20f883e");
        if (a.isEmpty()) {
            System.out.println("a");
        }
    }

}
