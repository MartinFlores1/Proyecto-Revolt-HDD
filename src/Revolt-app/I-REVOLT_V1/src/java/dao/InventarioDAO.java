package dao;

import modelo.Inventario;
import conexion.Conexion; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InventarioDAO {

    public List<Inventario> obtenerInventarios() throws SQLException {
        List<Inventario> inventarios = new ArrayList<>();
        String sql = "SELECT * FROM inventario";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Inventario inventario = new Inventario();
                inventario.setId(rs.getLong("id"));
                inventario.setProductoId(rs.getLong("producto_id"));
                inventario.setCantidad(rs.getInt("cantidad"));
                inventario.setUbicacion(rs.getString("ubicacion"));
                inventario.setEmpleadoId(rs.getLong("empleado_id"));
                inventarios.add(inventario);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener inventarios: " + e.getMessage(), e);
        }

        return inventarios;
    }
}
