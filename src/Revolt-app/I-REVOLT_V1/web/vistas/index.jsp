<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Empleado"%>
<%@page import="dao.EmpleadoDAO"%>
<%@page import="modelo.Cliente"%>
<%@page import="dao.ClienteDAO"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="modelo.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%@page import="modelo.Metodo_Pago"%>
<%@page import="dao.Metodo_PagoDAO"%>
<%@page import="modelo.Pasarela_pago"%>
<%@page import="dao.Pasarela_PagoDAO"%>
<%@page import="modelo.Orden"%>
<%@page import="dao.OrdenDAO"%>
<%@page import="modelo.DetalleOrden"%>
<%@page import="dao.DetalleOrdenDAO"%>
<%@page import="modelo.Proveedor"%>
<%@page import="dao.ProveedorDAO"%>
<%@page import="modelo.Compra"%>
<%@page import="dao.CompraDAO"%>
<%@page import="modelo.DetalleCompra"%>
<%@page import="dao.DetalleCompraDAO"%>
<%@page import="modelo.Inventario"%>
<%@page import="dao.InventarioDAO"%>
<%@page import="modelo.NotasCredito"%>
<%@page import="dao.NotasCreditoDAO"%>
<%@page import="modelo.Facturacion"%>
<%@page import="dao.FacturacionDAO"%>
<%@page import="modelo.InformacionTarjeta"%>
<%@page import="dao.InformacionTarjetaDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Revolt Shop - Blog</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="../styles.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/baner.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/nav.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/pago.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/login.css" rel="stylesheet" type="text/css"/>
    <body>
        <!--================ Menu Area Inicio=================-->
        <header class="header_area">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">

                    <a class="navbar-brand" href="../index.html">
                        <img src="../img/logo.png" alt="REVOLT">
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarContent">
                        <ul class="navbar-nav mx-auto">
                            <li class="nav-item active">
                                <a class="nav-link" href="../index.html">Inicio</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Shop</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="../category.html">Categorias</a></li>
                                    <li><a class="dropdown-item" href="../single-product.html">Producto detalle</a></li>
                                    <li><a class="dropdown-item" href="../checkout.html">Proceso Pago</a></li>
                                    <li><a class="dropdown-item" href="../confirmation.html">Confirmation</a></li>
                                    <li><a class="dropdown-item" href="../cart.html">Shopping Cart</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="../blog.html">Blog</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="../contact.html">Contacto</a>
                            </li>
                        </ul>

                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <button class="btn btn-link">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="btn btn-link">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </button>
                            </li>
                            <li class="nav-item">
                                <a class="button button-header" href="../login.html">Registrate!</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <!--================ Menu Area Fin =================-->
        <header>
            <div class="container">
                <br><br><br>
            </div>
        </header>

        <!-- ================ Banner inicio ================= -->	
        <section class="blog-banner-area" id="category">
            <div class="container h-100">
                <div class="blog-banner">
                    <div class="text-center">
                        <h1>Base de Datos</h1>
                        <nav aria-label="breadcrumb" class="banner-breadcrumb">
                            <ol class="breadcrumb">

                                <li class="breadcrumb-item"><a href="../index.html">Inicio</a></li>
                                <li class="breadcrumb-item active" aria-current="page">BD</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ Banner fin ================= -->


        <!-- ================ Empleado Inicio ================= -->
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Empleados</h1>
            <%
                EmpleadoDAO empleadoDAO = new EmpleadoDAO();
                try {
                    List<Empleado> empleados = empleadoDAO.obtenerEmpleados();
                    if (empleados.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay empleados para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Contraseña</th> 
                        <th>Rol</th> 
                        <th>Teléfono</th>
                        <th>Puesto</th>
                        <th>Estado</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Empleado empleado : empleados) {
                    %>
                    <tr>
                        <td><%= empleado.getId()%></td>
                        <td><%= empleado.getNombre()%></td>
                        <td><%= empleado.getEmail()%></td>
                        <td><%= empleado.getContrasena()%></td> 
                        <td><%= empleado.getRol()%></td> 
                        <td><%= empleado.getTelefono()%></td>
                        <td><%= empleado.getPuesto()%></td>
                        <td><%= empleado.getEstado()%></td>
                        <td><%= empleado.getCreadoEn().format(formatter)%></td>
                        <td><%= empleado.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener empleados: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!--================ Empleado fin  =================-->


        <!-- ================ Cliente Inicio ================= -->
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Clientes</h1>
            <%
                ClienteDAO clienteDAO = new ClienteDAO();
                try {
                    List<Cliente> clientes = clienteDAO.obtenerClientes();
                    if (clientes.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay clientes para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Contraseña</th></th>
                        <th>Teléfono</th>
                        <th>Dirección</th>
                        <th>Estado</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Cliente cliente : clientes) {
                    %>
                    <tr>
                        <td><%= cliente.getId()%></td>
                        <td><%= cliente.getNombre()%></td>
                        <td><%= cliente.getEmail()%></td>
                        <td><%= cliente.getContrasena()%></td>
                        <td><%= cliente.getTelefono()%></td>
                        <td><%= cliente.getDireccion()%></td>
                        <td><%= cliente.getEstado()%></td>
                        <td><%= cliente.getCreadoEn().format(formatter)%></td>
                        <td><%= cliente.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener clientes: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!--================ Cliente fin  =================-->


        <!-- ================ Categoria Inicio ================= -->
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Categorías</h1>
            <%
                CategoriaDAO categoriaDAO = new CategoriaDAO();
                try {
                    List<Categoria> categorias = categoriaDAO.obtenerCategorias();
                    if (categorias.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay categorías para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Empleado ID</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Categoria categoria : categorias) {
                    %>
                    <tr>
                        <td><%= categoria.getId()%></td>
                        <td><%= categoria.getNombre()%></td>
                        <td><%= categoria.getEmpleadoId()%></td>
                        <td><%= categoria.getCreadoEn().format(formatter)%></td>
                        <td><%= categoria.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener categorías: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!--================ Categoria fin  =================-->


        <!-- ================ Productos Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Productos</h1>
            <%
                ProductoDAO productoDAO = new ProductoDAO();
                try {
                    List<Producto> productos = productoDAO.obtenerProductos();
                    if (productos.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay productos para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Descripción</th>
                        <th>Categoría ID</th>
                        <th>Empleado_ID</th>
                        <th>Marca</th>
                        <th>Color</th>
                        <th>Stock</th>
                        <th>Direccion img</th>
                        <th>Img_01</th>
                        <th>Img_02</th>
                        <th>Img_03</th>
                        <th>Puntuación</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Producto producto : productos) {
                    %>
                    <tr>
                        <td><%= producto.getId()%></td>
                        <td><%= producto.getNombre()%></td>
                        <td><%= producto.getPrecio()%></td>
                        <td><%= producto.getDescripcion()%></td>
                        <td><%= producto.getCategoriaId()%></td>
                        <td><%= producto.getEmpleadoId()%></td>
                        <td><%= producto.getMarca_nombre()%></td>
                        <td><%= producto.getColor_nombre()%></td>
                        <td><%= producto.getStock()%></td>
                        <td><%= producto.getImage_dir()%></td>
                        <td><%= producto.getImage_dir_d_01()%></td>
                        <td><%= producto.getImage_dir_d_02()%></td>
                        <td><%= producto.getImage_dir_d_03()%></td>
                        <td><%= producto.getPuntuacion()%></td>
                        <td><%= producto.getCreadoEn().format(formatter)%></td>
                        <td><%= producto.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener productos: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!--================ Productos fin  =================-->



        <!-- ================ Metodo pago Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Métodos de Pago</h1>
            <%
                Metodo_PagoDAO metodoPagoDAO = new Metodo_PagoDAO();
                try {
                    List<Metodo_Pago> metodosPago = metodoPagoDAO.obtenerMetodosPago();
                    if (metodosPago.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay métodos de pago para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Es Tarjeta</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Metodo_Pago metodoPago : metodosPago) {
                    %>
                    <tr>
                        <td><%= metodoPago.getId()%></td>
                        <td><%= metodoPago.getNombre()%></td>
                        <td><%= metodoPago.getDescripcion()%></td>
                        <td><%= metodoPago.getEsTarjeta()%></td>
                        <td><%= metodoPago.getCreadoEn().format(formatter)%></td>
                        <td><%= metodoPago.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener métodos de pago: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!--================ Metodo pago fin  =================-->


        <!-- ================ Pasarela pago  Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Pasarelas de Pago</h1>
            <%
                Pasarela_PagoDAO pasarelaPagoDAO = new Pasarela_PagoDAO();
                try {
                    List<Pasarela_pago> pasarelasPago = pasarelaPagoDAO.obtenerPasarelasPago();
                    if (pasarelasPago.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay pasarelas de pago para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Comisión</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Pasarela_pago pasarelaPago : pasarelasPago) {
                    %>
                    <tr>
                        <td><%= pasarelaPago.getId()%></td>
                        <td><%= pasarelaPago.getNombre()%></td>
                        <td><%= pasarelaPago.getDescripcion()%></td>
                        <td><%= pasarelaPago.getComision()%></td>
                        <td><%= pasarelaPago.getCreadoEn().format(formatter)%></td>
                        <td><%= pasarelaPago.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener pasarelas de pago: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Pasarela pago fin ================= -->   


        <!-- ================ Orden  Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Órdenes</h1>
            <%
                OrdenDAO ordenDAO = new OrdenDAO();
                try {
                    List<Orden> ordenes = ordenDAO.obtenerOrdenes();
                    if (ordenes.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay órdenes para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Cliente ID</th>
                        <th>Fecha</th>
                        <th>Total</th>
                        <th>Estado</th> 
                        <th>Método de Pago ID</th>
                        <th>Pasarela de Pago ID</th>
                        <th>Fact ID</th>
                        <th>Tarj ID</th>
                        <th>Fecha de Creación</th>
                        <th>Fecha de Actualización</th> 
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Orden orden : ordenes) {
                    %>
                    <tr>
                        <td><%= orden.getId()%></td>
                        <td><%= orden.getClienteId()%></td>
                        <td><%= orden.getFecha().format(formatter)%></td> 
                        <td><%= orden.getTotal()%></td>
                        <td><%= orden.getEstado()%></td> 
                        <td><%= orden.getMetodoPagoId()%></td>
                        <td><%= orden.getPasarelaPagoId()%></td>
                        <td><%= orden.getFacturacionId()%></td>
                        <td><%= orden.getTarjetaId()%></td>
                        <td><%= orden.getCreadoEn().format(formatter)%></td> 
                        <td><%= orden.getActualizadoEn().format(formatter)%></td> 
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener órdenes: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Orden  fin ================= -->   


        <!-- ================ Lista ordenes Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Detalles de Órdenes</h1>
            <%
                DetalleOrdenDAO detalleOrdenDAO = new DetalleOrdenDAO();
                try {
                    List<DetalleOrden> detallesOrden = detalleOrdenDAO.obtenerDetallesOrden();
                    if (detallesOrden.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay detalles de órdenes para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Orden ID</th>
                        <th>Producto ID</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (DetalleOrden detalle : detallesOrden) {
                    %>
                    <tr>
                        <td><%= detalle.getId()%></td>
                        <td><%= detalle.getOrdenId()%></td>
                        <td><%= detalle.getProductoId()%></td>
                        <td><%= detalle.getCantidad()%></td>
                        <td><%= detalle.getPrecioUnitario()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener detalles de órdenes: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Lista ordenes  fin ================= -->   


        <!-- ================ Facturacion Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Facturación</h1>
            <%
                FacturacionDAO facturacionDAO = new FacturacionDAO();
                try {
                    List<Facturacion> facturaciones = facturacionDAO.obtenerFacturaciones();
                    if (facturaciones.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay facturaciones para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Orden ID</th>
                        <th>Nombre Completo</th>
                        <th>Email</th>
                        <th>Dirección</th>
                        <th>Ciudad</th>
                        <th>País</th>
                        <th>Código Postal</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Facturacion facturacion : facturaciones) {
                    %>
                    <tr>
                        <td><%= facturacion.getId()%></td>
                        <td><%= facturacion.getOrdenId()%></td>
                        <td><%= facturacion.getNombreCompleto()%></td>
                        <td><%= facturacion.getEmail()%></td>
                        <td><%= facturacion.getDireccion()%></td>
                        <td><%= facturacion.getCiudad()%></td>
                        <td><%= facturacion.getPais()%></td>
                        <td><%= facturacion.getCodigoPostal()%></td>
                        <td><%= facturacion.getCreadoEn().format(formatter)%></td>
                        <td><%= facturacion.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener facturaciones: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Facturacion  fin ================= -->   


        <!-- ================ Tarjeta Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Información de Tarjetas</h1>
            <%
                InformacionTarjetaDAO tarjetaDAO = new InformacionTarjetaDAO();
                try {
                    List<InformacionTarjeta> tarjetas = tarjetaDAO.obtenerInformacionTarjetas();
                    if (tarjetas.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay información de tarjetas para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Orden ID</th>
                        <th>Nombre Tarjeta</th>
                        <th>Número Tarjeta</th>
                        <th>Mes Exp.</th>
                        <th>Año Exp.</th>
                        <th>CVV</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (InformacionTarjeta tarjeta : tarjetas) {
                    %>
                    <tr>
                        <td><%= tarjeta.getId()%></td>
                        <td><%= tarjeta.getOrdenId()%></td>
                        <td><%= tarjeta.getNombreTarjeta()%></td>
                        <td><%= tarjeta.getNumeroTarjeta()%></td>
                        <td><%= tarjeta.getMesExp()%></td>
                        <td><%= tarjeta.getAnoExp()%></td>
                        <td><%= tarjeta.getCvv()%></td>
                        <td><%= tarjeta.getCreadoEn().format(formatter)%></td>
                        <td><%= tarjeta.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener información de tarjetas: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Tarjeta Fin ================= -->   


        <!-- ================ Proveedor  Inicio ================= -->   
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Proveedores</h1>
            <%
                ProveedorDAO proveedorDAO = new ProveedorDAO();
                try {
                    List<Proveedor> proveedores = proveedorDAO.obtenerProveedores();
                    if (proveedores.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay proveedores para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Contacto</th>
                        <th>Teléfono</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Proveedor proveedor : proveedores) {
                    %>
                    <tr>
                        <td><%= proveedor.getId()%></td>
                        <td><%= proveedor.getNombre()%></td>
                        <td><%= proveedor.getContacto()%></td>
                        <td><%= proveedor.getTelefono()%></td>
                        <td><%= proveedor.getEmail()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener proveedores: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Proveeedor  fin ================= -->   

        <!-- ================ Compra  Inicio ================= -->  
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Compras</h1>
            <%
                CompraDAO compraDAO = new CompraDAO();
                try {
                    List<Compra> compras = compraDAO.obtenerCompras();
                    if (compras.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay compras para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Proveedor ID</th>
                        <th>Total</th>
                        <th>Estado</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (Compra compra : compras) {
                    %>
                    <tr>
                        <td><%= compra.getId()%></td>
                        <td><%= compra.getProveedorId()%></td>
                        <td><%= compra.getTotal()%></td>
                        <td><%= compra.getEstado()%></td>
                        <td><%= compra.getCreadoEn().format(formatter)%></td>
                        <td><%= compra.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener compras: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Compra  fin ================= -->  


        <!-- ================ Inventario  Inicio ================= -->  
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Inventarios</h1>
            <%
                InventarioDAO inventarioDAO = new InventarioDAO();
                try {
                    List<Inventario> inventarios = inventarioDAO.obtenerInventarios();
                    if (inventarios.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay inventarios para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Producto ID</th>
                        <th>Cantidad</th>
                        <th>Ubicación</th>
                        <th>Empleado ID</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Inventario inventario : inventarios) {
                    %>
                    <tr>
                        <td><%= inventario.getId()%></td>
                        <td><%= inventario.getProductoId()%></td>
                        <td><%= inventario.getCantidad()%></td>
                        <td><%= inventario.getUbicacion()%></td>
                        <td><%= inventario.getEmpleadoId()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener inventarios: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Imventario  fin ================= -->  


        <!-- ================ Detalle de compra  Inicio ================= -->  
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Detalles de Compras</h1>
            <%
                DetalleCompraDAO detalleCompraDAO = new DetalleCompraDAO();
                try {
                    List<DetalleCompra> detallesCompra = detalleCompraDAO.obtenerDetallesCompra();
                    if (detallesCompra.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay detalles de compras para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Compra ID</th>
                        <th>Producto ID</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (DetalleCompra detalle : detallesCompra) {
                    %>
                    <tr>
                        <td><%= detalle.getId()%></td>
                        <td><%= detalle.getCompraId()%></td>
                        <td><%= detalle.getProductoId()%></td>
                        <td><%= detalle.getCantidad()%></td>
                        <td><%= detalle.getPrecioUnitario()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener detalles de compras: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Detalle de compra fin ================= -->  


        <!-- ================ Nora de credito  Inicio ================= -->  
        <section class="container-f mt-5">
            <h1 class="mb-4">Lista de Notas de Crédito</h1>
            <%
                NotasCreditoDAO notasCreditoDAO = new NotasCreditoDAO();
                try {
                    List<NotasCredito> notas = notasCreditoDAO.obtenerNotasCredito();
                    if (notas.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">No hay notas de crédito para mostrar.</div>
            <%
            } else {
            %>
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Orden ID</th>
                        <th>Total</th>
                        <th>Motivo</th>
                        <th>Estado</th>
                        <th>Creado en</th>
                        <th>Actualizado en</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        for (NotasCredito nota : notas) {
                    %>
                    <tr>
                        <td><%= nota.getId()%></td>
                        <td><%= nota.getOrdenId()%></td>
                        <td><%= nota.getTotal()%></td>
                        <td><%= nota.getMotivo()%></td>
                        <td><%= nota.getEstado()%></td>
                        <td><%= nota.getCreadoEn().format(formatter)%></td>
                        <td><%= nota.getActualizadoEn().format(formatter)%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error al obtener notas de crédito: <%= e.getMessage()%></div>
            <%
                }
            %>
        </section>
        <!-- ================ Nota de credito fin ================= -->  



        <!--================ Pie de pagina Incio =================-->
        <footer class="footer">
            <div class="footer-area">
                <div class="container-f">
                    <div class="row section_gap">

                        <!-- Our Mission -->
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="single-footer-widget tp_widgets">
                                <h4 class="footer_title large_title">Misión</h4>
                                <p>Nos enfocamos en ofrecer ropa de calidad que combine estilo y comodidad, con una experiencia de compra rápida y fácil.</p>
                                <p>Queremos que cada cliente encuentre prendas que lo representen, con un servicio personalizado que haga su compra en línea más agradable.</p>
                            </div>
                        </div>

                        <!-- Quick Links -->
                        <div class="col-lg-2 col-md-6 col-sm-6">
                            <div class="single-footer-widget">
                                <h4>Paginas</h4>
                                <ul class="footer-links">
                                    <li class="mb-2"><a href="#">Inicio</a></li>
                                    <li class="mb-2"><a href="#">Categorias</a></li>
                                    <li class="mb-2"><a href="#">Blog</a></li>
                                    <li class="mb-2"><a href="#">Productos</a></li>
                                    <li class="mb-2"><a href="#">Contactanos</a></li>
                                </ul>
                            </div>
                        </div>

                        <!-- Gallery -->
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="single-footer-widget">
                                <h4 class="footer_title">Galeria</h4>
                                <div class="gallery-grid">
                                    <img src="../img/gallery/r1.jpg" alt="gallery" class="img-fluid">
                                    <img src="../img/gallery/r2.jpg" alt="gallery" class="img-fluid">
                                    <img src="../img/gallery/r3.jpg" alt="gallery" class="img-fluid">
                                    <img src="../img/gallery/r5.jpg" alt="gallery" class="img-fluid">
                                    <img src="../img/gallery/r7.jpg" alt="gallery" class="img-fluid">
                                    <img src="../img/gallery/r8.jpg" alt="gallery" class="img-fluid">
                                </div>
                            </div>
                        </div>

                        <!-- Contact Us -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="single-footer-widget">
                                <h4>Contactanos</h4>
                                <div class="contact-info">
                                    <p class="d-flex align-items-center mb-3">
                                        <i class="fas fa-location-dot"></i>
                                        <span>
                                            <strong class="d-block text-white">Dirección</strong>
                                            123, Bulevar de Santa Mónica, San Isidro
                                        </span>
                                    </p>

                                    <p class="d-flex align-items-center mb-3">
                                        <i class="fas fa-phone"></i>
                                        <span>
                                            <strong class="d-block text-white">Telefonos</strong>
                                            51 986 511 562
                                        </span>
                                    </p>

                                    <p class="d-flex align-items-center mb-3">
                                        <i class="fas fa-envelope"></i>
                                        <span>
                                            <strong class="d-block text-white">Correo</strong>
                                            support@revolt.com
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="container">
                    <div class="row d-flex">
                        <p class="col-lg-12 footer-text text-center">
                            &copy;
                            <script>document.write(new Date().getFullYear());</script> Todos los derechos reservados
                            <i class="fa fa-heart text-danger"></i> by
                            <a href="https://www.linkedin.com/in/michaell-araujo-b88471234/" target="_blank"
                               class="text-white text-decoration-none">Araujo</a>
                        </p>
                    </div>
                </div>
            </div>
        </footer>
        <!--================ Pie de pagina  Fin  =================-->

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>

    </body>

</html>