package modelo;

import java.time.OffsetDateTime;

public class Orden {

    private long id;
    private long clienteId;
    private OffsetDateTime fecha;
    private double total;
    private String estado;
    private long metodoPagoId;
    private long pasarelaPagoId;
    private long facturacionId;
    private long tarjetaId;
    private OffsetDateTime creadoEn;
    private OffsetDateTime actualizadoEn;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getClienteId() {
        return clienteId;
    }

    public void setClienteId(long clienteId) {
        this.clienteId = clienteId;
    }

    public OffsetDateTime getFecha() {
        return fecha;
    }

    public void setFecha(OffsetDateTime fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public long getMetodoPagoId() {
        return metodoPagoId;
    }

    public void setMetodoPagoId(long metodoPagoId) {
        this.metodoPagoId = metodoPagoId;
    }

    public long getPasarelaPagoId() {
        return pasarelaPagoId;
    }

    public void setPasarelaPagoId(long pasarelaPagoId) {
        this.pasarelaPagoId = pasarelaPagoId;
    }

    public long getFacturacionId() {
        return facturacionId;
    }

    public void setFacturacionId(long facturacionId) {
        this.facturacionId = facturacionId;
    }

    public long getTarjetaId() {
        return tarjetaId;
    }

    public void setTarjetaId(long tarjetaId) {
        this.tarjetaId = tarjetaId;
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

}
