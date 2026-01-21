package dao;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class IngresoMesDAO {
    public List<Double> getIngresoMensual(String monthParam, String yearParam) {
        List<Double> revenues = new ArrayList<>(12);
        
        // Initialize the list with zeros
        for (int i = 0; i < 12; i++) {
            revenues.add(0.0);
        }
        
        try (Connection conn = Conexion.getConexion()) {
            // Dynamic SQL with optional filtering
            String sql = """
            SELECT 
                MONTH(o.actualizado_en) as mes, 
                SUM(do.cantidad * do.precio_unitario) as total_ingresos
            FROM 
                ordenes o
            JOIN 
                detalles_orden do ON o.id = do.orden_id
            WHERE 
                o.estado = 'confirmado'
            %s
            GROUP BY 
                MONTH(o.actualizado_en)
            """;
            
            // Build dynamic where clause based on parameters
            List<Object> params = new ArrayList<>();
            String whereClause = "";
            if (yearParam != null && !yearParam.isEmpty()) {
                whereClause += " AND YEAR(o.actualizado_en) = ?";
                params.add(Integer.parseInt(yearParam));
            }
            if (monthParam != null && !monthParam.isEmpty()) {
                whereClause += " AND MONTH(o.actualizado_en) = ?";
                params.add(Integer.parseInt(monthParam));
            }
            
            sql = String.format(sql, whereClause);
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                // Set parameters
                for (int i = 0; i < params.size(); i++) {
                    pstmt.setObject(i + 1, params.get(i));
                }
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        int mes = rs.getInt("mes");
                        double totalIngresos = rs.getDouble("total_ingresos");
                        // Adjust for zero-based index
                        revenues.set(mes - 1, totalIngresos);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return revenues;
    }
    
    
}