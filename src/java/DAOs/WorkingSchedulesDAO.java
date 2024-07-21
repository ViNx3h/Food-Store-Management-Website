/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import static DBcontext.DBConnection.connect;
import Models.WorkingSchedule;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author lecon
 */
public class WorkingSchedulesDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    private PreparedStatement ps2;

    public List<WorkingSchedule> getAllWorkingSchedule() {
        List<WorkingSchedule> list = new ArrayList<>();
        try {
            String sql = "select * from WorkingSchedule";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                WorkingSchedule st = new WorkingSchedule();
                st.setId(rs.getInt("id"));
                st.setUserEmployee(rs.getString("userEmployee"));
                st.setFullName(rs.getString("fullName"));
                st.setDay(rs.getDate("day"));
                st.setTime(rs.getString("time"));
                list.add(st);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<WorkingSchedule> EmWorkingSchedule(String username) throws ClassNotFoundException {
        List<WorkingSchedule> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM WorkingSchedule WHERE userEmployee = ?";
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            rs = ps.executeQuery();

            while (rs.next()) {
                WorkingSchedule st = new WorkingSchedule();
                st.setId(rs.getInt("id"));
                st.setUserEmployee(rs.getString("userEmployee"));
                st.setFullName(rs.getString("fullName"));
                st.setDay(rs.getDate("day"));
                st.setTime(rs.getString("time"));
                list.add(st);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Ensure resources are closed
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
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return list;
    }

    public WorkingSchedule findEmployee(int id) {
        WorkingSchedule st = null;
        String sql = "Select * from WorkingSchedule where id =? ";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id); // set id to find to query
            rs = ps.executeQuery();
            if (rs.next()) {
                st = new WorkingSchedule();
                st.setId(rs.getInt("id"));
                st.setUserEmployee(rs.getString("userEmployee"));
                st.setFullName(rs.getString("fullName"));
                st.setDay(rs.getDate("day"));
                st.setTime(rs.getString("time"));
            }
        } catch (Exception e) {
        }
        return st;
    }

    public void updateWorkingSchedulebyEm(WorkingSchedule st) {
        String sql = "update WorkingSchedule set id=?, userEmployee=?, fullName=?, day=?, time=? where id=?  ";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, st.getId());
            ps.setString(2, st.getUserEmployee());
            ps.setString(3, st.getFullName());
            ps.setDate(4, st.getDay());
            ps.setString(5, st.getTime());
            ps.setInt(6, st.getId());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateWorkingSchedule(WorkingSchedule st) {
        String sql = "update WorkingSchedule set id=?, userEmployee=?, fullName=?, day=?, time=? where id=?  ";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, st.getId());
            ps.setString(2, st.getUserEmployee());
            ps.setString(3, st.getFullName());
            ps.setDate(4, st.getDay());
            ps.setString(5, st.getTime());
            ps.setInt(6, st.getId());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public String getFullName(String userEmployee) {
        String fullName = null;
        String sql = "SELECT fullName FROM Employee WHERE userEmployee = ?";
        try {

            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            rs = ps.executeQuery();

            if (rs.next()) {
                fullName = rs.getString("fullName");
            }
            return fullName;
        } catch (Exception e) {
        }
        return fullName;
    }

    public String getUserEmployee(String userEmployee) {
        String user = null;
        String sql = "SELECT userEmployee FROM Employee WHERE userEmployee = ?";
        try {

            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = rs.getString("userEmployee");
            }
            return user;
        } catch (Exception e) {
        }
        return user;
    }

    public void DeleteSchedule(int id) {
        String deleteSql = "DELETE FROM WorkingSchedule WHERE id=?";
        String selectSql = "SELECT id FROM WorkingSchedule ORDER BY id";
        String updateSql = "UPDATE WorkingSchedule SET id = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.DBConnection.connect();

            // Delete the schedule with the specified ID
            ps = conn.prepareStatement(deleteSql);
            ps.setInt(1, id);
            ps.executeUpdate();

            // Retrieve all records ordered by current id
            ps = conn.prepareStatement(selectSql);
            rs = ps.executeQuery();

            int newId = 1;
            while (rs.next()) {
                int currentId = rs.getInt("id");

                // Update each record with a new sequential id
                ps2 = conn.prepareStatement(updateSql);
                ps2.setInt(1, newId);
                ps2.setInt(2, currentId);
                ps2.executeUpdate();

                newId++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void addnewSchedule(WorkingSchedule schedule) {
        String insertSql = "INSERT INTO WorkingSchedule (id, userEmployee, fullname, day, time) VALUES (?, ?, ?, ?, ?)";

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(insertSql);
            ps.setInt(1, schedule.getId());
            ps.setString(2, schedule.getUserEmployee());
            ps.setString(3, schedule.getFullName());
            ps.setDate(4, schedule.getDay());
            ps.setString(5, schedule.getTime());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
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
    }

    // Method to reorder IDs
    public void reorderIds() {
        String selectSql = "SELECT id FROM WorkingSchedule ORDER BY id";
        String updateSql = "UPDATE WorkingSchedule SET id = ? WHERE id = ?";

        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(selectSql);
            rs = ps.executeQuery();

            int newId = 1;
            while (rs.next()) {
                int currentId = rs.getInt("id");

                ps2 = conn.prepareStatement(updateSql);
                ps2.setInt(1, newId);
                ps2.setInt(2, currentId);
                ps2.executeUpdate();

                newId++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public ResultSet getUserEmployee() throws ClassNotFoundException {
        try {
            conn = DBcontext.DBConnection.connect();
            if (conn != null) {
                String sql = "SELECT *userEmployee FROM Employee";
                PreparedStatement ps = conn.prepareStatement(sql);
                return ps.executeQuery();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if connection fails or query fails
    }

    void deleteWorkingScheduleEm(String userEmployee) {
        String sql = "delete from WorkingSchedule where userEmployee=?";
        try {
            conn = DBcontext.DBConnection.connect();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmployee);
            rs = ps.executeQuery();
        } catch (Exception e) {
        }
    }

}
