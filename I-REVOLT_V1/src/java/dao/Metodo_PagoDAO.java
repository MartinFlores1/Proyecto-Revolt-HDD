package dao;

import modelo.Metodo_Pago;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class Metodo_PagoDAO {

    public List<Metodo_Pago> obtenerMetodosPago() throws SQLException {
        List<Metodo_Pago> metodosPago = new ArrayList<>();
        String sql = "SELECT * FROM metodos_pago";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Metodo_Pago metodoPago = new Metodo_Pago();
                metodoPago.setId(rs.getLong("id"));
                metodoPago.setNombre(rs.getString("nombre"));
                metodoPago.setDescripcion(rs.getString("descripcion"));
                metodoPago.setEsTarjeta(rs.getInt("es_tarjeta"));   
                metodoPago.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                metodoPago.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                metodosPago.add(metodoPago);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener métodos de pago: " + e.getMessage(), e);
        }

        return metodosPago;
    }
    
    
  
    
}
