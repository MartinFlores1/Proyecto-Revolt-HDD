package dao;

import modelo.NotasCredito;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class NotasCreditoDAO {

    public List<NotasCredito> obtenerNotasCredito() throws SQLException {
        List<NotasCredito> notas = new ArrayList<>();
        String sql = "SELECT * FROM notas_credito";

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                NotasCredito nota = new NotasCredito();
                nota.setId(rs.getLong("id"));
                nota.setOrdenId(rs.getLong("orden_id"));
                nota.setTotal(rs.getDouble("total"));
                nota.setMotivo(rs.getString("motivo"));
                nota.setEstado(rs.getString("estado"));
                nota.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                nota.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                notas.add(nota);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener notas de crédito: " + e.getMessage(), e);
        }

        return notas;
    }
}
