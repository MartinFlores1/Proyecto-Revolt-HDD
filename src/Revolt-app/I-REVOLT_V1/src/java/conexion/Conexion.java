package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    public static Connection getConexion() throws SQLException {
        String conexionUrl = "jdbc:sqlserver://localhost:1433;"
                + "databaseName=BD_Shopping;"
                + "user=sa;"
                + "password=12345678;"
                + "encrypt=true;"
                + "trustServerCertificate=true;"
                + "loginTimeout=30;";

        try {
            // Cargar el driver de SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // Intentar establecer la conexión
            Connection con = DriverManager.getConnection(conexionUrl);
            
            if (con == null) {
                throw new SQLException("La conexión no pudo ser establecida.");
            }
            
            return con;
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se pudo cargar el driver de SQL Server.", e);
        } catch (SQLException e) {
            throw new SQLException("Error al conectar a la base de datos: " + e.getMessage(), e);
        }
    }

}