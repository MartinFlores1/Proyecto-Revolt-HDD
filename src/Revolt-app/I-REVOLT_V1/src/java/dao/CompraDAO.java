package dao;

import modelo.Compra;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class CompraDAO {

    public List<Compra> obtenerCompras() throws SQLException {
        List<Compra> compras = new ArrayList<>();
        String sql = "SELECT * FROM compras";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Compra compra = new Compra();
                compra.setId(rs.getLong("id"));
                compra.setProveedorId(rs.getLong("proveedor_id"));
                compra.setTotal(rs.getDouble("total"));
                compra.setEstado(rs.getString("estado"));
                compra.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                compra.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                compras.add(compra);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener compras: " + e.getMessage(), e);
        }

        return compras;
    }
}
