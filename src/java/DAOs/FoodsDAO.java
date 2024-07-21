/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Categories;
import Models.Foods;
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
public class FoodsDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    //show list food by type
    public List<Foods> getAllFoodsbyCategory(int id) {
        List<Foods> list = new ArrayList<>();
        String sql = "select * from Food where id_category=" + id + " and status = 'true' and quantity > 0";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f = new Foods();
                f.setIdFood(rs.getInt("idFood"));
                f.setName_food(rs.getString("name_food"));
                f.setPrice(rs.getInt("price"));
                f.setQuantity(rs.getInt("quantity"));
                f.setPic(rs.getString("pic"));
                f.setDescription(rs.getString("description"));
                list.add(f);
            }
        } catch (Exception e) {
        }
        return list;
    }

    //Search food by like name
    public List<Foods> searchFoods(String name) {
        List<Foods> search = new ArrayList<>();
        String sql = "select * from Food where name_food like '%" + name + "%' and status = 'true' and quantity >0 ";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f1 = new Foods();
                f1.setIdFood(rs.getInt("idFood"));
                f1.setName_food(rs.getString("name_food"));
                f1.setPrice(rs.getInt("price"));
                f1.setQuantity(rs.getInt("quantity"));
                f1.setPic(rs.getString("pic"));
                f1.setDescription(rs.getString("description"));
                search.add(f1);
            }
        } catch (Exception e) {
        }

        return search;
    }

    //show list food by type
    public List<Foods> getAllFoods() {
        List<Foods> list = new ArrayList<>();
        String sql = "select * from Food";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f = new Foods();
                f.setIdFood(rs.getInt("idFood"));
                f.setName_food(rs.getString("name_food"));
                f.setPrice(rs.getInt("price"));
                f.setQuantity(rs.getInt("quantity"));
                f.setPic(rs.getString("pic"));
                f.setDescription(rs.getString("description"));
                f.setStatus(rs.getBoolean("status"));
                f.setId_category(rs.getInt("id_category"));
                list.add(f);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Foods findFoodsById(int idFood) {
        Foods f = null;
        String sql = "Select * from Food where idFood = " + idFood + "";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                f = new Foods();
                f.setIdFood(rs.getInt("idFood"));
                f.setName_food(rs.getString("name_food"));
                f.setPrice(rs.getInt("price"));
                f.setQuantity(rs.getInt("quantity"));
                f.setPic(rs.getString("pic"));
                f.setDescription(rs.getString("description"));
                f.setStatus(rs.getBoolean("status"));
                f.setId_category(rs.getInt("id_category"));
            }
        } catch (Exception e) {
        }
        return f;
    }

    public void addNewFood(Foods f) {
        String sql = "insert into Food values (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, f.getIdFood());
            ps.setString(2, f.getName_food());
            ps.setInt(3, f.getPrice());
            ps.setInt(4, f.getQuantity());
            ps.setString(5, f.getPic());
            ps.setString(6, f.getDescription());
            ps.setBoolean(7, f.getStatus());
            ps.setInt(8, f.getId_category());

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteFood(int idFood) {
        String sql = "delete from Food where idFood = " + idFood + "";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateFood(Foods f) {
        String sql = "UPDATE Food SET name_food = ?, price = ?, quantity = ?, pic = ?, description = ?, status = ?, id_category = ? WHERE idFood = ?";

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, f.getName_food());
            ps.setInt(2, f.getPrice());
            ps.setInt(3, f.getQuantity());
            ps.setString(4, f.getPic());
            ps.setString(5, f.getDescription());
            ps.setBoolean(6, f.getStatus());
            ps.setInt(7, f.getId_category());
            ps.setInt(8, f.getIdFood());
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public Foods getProduct(int pro_id) throws Exception {
        Foods pro = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Food Where idFood = ?");
            ps.setInt(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pro = new Foods(rs.getInt("idFood"), rs.getString("name_food"), rs.getInt("price"), rs.getInt("quantity"), rs.getString("pic"), rs.getString("description"), rs.getBoolean("status"), rs.getInt("id_category"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public ResultSet getAll(int type_id) throws Exception {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Food where idFood = " + type_id);
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAll() throws Exception {
        ResultSet rs = null;
        try {

            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Food");
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllCategory() throws Exception {
        ResultSet rs = null;
        try {

            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Category");
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getTop4(int type_id) throws Exception {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select top 4 * from Food where id_category = " + type_id + "AND quantity > 0 and status = 1");
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public List<Foods> adminSearchFoodbyName(String query) {
        List<Foods> search = new ArrayList<>();
        String sql = "select * from Food where name_food like '%" + query + "%'";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f1 = new Foods();
                f1.setIdFood(rs.getInt("idFood"));
                f1.setName_food(rs.getString("name_food"));
                f1.setPrice(rs.getInt("price"));
                f1.setQuantity(rs.getInt("quantity"));
                f1.setPic(rs.getString("pic"));
                f1.setDescription(rs.getString("description"));
                f1.setStatus(rs.getBoolean("status"));
                f1.setId_category(rs.getInt("id_category"));
                search.add(f1);
            }
        } catch (Exception e) {
        }
        return search;
    }

    public List<Foods> adminSearchFoodbyCategory(String query) {
        List<Foods> search = new ArrayList<>();
        String sql = "select * from Food f join Category c \n"
                + "ON f.id_category = c.id_category\n"
                + "where c.name_category like '%" + query + "%'";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f1 = new Foods();
                f1.setIdFood(rs.getInt("idFood"));
                f1.setName_food(rs.getString("name_food"));
                f1.setPrice(rs.getInt("price"));
                f1.setQuantity(rs.getInt("quantity"));
                f1.setPic(rs.getString("pic"));
                f1.setDescription(rs.getString("description"));
                f1.setStatus(rs.getBoolean("status"));
                f1.setId_category(rs.getInt("id_category"));
                search.add(f1);
            }
        } catch (Exception e) {
        }
        return search;
    }

    public List<Foods> employeeSearchFoodbyName(String query) {
        List<Foods> search = new ArrayList<>();
        String sql = "select * from Food where name_food like '%" + query + "%'";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f1 = new Foods();
                f1.setIdFood(rs.getInt("idFood"));
                f1.setName_food(rs.getString("name_food"));
                f1.setPrice(rs.getInt("price"));
                f1.setQuantity(rs.getInt("quantity"));
                f1.setPic(rs.getString("pic"));
                f1.setDescription(rs.getString("description"));
                f1.setStatus(rs.getBoolean("status"));
                f1.setId_category(rs.getInt("id_category"));
                search.add(f1);
            }
        } catch (Exception e) {
        }
        return search;
    }

    public List<Foods> employeeSearchFoodbyCategory(String query) {
        List<Foods> search = new ArrayList<>();
        String sql = "select * from Food f join Category c \n"
                + "ON f.id_category = c.id_category\n"
                + "where c.name_category like '%" + query + "%'";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f1 = new Foods();
                f1.setIdFood(rs.getInt("idFood"));
                f1.setName_food(rs.getString("name_food"));
                f1.setPrice(rs.getInt("price"));
                f1.setQuantity(rs.getInt("quantity"));
                f1.setPic(rs.getString("pic"));
                f1.setDescription(rs.getString("description"));
                f1.setStatus(rs.getBoolean("status"));
                f1.setId_category(rs.getInt("id_category"));
                search.add(f1);
            }
        } catch (Exception e) {
        }
        return search;
    }

    public Foods updateQuantity(int pro_id, int newQuantity) {
        Foods pro = null;
        try {
            PreparedStatement ps = conn.prepareStatement("Update Food Set quantity = ? Where idFood = ?");
            ps.setInt(1, newQuantity);
            ps.setInt(2, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pro = new Foods(rs.getInt("idFood"), rs.getString("name_food"), rs.getInt("price"), rs.getInt("quantity"), rs.getString("pic"), rs.getString("description"), rs.getBoolean("status"), rs.getInt("id_category"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public int getFoodById(int pro_id) throws Exception {
        int pro = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Food Where idFood = ?");
            ps.setInt(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pro = rs.getInt("idFood");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public int getCategoryById(int id) {
        int value = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Select * from Food where idFood = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                value = rs.getInt("id_category");
            }
        } catch (Exception e) {
        }
        return value;
    }

    public ResultSet getAllByCategory(int type_id) throws Exception {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Food where id_category = " + type_id);
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public String getNameFoodById(int pro_id) throws Exception {
        String name = "";
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select name_food from Food Where idFood = ?");
            ps.setInt(1, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name_food");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return name;
    }

    public boolean foodExists(int id_category) throws ClassNotFoundException {
        boolean exists = false;

        try {
            Connection conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT idFood FROM Food WHERE id_category = ?");
            ps.setInt(1, id_category);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true; // Phone exists
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exists;
    }

    public static void main(String[] args) {
        FoodsDAO dao = new FoodsDAO();
        List<Foods> f = dao.employeeSearchFoodbyCategory("a");
        System.out.println(f);
    }

}
