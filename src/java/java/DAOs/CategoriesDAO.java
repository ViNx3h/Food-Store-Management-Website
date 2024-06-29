/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Categories;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class CategoriesDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Categories> getAllCategory() {
        List<Categories> list = new ArrayList<>();
        String sql = "select * from Category";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categories ca = new Categories();
                ca.setId_category(rs.getInt("id_category"));
                ca.setName_category(rs.getString("name_category"));
                ca.setImg_category(rs.getString("img_category"));
                list.add(ca);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Categories findCategory(int id_category) {
        Categories ca = null;
        String sql = "Select * from Category where id_category =? ";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id_category); // set id to find to query
            rs = ps.executeQuery();
            if (rs.next()) {
                ca = new Categories();
                ca.setId_category(rs.getInt("id_category"));
                ca.setName_category(rs.getString("name_category"));
                ca.setImg_category(rs.getString("img_category"));
            }
        } catch (Exception e) {
        }
        return ca;
    }

    public Categories CategoryId(int id) {
        try {
            String sql = "Select * from Category where id_category=? ";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Categories st = new Categories();
                st.setId_category(rs.getInt("id_category"));
                st.setName_category(rs.getString("name_category"));
                st.setImg_category(rs.getString("img_category"));
                return st;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateCategorys(Categories st) {
        String sql = "update Category set name_category=?, img_category=? where id_category=?  ";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, st.getName_category());
            ps.setString(2, st.getImg_category());

            ps.setInt(3, st.getId_category());

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void DeleteCategorys(int id) {
        String sql = "delete from Category where id_category=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public void addnewCategorys(Categories add) {
        String sql = "insert into Category values(?,?)";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setString(1, add.getName_category());
            ps.setString(2, add.getImg_category());

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ResultSet getAll() throws ClassNotFoundException {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Category");
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public ResultSet getAll(int id) throws ClassNotFoundException {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Category" + id);
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAll_exist(int id) throws ClassNotFoundException {
        ResultSet rs = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Category Where id <> ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Categories getType(int id) throws ClassNotFoundException {
        Categories Category = null;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Select * from Category Where id_category = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category = new Categories(rs.getInt("id_category"), rs.getString("name_category"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Category;
    }

    public Categories addNew(Categories newType) throws ClassNotFoundException {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("Insert into Category values (?)");
            ps.setString(1, newType.getName_category());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newType;
    }

    public boolean delete(int id) throws ClassNotFoundException {
        int count = 0;
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareCall("Delete from Category Where id_category=?");
            ps.setInt(1, id);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FoodsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count != 0);
    }

    public static void main(String[] args) {
        CategoriesDAO dao = new CategoriesDAO();
        Categories ca = dao.findCategory(1);
        System.out.println(ca);
    }

}
