package dao;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TotalRevenueDAO {

    public double getTotalIngresoMensual(String month, String year) {
        double totalRevenue = 0.0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConexion(); // Usa tu método específico de conexión

            StringBuilder queryBuilder = new StringBuilder(
                "SELECT " +
                "    SUM(do.cantidad * do.precio_unitario) AS total_revenue " +
                "FROM " +
                "    ordenes o " +
                "JOIN " +
                "    detalles_orden do ON o.id = do.orden_id " +
                "WHERE " +
                "    o.estado = 'confirmado'"
            );

            // Agregar condiciones dinámicas
            if (month != null && !month.equals("default")) {
                queryBuilder.append(" AND MONTH(o.actualizado_en) = ?");
            }

            if (year != null && !year.equals("default")) {
                queryBuilder.append(" AND YEAR(o.actualizado_en) = ?");
            }

            pstmt = conn.prepareStatement(queryBuilder.toString());

            // Establecer parámetros
            int paramIndex = 1;
            if (month != null && !month.equals("default")) {
                pstmt.setInt(paramIndex++, Integer.parseInt(month));
            }

            if (year != null && !year.equals("default")) {
                pstmt.setInt(paramIndex++, Integer.parseInt(year));
            }

            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getDouble("total_revenue");
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener ingresos mensuales: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        return totalRevenue;
    }
}
