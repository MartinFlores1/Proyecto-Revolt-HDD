package dao;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TotalOrdersDAO {
    public int getTotalOrdenesMensuales(String month, String year) {
        int totalOrdenes = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = Conexion.getConexion(); // Usa tu método específico de conexión
            StringBuilder queryBuilder = new StringBuilder(
                "SELECT " +
                "    COUNT(o.id) AS total_ordenes " +
                "FROM " +
                "    ordenes o " +
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
                totalOrdenes = rs.getInt("total_ordenes");
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener total de órdenes mensuales: " + e.getMessage());
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

        return totalOrdenes;
    }
}