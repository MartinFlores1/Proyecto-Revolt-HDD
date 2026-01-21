
package dao;

import conexion.Conexion;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import modelo.HistorialCompra;

public class HistorialComprasDAO {
    
    public List<HistorialCompra> obtenerHistorialCompras(int clienteId) throws SQLException {
        String sql = "SELECT o.id AS orden_id, o.fecha AS fecha_orden, o.total AS total_orden, "
                + "o.estado AS estado_orden, p.nombre AS nombre_producto, do.cantidad AS cantidad, "
                + "do.precio_unitario AS precio_unitario, (do.cantidad * do.precio_unitario) AS total_producto, "
                + "p.image_dir AS imagen_producto "
                + "FROM ordenes o "
                + "JOIN detalles_orden do ON o.id = do.orden_id "
                + "JOIN productos p ON do.producto_id = p.id "
                + "WHERE o.cliente_id = ? "
                + "ORDER BY o.fecha DESC";

        List<HistorialCompra> historial = new ArrayList<>();

        try (Connection conn = Conexion.getConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, clienteId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                HistorialCompra compra = new HistorialCompra();
                compra.setOrdenId(rs.getInt("orden_id"));
                compra.setFechaOrden(rs.getDate("fecha_orden"));
                compra.setTotalOrden(rs.getDouble("total_orden"));
                compra.setEstadoOrden(rs.getString("estado_orden"));
                compra.setNombreProducto(rs.getString("nombre_producto"));
                compra.setCantidad(rs.getInt("cantidad"));
                compra.setPrecioUnitario(rs.getDouble("precio_unitario"));
                compra.setTotalProducto(rs.getDouble("total_producto"));
                compra.setImagenProducto(rs.getString("imagen_producto"));

                historial.add(compra);
            }
        }

        return historial;
    }
    
}
