package dao;

import modelo.DetalleOrden;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetalleOrdenDAO {

    public List<DetalleOrden> obtenerDetallesOrden() throws SQLException {
        List<DetalleOrden> detalles = new ArrayList<>();
        String sql = "SELECT * FROM detalles_orden";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                DetalleOrden detalle = new DetalleOrden();
                detalle.setId(rs.getLong("id"));
                detalle.setOrdenId(rs.getLong("orden_id"));
                detalle.setProductoId(rs.getLong("producto_id"));
                detalle.setCantidad(rs.getInt("cantidad"));
                detalle.setPrecioUnitario(rs.getDouble("precio_unitario"));
                detalles.add(detalle);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener detalles de órdenes: " + e.getMessage(), e);
        }

        return detalles;
    }
}
