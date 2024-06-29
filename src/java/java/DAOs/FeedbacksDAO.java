/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBcontext.DBConnection;
import Models.Bills;
import Models.Employees;
import Models.Feedbacks;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.catalina.Session;

/**
 *
 * @author VINH
 */
public class FeedbacksDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public FeedbacksDAO() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(BillsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Feedbacks addNew(Feedbacks newFeedBack) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Feedback values (?,?,GETDATE(),?,?)");
            ps.setString(1, newFeedBack.getUserCus());
            ps.setInt(2, newFeedBack.getIdFood());
            ps.setString(3, newFeedBack.getFeedback());
            ps.setDouble(4, newFeedBack.getRating());

            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbacksDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (count == 0) ? null : newFeedBack;
    }

    public double getRatingAvg(int id) {
        double average_rating = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT AVG(rating) AS average_rating FROM Feedback WHERE idFood = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                average_rating = rs.getDouble("average_rating");
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbacksDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return average_rating;
    }

    public ResultSet getAll(int id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Feedback WHERE idFood = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbacksDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

}
