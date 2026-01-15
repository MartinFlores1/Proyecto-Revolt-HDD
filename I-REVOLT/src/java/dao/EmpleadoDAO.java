package dao;

import modelo.Empleado;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class EmpleadoDAO {

  
    public List<Empleado> obtenerEmpleados() throws SQLException {
        List<Empleado> empleados = new ArrayList<>();
        String sql = "SELECT * FROM empleados"; 

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Empleado empleado = new Empleado();
                empleado.setIdEmpleado(rs.getLong("id"));
                empleado.setNombre(rs.getString("nombre"));
                empleado.setEmail(rs.getString("email"));
                empleado.setContrasena(rs.getString("contrasena"));
                empleado.setRol(rs.getString("rol"));
                empleado.setTelefono(rs.getString("telefono"));
                empleado.setPuesto(rs.getString("puesto"));
                empleado.setEstado(rs.getString("estado"));
                empleado.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                empleado.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                empleados.add(empleado);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener empleados: " + e.getMessage(), e);
        }

        return empleados;
    }    

public void agregarEmpleado(Empleado empleado) throws SQLException {
    String sql = "INSERT INTO empleados (nombre, email, contrasena, rol, telefono, puesto, estado, creado_en, actualizado_en) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = Conexion.getConexion(); 
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, empleado.getNombre());
        pstmt.setString(2, empleado.getEmail());
        pstmt.setString(3, empleado.getContrasena());
        pstmt.setString(4, empleado.getRol());
        pstmt.setString(5, empleado.getTelefono());
        pstmt.setString(6, empleado.getPuesto());
        pstmt.setString(7, empleado.getEstado());
        pstmt.setObject(8, OffsetDateTime.now());
        pstmt.setObject(9, OffsetDateTime.now());

        pstmt.executeUpdate();
    } catch (SQLException e) {
        throw new SQLException("Error al agregar empleado: " + e.getMessage(), e);
    }
}

public void actualizarEmpleado(Empleado empleado) throws SQLException {
    String sql = "UPDATE empleados SET nombre=?, email=?, contrasena=?, rol=?, telefono=?, puesto=?, estado=?, actualizado_en=? WHERE id=?";

    try (Connection conn = Conexion.getConexion(); 
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, empleado.getNombre());
        pstmt.setString(2, empleado.getEmail());
        pstmt.setString(3, empleado.getContrasena());
        pstmt.setString(4, empleado.getRol());
        pstmt.setString(5, empleado.getTelefono());
        pstmt.setString(6, empleado.getPuesto());
        pstmt.setString(7, empleado.getEstado());
        pstmt.setObject(8, OffsetDateTime.now());
        pstmt.setLong(9, empleado.getId());

        pstmt.executeUpdate();
    } catch (SQLException e) {
        throw new SQLException("Error al actualizar empleado: " + e.getMessage(), e);
    }
}

public void eliminarEmpleado(long id) throws SQLException {
    String sql = "DELETE FROM empleados WHERE id=?";

    try (Connection conn = Conexion.getConexion(); 
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setLong(1, id);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        throw new SQLException("Error al eliminar empleado: " + e.getMessage(), e);
    }
}


}

   