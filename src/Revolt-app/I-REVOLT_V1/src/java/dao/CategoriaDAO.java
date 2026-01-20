package dao;

import modelo.Categoria;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class CategoriaDAO {
    public List<Categoria> obtenerCategorias() throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categorias";
        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId(rs.getLong("id"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setEmpleadoId(rs.getLong("empleado_id"));
                categoria.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                categoria.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                categorias.add(categoria);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener categorías: " + e.getMessage(), e);
        }
        return categorias;
    }

public List<Object[]> obtenerIngresoPorCategoria(String month, String year) throws SQLException {
        List<Object[]> ingresosPorCategoria = new ArrayList<>();
        
        String sql = """
        SELECT 
            c.nombre AS categoria, 
            SUM(do.cantidad * do.precio_unitario) AS total_ingresos
        FROM 
            categorias c
        JOIN 
            productos p ON c.id = p.categoria_id
        JOIN 
            detalles_orden do ON p.id = do.producto_id
        JOIN 
            ordenes o ON do.orden_id = o.id
        WHERE 
            o.estado = 'confirmado'
            %s
        GROUP BY 
            c.nombre
        ORDER BY 
            total_ingresos DESC
        """;
        
        // Build dynamic where clause
        List<Object> params = new ArrayList<>();
        String whereClause = "";
        
        if (year != null && !year.isEmpty()) {
            whereClause += (whereClause.isEmpty() ? "" : " AND ") + "YEAR(o.actualizado_en) = ?";
            params.add(Integer.parseInt(year));
        }
        
        if (month != null && !month.isEmpty()) {
            whereClause += (whereClause.isEmpty() ? "" : " AND ") + "MONTH(o.actualizado_en) = ?";
            params.add(Integer.parseInt(month));
        }
        
        // Replace placeholder in SQL
        sql = String.format(sql, whereClause.isEmpty() ? "" : "AND " + whereClause);
        
        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Object[] categoria = new Object[2];
                    categoria[0] = rs.getString("categoria");
                    categoria[1] = rs.getDouble("total_ingresos");
                    ingresosPorCategoria.add(categoria);
                }
            }
        }
        
        return ingresosPorCategoria;
    }
    
}