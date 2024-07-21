/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.EditingDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class EditingDetailDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<EditingDetail> getAllEditingDetail() {
        List<EditingDetail> list = new ArrayList<>();
        String sql = "select * from EditingDetail";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                EditingDetail ed = new EditingDetail();
                ed.setUserEmployee(rs.getString("userEmployee"));
                ed.setIdFood(rs.getInt("idFood"));
                ed.setAdd_food(rs.getString("add_food"));
                ed.setDelete_food(rs.getString("delete_food"));
                ed.setUpdate_food(rs.getString("update_food"));
                ed.setDate_editing(rs.getDate("date_editing"));
                list.add(ed);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void deleteEditingDetail(String userEmployee) {
        String sql = "delete from EditingDetail where userEmployee=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            rs = ps.executeQuery();
        } catch (Exception e) {
        }
    }
}
