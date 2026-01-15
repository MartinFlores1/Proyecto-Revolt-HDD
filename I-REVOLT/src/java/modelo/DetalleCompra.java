package modelo;

public class DetalleCompra {
    private long id;
    private long compraId; 
    private long productoId; 
    private int cantidad; 
    private double precioUnitario; 

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getCompraId() {
        return compraId;
    }

    public void setCompraId(long compraId) {
        this.compraId = compraId;
    }

    public long getProductoId() {
        return productoId;
    }

    public void setProductoId(long productoId) {
        this.productoId = productoId;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
}
