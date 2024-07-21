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
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

    public ResultSet getAll(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Feedback WHERE userCus = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbacksDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public double getRatingOfFood(String username, int id_pro) {
        double rating = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT rating FROM Feedback WHERE userCus = ? AND idFood = ?");
            ps.setString(1, username);
            ps.setInt(2, id_pro);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rating = rs.getDouble("rating");
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbacksDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return rating;
    }

    public boolean existFeedback(String cus_us, int pro_id) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Feedback WHERE userCus=? AND idFood=?");
            ps.setString(1, cus_us);
            ps.setInt(2, pro_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void updateRating(double rating, String content, String cus_us, int pro_id) throws Exception {
        try {
            conn = DBcontext.DBConnection.connect();
            PreparedStatement ps = conn.prepareCall("update Feedback set rating = ? , feedback = ? Where userCus=? and idFood=?");
            ps.setDouble(1, rating);
            ps.setString(2, content);
            ps.setString(3, cus_us);
            ps.setInt(4, pro_id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int totalFeedback() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM [Feedback]";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
        }
        return total;
    }

    public double[] getAverageRatingFor12Months() {
        double[] averageRatingArray = new double[12];

        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        for (int month = 1; month <= 12; month++) {
            calendar.set(Calendar.MONTH, month - 1);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            String startDate = dateFormat.format(calendar.getTime());
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            String endDate = dateFormat.format(calendar.getTime());

            String sql = "SELECT AVG(rating) AS avgRating "
                    + "FROM Feedback "
                    + "WHERE MONTH(dateFeedback) = ?";

            try {
                Connection conn = DBcontext.DBConnection.connect(); // Đảm bảo khởi tạo kết nối đến cơ sở dữ liệu
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, month);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    double avgRating = rs.getDouble("avgRating");
                    averageRatingArray[month - 1] = avgRating;
                } else {
                    averageRatingArray[month - 1] = 0; // Đặt giá trị 0 nếu không có dữ liệu đánh giá cho tháng này
                }
                // Đóng các đối tượng ResultSet, PreparedStatement và Connection để giải phóng tài nguyên
                rs.close();
                ps.close();
                conn.close();
            } catch (SQLException | ClassNotFoundException e) {
                // Xử lý ngoại lệ nếu có
                e.printStackTrace();
            }
        }

        return averageRatingArray;
    }

    public static void main(String[] args) {
        FeedbacksDAO a = new FeedbacksDAO();
        double[] f = a.getAverageRatingFor12Months();
        System.out.println(f);
    }

}
