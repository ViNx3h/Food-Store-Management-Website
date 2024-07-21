/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Employees;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import DAOs.EditingDetailDAO;
import com.oracle.wls.shaded.org.apache.bcel.generic.AALOAD;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class EmployeesDAO {

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

    public List<Employees> checkLogin(String user, String pass) {

        List<Employees> list = new ArrayList<>();
        try {
            String sql = "select * from Employee where userEmployee=? and password=?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                Employees a = new Employees();
                a.setUserEmployee(rs.getString("userEmployee"));
                a.setPassword(rs.getString("password"));
                list.add(a);
            }

        } catch (Exception e) {
        }

        return list;
    }

    public void detailAdd(String userEmployee, int idFood, int price, String pic, String description, int id_category, int quantity) {
        String sql = "INSERT INTO EditingDetail "
                + "(userEmployee, idFood, add_food, delete_food, update_food, date_editing) "
                + "VALUES (?,?,?,?,?,?)";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            ps.setInt(2, idFood);
            String detailAdd = "Price: " + price + ""
                    + " Picture: " + pic + ""
                    + " Description: " + description + " "
                    + " Id_category: " + id_category + ""
                    + " Quantity: " + quantity;
            ps.setString(3, detailAdd);
            ps.setString(4, "");
            ps.setString(5, "");
            // Lấy ngày hiện tại và chuyển đổi sang java.sql.Date
            LocalDate today = LocalDate.now();
            Date sqlDate = Date.valueOf(today);

            // Thiết lập tham số ngày
            ps.setDate(6, sqlDate);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public void detailDelete(String userEmployee, int idFood) {
        String sql = "INSERT INTO EditingDetail "
                + "(userEmployee, idFood, add_food, delete_food, update_food, date_editing) "
                + "VALUES (?,?,?,?,?,?)";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            ps.setInt(2, idFood);
            ps.setString(3, "");
            ps.setString(4, "Delete Food by id = " + idFood);
            ps.setString(5, "");
            // Lấy ngày hiện tại và chuyển đổi sang java.sql.Date
            LocalDate today = LocalDate.now();
            Date sqlDate = Date.valueOf(today);

            // Thiết lập tham số ngày
            ps.setDate(6, sqlDate);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void detailUpdate(String userEmployee, int idFood, int price, String pic, String description, int id_category, int quantity) {

        String sql = "INSERT INTO EditingDetail "
                + "(userEmployee, idFood, add_food, delete_food, update_food, date_editing) "
                + "VALUES (?,?,?,?,?,?)";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            ps.setInt(2, idFood);
            String detailUpdate = "Price: " + price + ""
                    + " Picture: " + pic + ""
                    + " Description: " + description + " "
                    + " Id_category: " + id_category + ""
                    + " Quantity: " + quantity;
            ps.setString(3, "");
            ps.setString(4, "");
            ps.setString(5, detailUpdate);
            // Lấy ngày hiện tại và chuyển đổi sang java.sql.Date
            LocalDate today = LocalDate.now();
            Date sqlDate = Date.valueOf(today);
            // Thiết lập tham số ngày
            ps.setDate(6, sqlDate);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public List<Employees> getAllEmployees() {
        List<Employees> list = new ArrayList<>();
        try {
            String sql = "select * from Employee";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Employees st = new Employees();
                st.setUserEmployee(rs.getString("userEmployee"));
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

    public void deleteEm(String userEmployee) {
        String sql = "delete from Employee where userEmployee=?";
        try {
            WorkingSchedulesDAO wdao = new WorkingSchedulesDAO();
            wdao.deleteWorkingScheduleEm(userEmployee);
            EditingDetailDAO dao = new EditingDetailDAO();
            dao.deleteEditingDetail(userEmployee);
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            rs = ps.executeQuery();
        } catch (Exception e) {
        }
    }

    public Employees findEmbyUser(String userEmployee) {
        try {
            String sql = "select * from Employee where userEmployee=?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            rs = ps.executeQuery();
            if (rs.next()) {
                Employees st = new Employees();
                st.setUserEmployee(rs.getString("userEmployee"));
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

    public void addnewEm(Employees add) {
        String sql = "insert into Employee values(?,?,?,?,?,?,?,?,?)";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, add.getUserEmployee());
            ps.setString(2, add.getPassword());
            ps.setString(3, add.getFullName());
            ps.setDate(4, add.getBirthday());
            ps.setString(5, add.getEmail());
            ps.setString(6, add.getPhone());
            ps.setBoolean(7, add.isGender());
            ps.setString(8, add.getAddress());
            ps.setString(9, add.getImg());

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Employees getProfileEm(String username) {
        Employees em = new Employees();
        try {
            String sql = "select * from Employee where userEmployee = '" + username + "'";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                em.setUserEmployee(rs.getString("userEmployee"));
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

    public void ChangePassEm(Employees st) {
        String sql = "update Employee set userEmployee = ?, password=? where userEmployee=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, st.getUserEmployee());
            ps.setString(2, st.getPassword());
            ps.setString(3, st.getUserEmployee());

            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        EmployeesDAO dao = new EmployeesDAO();
        dao.detailUpdate("toan", 1, 20000, "img/m.jpg", "ngon", 2, 21);
    }

    public void updateEmployee(Employees st) {
        String sql = "update Employee set userEmployee=?, password=?,fullName=?, birthday=?, email=?, phone=?, gender=?, address=?, img=? where userEmployee=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, st.getUserEmployee());
            ps.setString(2, st.getPassword());
            ps.setString(3, st.getFullName());
            ps.setDate(4, st.getBirthday());
            ps.setString(5, st.getEmail());
            ps.setString(6, st.getPhone());
            ps.setBoolean(7, st.isGender());
            ps.setString(8, st.getAddress());
            ps.setString(9, st.getImg());
            ps.setString(10, st.getUserEmployee());
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public ResultSet getUserEmployees() {
        String selectSql = "SELECT userEmployee FROM Employee";
        ResultSet rs = null;

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(selectSql);
            rs = ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }

    public void closeConnection() {
        try {
            if (rs != null) {
                rs.close();
            }
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

    public boolean emailExists(String email) throws ClassNotFoundException, SQLException {
        boolean exists = false;
        try {
            Connection conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT email FROM Employee WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true; // Email exists
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exists;
    }

    public boolean usernameExists(String username) throws ClassNotFoundException {
        boolean exists = false;

        try {
            Connection conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT userEmployee FROM Employee WHERE userEmployee = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true; // Username exists
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exists;
    }

    public boolean phoneExists(String phone) throws ClassNotFoundException {
        boolean exists = false;

        try {
            Connection conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT phone FROM Employee WHERE phone = ?");
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

    public String getEmail(String username) throws ClassNotFoundException {
        String email = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select email from Employee Where userEmployee = ?");
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

    public void ChangePassEmployee(String newPass, String username) {
        String sql = "update Employee set password=? where userEmployee=?";
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
