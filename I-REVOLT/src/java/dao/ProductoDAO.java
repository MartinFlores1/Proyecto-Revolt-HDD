package dao;

import modelo.Producto;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.time.OffsetDateTime;

public class ProductoDAO {

    public List<Producto> obtenerProductos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos";

        try (Connection conn = Conexion.getConexion(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setId(rs.getLong("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecio(rs.getBigDecimal("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setCategoriaId(rs.getLong("categoria_id"));
                producto.setEmpleadoId(rs.getLong("empleado_id"));
                producto.setMarca_nombre(rs.getString("marca_nombre"));
                producto.setColor_nombre(rs.getString("color_nombre"));
                producto.setStock(rs.getInt("stock"));
                producto.setImage_dir(rs.getString("image_dir"));
                producto.setImage_dir_d_01(rs.getString("image_dir_d_01"));
                producto.setImage_dir_d_02(rs.getString("image_dir_d_02"));
                producto.setImage_dir_d_03(rs.getString("image_dir_d_03"));
                producto.setPuntuacion(rs.getInt("puntuacion"));
                producto.setCreadoEn(rs.getObject("creado_en", OffsetDateTime.class));
                producto.setActualizadoEn(rs.getObject("actualizado_en", OffsetDateTime.class));
                productos.add(producto);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener productos: " + e.getMessage(), e);
        }

        return productos;
    }

    public List<Producto> obtenerProducto() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT p.id, p.nombre, p.precio, c.nombre AS categoria_nombre, "
                + "p.marca_nombre, p.color_nombre, p.image_dir "
                + "FROM productos p "
                + "INNER JOIN categorias c ON p.categoria_id = c.id";
        try (Connection conn = Conexion.getConexion(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setId(rs.getLong("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecio(rs.getBigDecimal("precio"));
                producto.setCategoriaNombre(rs.getString("categoria_nombre")); // Nuevo campo
                producto.setMarca_nombre(rs.getString("marca_nombre"));
                producto.setColor_nombre(rs.getString("color_nombre"));
                producto.setImage_dir(rs.getString("image_dir"));
                productos.add(producto);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener productos: " + e.getMessage(), e);
        }
        return productos;
    }

        public List<Producto> obtenerProductoDetalle() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT p.id, p.nombre, p.precio, c.nombre AS categoria_nombre, "
                + "p.marca_nombre, p.color_nombre, p.image_dir "
                + "FROM productos p "
                + "INNER JOIN categorias c ON p.categoria_id = c.id";
        try (Connection conn = Conexion.getConexion(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setId(rs.getLong("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecio(rs.getBigDecimal("precio"));
                producto.setCategoriaNombre(rs.getString("categoria_nombre")); // Nuevo campo
                producto.setMarca_nombre(rs.getString("marca_nombre"));
                producto.setColor_nombre(rs.getString("color_nombre"));
                producto.setImage_dir(rs.getString("image_dir"));
                producto.setImage_dir_d_01(rs.getString("image_dir_d_01"));
                producto.setImage_dir_d_02(rs.getString("image_dir_d_02"));
                producto.setImage_dir_d_03(rs.getString("image_dir_d_03"));
                producto.setPuntuacion(rs.getInt("puntuacion"));
                productos.add(producto);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener productos: " + e.getMessage(), e);
        }
        return productos;
    }
    
    
}
