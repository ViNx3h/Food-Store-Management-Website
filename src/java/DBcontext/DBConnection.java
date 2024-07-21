/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBcontext;

/**
 *
 * @author Admin
 */
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection connect() throws ClassNotFoundException, SQLException {
        //Khai bao driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        //Tao doi tuong Connection
        Connection conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-SU67MTK\\\\MSI:1433;databaseName=FoodManagement;user=sa;password=123;encrypt=true;trustServerCertificate=true;");
        return conn;
    }
}
