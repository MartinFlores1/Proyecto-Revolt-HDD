package dao;

import modelo.Pasarela_pago;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class Pasarela_PagoDAO {

    public List<Pasarela_pago> obtenerPasarelasPago() throws SQLException {
        List<Pasarela_pago> pasarelasPago = new ArrayList<>();
        String sql = "SELECT * FROM pasarelas_pago";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Pasarela_pago pasarelaPago = new Pasarela_pago();
                pasarelaPago.setId(rs.getLong("id"));
                pasarelaPago.setNombre(rs.getString("nombre"));
                pasarelaPago.setDescripcion(rs.getString("descripcion"));
                pasarelaPago.setComision(rs.getDouble("comision"));
                pasarelaPago.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                pasarelaPago.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                pasarelasPago.add(pasarelaPago);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener pasarelas de pago: " + e.getMessage(), e);
        }

        return pasarelasPago;
    }
}
