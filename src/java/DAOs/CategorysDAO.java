/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBcontext.DBContext;
import Models.Categorys;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

/**
 *
 * @author ADMIN
 */
public class CategorysDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Categorys> getAllCategory() {
        List<Categorys> list = new ArrayList<>();
        String sql = "select * from Category";
        try {
            DBContext db = new DBContext();
            conn = db.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categorys ca = new Categorys();
                ca.setId_category(rs.getInt("id_category"));
                ca.setName_category(rs.getString("name_category"));
                ca.setImg_category(rs.getString("img_category"));
                list.add(ca);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        CategorysDAO dao = new CategorysDAO();
        List<Categorys> categories = dao.getAllCategory();
        System.out.println(categories);
    }
}
