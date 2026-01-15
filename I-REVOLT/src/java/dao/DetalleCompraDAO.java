package dao;

import modelo.DetalleCompra;
import conexion.Conexion; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetalleCompraDAO {

    public List<DetalleCompra> obtenerDetallesCompra() throws SQLException {
        List<DetalleCompra> detallesCompra = new ArrayList<>();
        String sql = "SELECT * FROM detalles_compra";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                DetalleCompra detalle = new DetalleCompra();
                detalle.setId(rs.getLong("id"));
                detalle.setCompraId(rs.getLong("compra_id"));
                detalle.setProductoId(rs.getLong("producto_id"));
                detalle.setCantidad(rs.getInt("cantidad"));
                detalle.setPrecioUnitario(rs.getDouble("precio_unitario"));
                detallesCompra.add(detalle);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener detalles de compra: " + e.getMessage(), e);
        }

        return detallesCompra;
    }
}
