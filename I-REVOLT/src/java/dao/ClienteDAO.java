package dao;

import modelo.Cliente;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;
import org.mindrot.jbcrypt.BCrypt;

public class ClienteDAO {

    public void registrarCliente(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO clientes (nombre, email, contrasena, telefono, direccion, estado) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, cliente.getNombre());
            pstmt.setString(2, cliente.getEmail());
            
            // Hash de la contraseña
            String hashedPassword = BCrypt.hashpw(cliente.getContrasena(), BCrypt.gensalt());
            pstmt.setString(3, hashedPassword);

            pstmt.setString(4, cliente.getTelefono());
            pstmt.setString(5, cliente.getDireccion());
            pstmt.setString(6, cliente.getEstado());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error al agregar cliente: " + e.getMessage(), e);
        }
    }

     // Método para obtener todos los clientes
    public List<Cliente> obtenerClientes() throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT * FROM clientes"; 

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setId(rs.getLong("id"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setEmail(rs.getString("email"));
                cliente.setContrasena(rs.getString("contrasena"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setEstado(rs.getString("estado"));
                cliente.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                cliente.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                clientes.add(cliente);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener clientes: " + e.getMessage(), e);
        }

        return clientes;
    }

    // Método para agregar un cliente
    public void agregarCliente(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO clientes (nombre, email, contrasena, telefono, direccion, estado, creado_en, actualizado_en) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cliente.getNombre());
            pstmt.setString(2, cliente.getEmail());
            pstmt.setString(3, cliente.getContrasena());
            pstmt.setString(4, cliente.getTelefono());
            pstmt.setString(5, cliente.getDireccion());
            pstmt.setString(6, cliente.getEstado());
            pstmt.setObject(7, OffsetDateTime.now());
            pstmt.setObject(8, OffsetDateTime.now());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error al agregar cliente: " + e.getMessage(), e);
        }
    }

    // Método para actualizar un cliente
    public void actualizarCliente(Cliente cliente) throws SQLException {
        String sql = "UPDATE clientes SET nombre=?, email=?, contrasena=?, telefono=?, direccion=?, estado=?, actualizado_en=? WHERE id=?";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cliente.getNombre());
            pstmt.setString(2, cliente.getEmail());
            pstmt.setString(3, cliente.getContrasena());
            pstmt.setString(4, cliente.getTelefono());
            pstmt.setString(5, cliente.getDireccion());
            pstmt.setString(6, cliente.getEstado());
            pstmt.setObject(7, OffsetDateTime.now());
            pstmt.setLong(8, cliente.getId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error al actualizar cliente: " + e.getMessage(), e);
        }
    }

    // Método para eliminar un cliente
    public void eliminarCliente(long id) throws SQLException {
        String sql = "DELETE FROM clientes WHERE id=?";

        try (Connection conn = Conexion.getConexion(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error al eliminar cliente: " + e.getMessage(), e);
        }
    }
    
    
    ///
    
        // Método para buscar un cliente por ID (solo con los campos seleccionados)
    public Cliente buscarClientePorId(long id) throws SQLException {
        String sql = "SELECT nombre, email, telefono, direccion, contrasena FROM clientes WHERE id = ?";
        Cliente cliente = null;

        try (Connection conn = Conexion.getConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cliente = new Cliente();
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setDireccion(rs.getString("direccion"));
                    cliente.setContrasena(rs.getString("contrasena"));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error al buscar cliente por ID: " + e.getMessage(), e);
        }

        return cliente;
    }
    
    
}
    

