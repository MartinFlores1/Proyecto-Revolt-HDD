package modelo;

import java.math.BigDecimal;
import java.time.OffsetDateTime;

public class Producto {

    private long id;
    private String nombre;
    private BigDecimal precio;
    private String descripcion;
    private long categoriaId;
    private long empleadoId;
    private String marca_nombre;
    private String color_nombre;
    private int stock;
    private String image_dir;
    private String image_dir_d_01;
    private String image_dir_d_02;
    private String image_dir_d_03;
    private int puntuacion;
    private OffsetDateTime creadoEn;
    private OffsetDateTime actualizadoEn;

    private String categoriaNombre;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getMarca_nombre() {
        return marca_nombre;
    }

    public void setMarca_nombre(String marca_nombre) {
        this.marca_nombre = marca_nombre;
    }

    public String getColor_nombre() {
        return color_nombre;
    }

    public void setColor_nombre(String color_nombre) {
        this.color_nombre = color_nombre;
    }

    public String getImage_dir() {
        return image_dir;
    }

    public void setImage_dir(String image_dir) {
        this.image_dir = image_dir;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public long getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(long categoriaId) {
        this.categoriaId = categoriaId;
    }

    public long getEmpleadoId() {
        return empleadoId;
    }

    public void setEmpleadoId(long empleadoId) {
        this.empleadoId = empleadoId;
    }

    public OffsetDateTime getCreadoEn() {
        return creadoEn;
    }

    public void setCreadoEn(OffsetDateTime creadoEn) {
        this.creadoEn = creadoEn;
    }

    public OffsetDateTime getActualizadoEn() {
        return actualizadoEn;
    }

    public void setActualizadoEn(OffsetDateTime actualizadoEn) {
        this.actualizadoEn = actualizadoEn;
    }

    public String getCategoriaNombre() {
        return categoriaNombre;
    }

    public void setCategoriaNombre(String categoriaNombre) {
        this.categoriaNombre = categoriaNombre;
    }

    public String getImage_dir_d_01() {
        return image_dir_d_01;
    }

    public void setImage_dir_d_01(String image_dir_d_01) {
        this.image_dir_d_01 = image_dir_d_01;
    }

    public String getImage_dir_d_02() {
        return image_dir_d_02;
    }

    public void setImage_dir_d_02(String image_dir_d_02) {
        this.image_dir_d_02 = image_dir_d_02;
    }

    public String getImage_dir_d_03() {
        return image_dir_d_03;
    }

    public void setImage_dir_d_03(String image_dir_d_03) {
        this.image_dir_d_03 = image_dir_d_03;
    }

    public int getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(int puntuacion) {
        this.puntuacion = puntuacion;
    }


    
    
    
}
