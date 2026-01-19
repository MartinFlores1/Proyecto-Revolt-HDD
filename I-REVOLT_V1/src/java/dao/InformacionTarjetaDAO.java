package dao;

import modelo.InformacionTarjeta;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class InformacionTarjetaDAO {

    public List<InformacionTarjeta> obtenerInformacionTarjetas() throws SQLException {
        List<InformacionTarjeta> tarjetas = new ArrayList<>();
        String sql = "SELECT * FROM informacion_tarjeta";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                InformacionTarjeta tarjeta = new InformacionTarjeta();
                tarjeta.setId(rs.getLong("id"));
                tarjeta.setOrdenId(rs.getLong("orden_id"));
                tarjeta.setNombreTarjeta(rs.getString("nombre_tarjeta"));
                tarjeta.setNumeroTarjeta(rs.getString("numero_tarjeta"));
                tarjeta.setMesExp(rs.getString("mes_exp"));
                tarjeta.setAnoExp(rs.getString("ano_exp"));
                tarjeta.setCvv(rs.getString("cvv"));
                tarjeta.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                tarjeta.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                tarjetas.add(tarjeta);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener información de tarjetas: " + e.getMessage(), e);
        }

        return tarjetas;
    }
}
