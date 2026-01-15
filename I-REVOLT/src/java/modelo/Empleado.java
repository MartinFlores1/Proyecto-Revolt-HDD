package modelo;

import java.time.OffsetDateTime;

public class Empleado {
    private long id;
    private String nombre;
    private String email;
    private String telefono;
    private String puesto;
    private String contrasena;
    private String rol;
    private String estado;
    private OffsetDateTime creadoEn;
    private OffsetDateTime actualizadoEn;
    
    public long getId() {
        return id;
    }

    public void setIdEmpleado(long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) { 
        this.contrasena = contrasena;
    }

    public String getRol() { 
        return rol;
    }

    public void setRol(String rol) { 
        this.rol = rol;
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
}
