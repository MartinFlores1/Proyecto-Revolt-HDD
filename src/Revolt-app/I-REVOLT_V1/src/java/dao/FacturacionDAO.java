package dao;

import modelo.Facturacion;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class FacturacionDAO {

    public List<Facturacion> obtenerFacturaciones() throws SQLException {
        List<Facturacion> facturaciones = new ArrayList<>();
        String sql = "SELECT * FROM facturacion";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Facturacion facturacion = new Facturacion();
                facturacion.setId(rs.getLong("id"));
                facturacion.setOrdenId(rs.getLong("orden_id"));
                facturacion.setNombreCompleto(rs.getString("nombre_completo"));
                facturacion.setEmail(rs.getString("email"));
                facturacion.setDireccion(rs.getString("direccion"));
                facturacion.setCiudad(rs.getString("ciudad"));
                facturacion.setPais(rs.getString("pais"));
                facturacion.setCodigoPostal(rs.getString("codigo_postal"));
                facturacion.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                facturacion.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                facturaciones.add(facturacion);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener facturaciones: " + e.getMessage(), e);
        }

        return facturaciones;
    }
}
