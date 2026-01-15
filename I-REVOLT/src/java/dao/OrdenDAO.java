package dao;

import modelo.Orden;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class OrdenDAO {

    public List<Orden> obtenerOrdenes() throws SQLException {
        List<Orden> ordenes = new ArrayList<>();
        String sql = "SELECT * FROM ordenes";

        try (Connection conn = Conexion.getConexion(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Orden orden = new Orden();
                orden.setId(rs.getLong("id"));
                orden.setClienteId(rs.getLong("cliente_id"));
                orden.setFecha(rs.getObject("fecha", OffsetDateTime.class));
                orden.setTotal(rs.getDouble("total"));
                orden.setEstado(rs.getString("estado"));
                orden.setMetodoPagoId(rs.getLong("metodo_pago_id"));
                orden.setPasarelaPagoId(rs.getLong("pasarela_pago_id"));
                orden.setFacturacionId(rs.getLong("facturacion_id"));
                orden.setTarjetaId(rs.getLong("tarjeta_id"));
                orden.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                orden.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                ordenes.add(orden);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener órdenes: " + e.getMessage(), e);
        }

        return ordenes;
    }
    
    
    
    /////
    
    public List<String> obtenerCategoriasConIngresos() throws SQLException {
        List<String> categorias = new ArrayList<>();
        String sql = "SELECT DISTINCT c.nombre " +
                     "FROM categorias c " +
                     "JOIN productos p ON c.id = p.categoria_id " +
                     "JOIN detalles_orden do ON p.id = do.producto_id " +
                     "JOIN ordenes o ON do.orden_id = o.id " +
                     "WHERE o.estado = 'confirmado'";
        
        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                categorias.add(rs.getString("nombre"));
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener categorías con ingresos: " + e.getMessage(), e);
        }
        return categorias;
    }

    public List<Double> obtenerIngresoPorCategoria(String categoria) throws SQLException {
        List<Double> ingresos = new ArrayList<>();
        String sql = "SELECT " +
                     "SUM(do.cantidad * do.precio_unitario) AS total_ingreso, " +
                     "DATEPART(dw, o.fecha) AS dia_semana " +
                     "FROM ordenes o " +
                     "JOIN detalles_orden do ON o.id = do.orden_id " +
                     "JOIN productos p ON do.producto_id = p.id " +
                     "JOIN categorias c ON p.categoria_id = c.id " +
                     "WHERE o.estado = 'confirmado' AND c.nombre = ? " +
                     "GROUP BY DATEPART(dw, o.fecha) " +
                     "ORDER BY dia_semana";
        
        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, categoria);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                // Preparar un array para 7 días de la semana, inicializado con 0
                double[] ingresosArray = new double[7];
                
                while (rs.next()) {
                    int diaSemana = rs.getInt("dia_semana");
                    double ingreso = rs.getDouble("total_ingreso");
                    // SQL devuelve días de 1 (domingo) a 7 (sábado), ajustar al índice del array
                    int indice = (diaSemana + 5) % 7;
                    ingresosArray[indice] = ingreso;
                }
                
                // Convertir array a lista para retornar
                for (double ingreso : ingresosArray) {
                    ingresos.add(ingreso);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener ingresos por categoría: " + e.getMessage(), e);
        }
        return ingresos;
    }
    
}
