<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>

        <link href="../styles.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/baner.css" rel="stylesheet" type="text/css"/>
        <link href="../otros/nav.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/dashboard.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/linea.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/linea_doble.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/velocimetro.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/circle.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/radar.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/circle_cn.css" rel="stylesheet" type="text/css"/>
        <link href="../graf/pago.css" rel="stylesheet" type="text/css"/>
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
                        <h1>Dashboard</h1>
                        <nav aria-label="breadcrumb" class="banner-breadcrumb">
                            <ol class="breadcrumb">

                                <li class="breadcrumb-item"><a href="../index.html">Inicio</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ end banner area ================= -->


        <!--================ Grafico Inicio =================-->
        <!--================ Grafico Inicio =================-->
        <section id="dashboardSection">
            <div class="container-f">
                <div class="dashboard-layout">
                    <!-- Header Navigation -->
                    <header class="navigation-header">
                        <nav>
                            <ul class="menu-items">
                                <li>
                                    <select class="dropdown-select" id="mesSelect">
                                        <option value="default">Todos los meses</option>
                                        <option value="1">Enero</option>
                                        <option value="2">Febrero</option>
                                        <option value="3">Marzo</option>
                                        <option value="4">Abril</option>
                                        <option value="5">Mayo</option>
                                        <option value="6">Junio</option>
                                        <option value="7">Julio</option>
                                        <option value="8">Agosto</option>
                                        <option value="9">Setiembre</option>
                                        <option value="10">Octubre</option>
                                        <option value="11">Noviembre</option>
                                        <option value="12">Diciembre</option>
                                        <!-- Add more months with their respective numeric values -->
                                    </select>
                                </li>
                                <li>
                                    <select class="dropdown-select" id="anoSelect">
                                        <option value="default">Todos los años</option>
                                        <option value="2023">2023</option>
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                    </select>
                                </li>
                            </ul>
                        </nav>
                    </header>

                    <!-- Main Content -->
                    <main class="content-area">
                        <!-- Overview Stats -->
                        <section class="overview-stats">
                            <div class="stat-card-0">
                                <h2>Total facturado</h2>
                     <h1 id="totalRevenueDisplay">S/ 0.00</h1>
                            </div>
                            <div class="stat-card-0">
                                <h2>Ventas</h2>
                                  <h1 id="totalOrdersDisplay">0</h1>
                            </div>
                            <div class="stat-card-0">
                                <h2>Mejor puntuado</h2>
                                <p>Vestido Casual</p>
                                <div>🌟🌟🌟🌟🌟</div>
                            </div>
                            <div class="stat-card-0">
                                <h2>Menor puntuado</h2>
                                <p>Short negro</p>
                                <div>🌟🌟 ☆ ☆ ☆</div>
                            </div>
                        </section>

                        <!-- Quadrants -->
                        <section class="stats-grid">
                            <!-- Quadrant 1 -->
                            <section class="quadrant">
                                <div class="stat-card">   <!-- total acumulado-->
                                    <h2>Total facturado</h2>
                                    <div id="gr_barra" class="crx">   <!-- total acumulado-->
                                    </div>
                                </div>
                            </section>

                            <!-- Quadrant 2 (Divided into two equal columns) -->
                            <section class="quadrant split-columns">


                                <div class="stat-card">   
                                    <h2>Rentabilidad</h2>
                                    <div id="gaugeContainer" class="crx">   <!-- total acumulado-->
                                    </div>
                                </div>
                                <div class="stat-card">   
                                    <h2>Usuarios</h2>
                                    <div id="circlex" class="crx">   <!-- total acumulado-->
                                    </div>
                                </div>



                            </section>

                            <!-- Quadrant 3 -->
                            <section class="quadrant">

                                <div class="stat-card">   
                                    <h2>Ingreso por categoria</h2>
                                    <div id="main_gr" class="crx">   
                                    </div>
                                </div>


                            </section>

                            <!-- Quadrant 4 -->
                            <section class="quadrant grid-3-columns">

                                <div class="stat-card">   
                                    <h2>Días de compras</h2>
                                    <div id="radarChart" class="crx">   
                                    </div>
                                </div>

                                <div class="stat-card">   
                                    <h2>Participación</h2>
                                    <div id="pieChartContainer" class="crx">   
                                    </div>
                                </div>

                                <div class="stat-card">   
                                    <h2>Metodo de pago</h2>
                                    <div id="metodoPago" class="crx">   
                                    </div>
                                </div>

                            </section>
                        </section>
                    </main>
                </div>
            </div>
        </section>
        <!--================ Grafico Fin =================-->

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


        <script src="../graf/linea.js" type="text/javascript"></script>
        <script src="../graf/linea_doble.js" type="text/javascript"></script>
        <script src="../graf/velocimetro.js" type="text/javascript"></script>
        <script src="../graf/circle.js" type="text/javascript"></script>
        <script src="../graf/radar.js" type="text/javascript"></script>
        <script src="../graf/circle_cn.js" type="text/javascript"></script>
        <script src="../graf/pago.js" type="text/javascript"></script>
        <script src="../graf/ingreso_cart.js" type="text/javascript"></script>
        <script src="../graf/cantidad_cart.js" type="text/javascript"></script>
        <script>
          window.appContextPath = "${pageContext.request.contextPath}";
        </script>

    </body>

</html>
