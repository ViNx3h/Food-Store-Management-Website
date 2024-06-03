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

public class DBContext {

    /**
     * Connect to database by URL
     *
     * @return
     * @throws Exception
     */
//    public Connection getConnection() throws Exception {
//        String server = "DESKTOP-SU67MTK\\MSI";
//        String user = "sa";
//        String password = "123";
//        String db = "lab03";
//        int port = 1433;
//        SQLServerDataSource ds = new SQLServerDataSource();
//        ds.setUser(user);
//        ds.setPassword(password);
//        ds.setDatabaseName(db);
//        ds.setServerName(server);
//        ds.setPortNumber(port);
//        ds.setTrustServerCertificate(true);
//
//        return ds.getConnection();
//    }
    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber;
        if (instance != null && !instance.trim().isEmpty()) {
            url += "\\" + instance;
        }
        url += ";databaseName=" + dbName;

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    private final String serverName = "DESKTOP-SU67MTK\\\\MSI";
    private final String dbName = "project2";
    private final String portNumber = "1433";
    private final String instance = "";
    private final String userID = "sa";
    private final String password = "123";
}
