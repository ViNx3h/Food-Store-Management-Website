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
import DBcontext.DBContext;

/**
 *
 * @author ADMIN
 */
public class AdminDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * Dung de Hash md5 mat khau
     *
     * @param password la mat khau nhap vao
     * @return mat khau da hashed
     */
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

    public Admin checkLogin(String user, String pass) {
        try {
            String sql = "select * from Admin where userAdmin=? and password=?";
            DBContext db = new DBContext();
            conn = db.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
        } catch (Exception e) {
        }

        return null;
    }
}
