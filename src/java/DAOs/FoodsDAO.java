/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBcontext.DBContext;
import Models.Categorys;
import Models.Foods;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class FoodsDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Foods> getAllFoods(String id) {
        List<Foods> list = new ArrayList<>();
        String sql = "select * from Food where id_category=" + id + " and status = 'true'";
        try {
            DBContext db = new DBContext();
            conn = db.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Foods f = new Foods();
                f.setIdFood(rs.getString("id_category"));
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

    public static void main(String[] args) {
        FoodsDAO dao = new FoodsDAO();
        List<Foods> f = dao.getAllFoods("1");
        System.out.println(f);
    }
}
