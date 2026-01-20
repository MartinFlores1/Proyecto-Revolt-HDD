<%@page import="dao.ClienteDAO"%>
<%@page import="modelo.Cliente"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Revolt Shop - Home</title>
        <link rel="icon" href="../img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="../styles.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/baner.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/nav.css" rel="stylesheet" type="text/css"/>

        <link href="../otros/cuenta.css" rel="stylesheet" type="text/css"/>

    <body>
        <!--================ Menu Area Inicio=================-->
        <header class="header_area">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <!-- Logo -->
                    <a class="navbar-brand" href="../index.html">
                        <img src="../img/logo.png" alt="REVOLT">
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <!-- Menú Central -->
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

                        <!-- Menú Derecho -->
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
                                <a class="button button-header" href="login.jsp">Registrate!</a>
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


        <!-- ================ start banner area ================= -->
        <section class="blog-banner-area" id="category">
            <div class="container h-100">
                <div class="blog-banner">
                    <div class="text-center">
                        <h1>Cuenta</h1>
                        <nav aria-label="breadcrumb" class="banner-breadcrumb">
                            <ol class="breadcrumb">

                                <li class="breadcrumb-item"><a href="../index.html">Inicio</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Cuenta</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ end banner area ================= -->


<!--================ Cuenta Box Area =================-->
<section class="cuenta">
    <div class="container-f">
        <h1>Inicio de sesión y seguridad</h1>
        <div class="cuenta-content">
            <!-- Columna 1: Información personal -->
            <%
                ClienteDAO clienteDAO = new ClienteDAO();
                Cliente cliente = null;
                long idCliente =3; // Cambia este valor según sea necesario

                try {
                    cliente = clienteDAO.buscarClientePorId(idCliente);

                    if (cliente == null) {
            %>
            <div class="alert alert-warning" role="alert">El cliente no existe.</div>
            <%
            } else {
            %>
            <div class="columna">
                <form id="form-cliente" method="post" action="<%= request.getContextPath()%>/EditarPerfilServlet">
                    <div class="data-item">
                        <label for="name">Nombre</label>
                        <input type="text" id="name" name="nombre" value="<%= cliente.getNombre()%>" disabled>
                    </div>
                    <div class="data-item">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="<%= cliente.getEmail()%>" disabled>
                    </div>
                    <div class="data-item">
                        <label for="phone">Número de celular</label>
                        <input type="text" id="phone" name="telefono" value="<%= cliente.getTelefono()%>" disabled>
                    </div>
                    <div class="data-item">
                        <label for="address">Dirección</label>
                        <input type="text" id="address" name="direccion" value="<%= cliente.getDireccion()%>" disabled>
                    </div>
                    <div class="data-item">
                        <label for="password">Contraseña</label>
                        <input type="password" id="password" name="contrasena" value="*********" disabled>
                        <!-- Campo oculto que contiene la contraseña actual -->
                        <input type="hidden" name="contrasena_actual" value="<%= cliente.getContrasena()%>">
                    </div>
                    <input type="hidden" name="id" value="<%= idCliente%>">
                    <input type="hidden" name="accion" value="actualizar">

                    <button type="button" class="edit-btn" onclick="toggleEdit()">Editar</button>
                </form>
            </div>
            <%
                }
            } catch (SQLException e) {
            %>
            <div class="alert alert-danger" role="alert">Error de base de datos: <%= e.getMessage()%></div>
            <%
            } catch (Exception e) {
            %>
            <div class="alert alert-danger" role="alert">Ocurrió un error inesperado: <%= e.getMessage()%></div>
            <%
                }
            %>

            <!-- Modal de Confirmación de Edición -->
            <div class="modal fade" id="confirmEditModal" tabindex="-1" aria-labelledby="confirmEditModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmEditModalLabel">
                                <i class="fa-solid fa-spinner fa-spin-pulse"></i> Confirmación
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body text-center">
                            <i class="fa-solid fa-edit" style="font-size: 2rem;"></i>
                            <p>¿Estás seguro de que deseas guardar los cambios realizados?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btx-flotante btx-flotante-headery" id="cancelEditButton" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btx-flotante-c btx-flotante-c-headery" id="confirmEditButton">Guardar cambios</button>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Columna 2: Otros datos -->
            <div class="columna">
                <div class="data-item">
                    <label for="paymentMethod">Método de pago</label>
                    <button class="start-btn" onclick="startSecurityMeasures()">Ver</button>
                </div>
                <div class="data-item">
                    <label for="accountRisk">¿La cuenta está en riesgo?</label>
                    <button class="start-btn" onclick="startSecurityMeasures()">Comenzar</button>
                </div>
                <div class="data-item">
                    <label for="purchaseHistory">Historial de compras</label>
                    <button class="start-btn" onclick="startSecurityMeasures()">Ver</button>
                </div>
            </div>
        </div>
    </div>
</section>
<!--================ Cuenta Fin =================-->


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

    <script src="../js/login.js"></script>
    <script src="../js/cuenta.js"></script>
</body>

</html>
