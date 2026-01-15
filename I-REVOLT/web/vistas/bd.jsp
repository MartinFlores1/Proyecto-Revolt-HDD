<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Empleado"%>
<%@page import="dao.EmpleadoDAO"%>
<%@page import="modelo.Cliente"%>
<%@page import="dao.ClienteDAO"%>
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
        <link rel="icon" href="../img/Fevicon.png" type="image/png">       
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
                    <!-- Logo -->
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
                                <li class="breadcrumb-item active" aria-current="page">BD-Gestión</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ Banner fin ================= -->


        <!-- ================ Empleado Inicio ================= -->
        <section class="container-c mt-5">
            <h1 class="mb-4">Gestión de empleados</h1>

            <div class="mb-5">
                <button type="button" class="btx btx-header btn-primary" data-bs-toggle="modal" data-bs-target="#crearEmpleadoModal">
                    Agregar nuevo empleado
                </button>
            </div>

            <!-- Modal flotante para agregar empleado -->
            <div class="modal fade" id="crearEmpleadoModal" tabindex="-1" aria-labelledby="crearEmpleadoModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/EmpleadoServlet" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="crearEmpleadoModalLabel">Agregar nuevo empleado</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="accion" value="crear">

                                <!-- Estilo flotante -->
                                <div class="mb-3 form-group">
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder=" " required>
                                    <label for="nombre" class="form-label"><span>Nombre</span></label>
                                </div>

                                <div class="mb-3 form-group">
                                    <input type="email" class="form-control" id="email" name="email" placeholder=" " required>
                                    <label for="email" class="form-label">Email</label>
                                </div>

                                <div class="mb-3 form-group">
                                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder=" " required>
                                    <label for="contrasena" class="form-label">Contraseña</label>
                                </div>

                                <div class="mb-3 form-group">
                                    <input type="text" class="form-control" id="rol" name="rol" placeholder=" " required>
                                    <label for="rol" class="form-label">Rol</label>
                                </div>

                                <div class="mb-3 form-group">
                                    <input type="text" class="form-control" id="telefono" name="telefono" placeholder=" " required>
                                    <label for="telefono" class="form-label">Teléfono</label>
                                </div>

                                <div class="mb-3 form-group">
                                    <input type="text" class="form-control" id="puesto" name="puesto" placeholder=" " required>
                                    <label for="puesto" class="form-label">Puesto</label>
                                </div>

                                <div class="mb-3 form-group">
                                    <input type="text" class="form-control" id="estado" name="estado" placeholder=" " required>
                                    <label for="estado" class="form-label">Estado</label>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btx-flotante-c btx-flotante-c-header" data-bs-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btx-flotante btx-flotante-header">Agregar Empleado</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <!-- Mostrar lista de empleados -->
            <%
                EmpleadoDAO empleadoDAO = new EmpleadoDAO();
                List<Empleado> empleados = null;
                try {
                    empleados = empleadoDAO.obtenerEmpleados();
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
                        <th>Acciones</th>
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


                        <td style="display: flex; align-items: center;" class="empleado-acciones">
                            <!-- Botón actualizar -->
                            <button type="button" class="btn btn-transparent" data-bs-toggle="modal" data-bs-target="#actualizarEmpleadoModal<%= empleado.getId()%>">
                                <i class="fa-regular fa-pen-to-square"></i>
                            </button>

                            <div style="margin-left: 10px;"></div>

                            <!-- Botón eliminar -->
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal" onclick="setDeleteId(<%= empleado.getId()%>)">
                                <i class="fa-regular fa-trash-can"></i>
                            </button>
                        </td>

                        <!-- Modal de Confirmación de Eliminación -->
                <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmDeleteModalLabel">
                                    <i class="fa-solid fa-spinner fa-spin-pulse""></i> Advertencia
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body text-center">
                                <i class="fa-solid fa-poo-bolt fa-beat-fade" style="--fa-beat-fade-opacity: 0.1; --fa-beat-fade-scale: 1.25; font-size: 2rem;"></i>
                                <p>¿Estás seguro de que deseas eliminar este empleado? <br>Esta acción no se puede deshacer.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btx-flotante btx-flotante-headery" data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btx-flotante-c btx-flotante-c-headery " id="confirmDeleteButton">Eliminar</button>
                            </div>
                        </div>
                    </div>
                </div>
                </tr>

                <!-- Modal para actualizar empleado -->
                <div class="modal fade" id="actualizarEmpleadoModal<%= empleado.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/EmpleadoServlet" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Actualizar empleado</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="accion" value="actualizar">
                                    <input type="hidden" name="id" value="<%= empleado.getId()%>">
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="nombre<%= empleado.getId()%>" name="nombre" value="<%= empleado.getNombre()%>" placeholder=" " required>
                                        <label for="nombre<%= empleado.getId()%>" class="form-label"><span>Nombre</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="email" class="form-control" id="email<%= empleado.getId()%>" name="email" value="<%= empleado.getEmail()%>" placeholder=" " required>
                                        <label for="email<%= empleado.getId()%>" class="form-label"><span>Email</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="password" class="form-control" id="contrasena<%= empleado.getId()%>" name="contrasena" value="<%= empleado.getContrasena()%>" placeholder=" " required>
                                        <label for="contrasena<%= empleado.getId()%>" class="form-label"><span>Contraseña</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="rol<%= empleado.getId()%>" name="rol" value="<%= empleado.getRol()%>" placeholder=" " required>
                                        <label for="rol<%= empleado.getId()%>" class="form-label"><span>Rol</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="telefono<%= empleado.getId()%>" name="telefono" value="<%= empleado.getTelefono()%>" placeholder=" " required>
                                        <label for="telefono<%= empleado.getId()%>" class="form-label"><span>Teléfono</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="puesto<%= empleado.getId()%>" name="puesto" value="<%= empleado.getPuesto()%>" placeholder=" " required>
                                        <label for="puesto<%= empleado.getId()%>" class="form-label"><span>Puesto</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="estado<%= empleado.getId()%>" name="estado" value="<%= empleado.getEstado()%>" placeholder=" " required>
                                        <label for="estado<%= empleado.getId()%>" class="form-label"><span>Estado</span></label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btx-flotante-c btx-flotante-c-headery" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="submit" class="btx-flotante btx-flotante-header">Guardar Cambios</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                </td>
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

        <!-- ================ Empleado Fin ================= -->

        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
        <div class="alert alert-info" role="alert"><%= mensaje%></div>
        <%
            }
        %>

        
        
        
        
        
        
        <!-- ================ Cliente Inicio ================= -->
<section class="container-c mt-5">
    <h1 class="mb-4">Gestión de clientes</h1>

    <div class="mb-5">
        <button type="button" class="btx btx-header btn-primary" data-bs-toggle="modal" data-bs-target="#crearClienteModal">
            Agregar nuevo cliente
        </button>
    </div>

    <!-- Modal flotante para agregar cliente -->
    <div class="modal fade" id="crearClienteModal" tabindex="-1" aria-labelledby="crearClienteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/ClienteServlet2" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="crearClienteModalLabel">Agregar nuevo cliente</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="accion" value="crear">

                        <!-- Estilo flotante -->
                        <div class="mb-3 form-group">
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder=" " required>
                            <label for="nombre" class="form-label"><span>Nombre</span></label>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="email" class="form-control" id="email" name="email" placeholder=" " required>
                            <label for="email" class="form-label">Email</label>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder=" " required>
                            <label for="contrasena" class="form-label">Contraseña</label>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="text" class="form-control" id="telefono" name="telefono" placeholder=" " required>
                            <label for="telefono" class="form-label">Teléfono</label>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="text" class="form-control" id="direccion" name="direccion" placeholder=" " required>
                            <label for="direccion" class="form-label">Dirección</label>
                        </div>

                        <div class="mb-3 form-group">
                            <input type="text" class="form-control" id="estado" name="estado" placeholder=" " required>
                            <label for="estado" class="form-label">Estado</label>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btx-flotante-c btx-flotante-c-header" data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btx-flotante btx-flotante-header">Agregar Cliente</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Mostrar lista de clientes -->
    <%
        ClienteDAO clienteDAO = new ClienteDAO();
        List<Cliente> clientes = null;
        try {
            clientes = clienteDAO.obtenerClientes();
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
                <th>Contraseña</th>
                <th>Teléfono</th>
                <th>Dirección</th>
                <th>Estado</th>
                <th>Creado en</th>
                <th>Actualizado en</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                for (Cliente cliente : clientes) {
            %>
            <tr>
                <td><%= cliente.getId() %></td>
                <td><%= cliente.getNombre() %></td>
                <td><%= cliente.getEmail() %></td>
                <td><%= cliente.getContrasena() %></td>
                <td><%= cliente.getTelefono() %></td>
                <td><%= cliente.getDireccion() %></td>
                <td><%= cliente.getEstado() %></td>
                <td><%= cliente.getCreadoEn().format(formatter) %></td>
                <td><%= cliente.getActualizadoEn().format(formatter) %></td>

                <td style="display: flex; align-items: center;" class="cliente-acciones">
                    <!-- Botón actualizar -->
                    <button type="button" class="btn btn-transparent" data-bs-toggle="modal" data-bs-target="#actualizarClienteModal<%= cliente.getId() %>">
                        <i class="fa-regular fa-pen-to-square"></i>
                    </button>

                    <div style="margin-left: 10px;"></div>

                    <!-- Botón eliminar -->
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteModalCliente" onclick="setDeleteClienteId(<%= cliente.getId() %>)">
                        <i class="fa-regular fa-trash-can"></i>
                    </button>
                </td>

                <!-- Modal de Confirmación de Eliminación -->
                <div class="modal fade" id="confirmDeleteModalCliente" tabindex="-1" aria-labelledby="confirmDeleteModalClienteLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmDeleteModalClienteLabel">
                                    <i class="fa-solid fa-spinner fa-spin-pulse"></i> Advertencia
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body text-center">
                                <i class="fa-solid fa-poo-bolt fa-beat-fade" style="--fa-beat-fade-opacity: 0.1; --fa-beat-fade-scale: 1.25; font-size: 2rem;"></i>
                                <p>¿Estás seguro de que deseas eliminar este cliente? <br>Esta acción no se puede deshacer.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btx-flotante btx-flotante-headery" data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btx-flotante-c btx-flotante-c-headery" id="confirmDeleteClienteButton">Eliminar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal para actualizar cliente -->
                <div class="modal fade" id="actualizarClienteModal<%= cliente.getId() %>" tabindex="-1" aria-labelledby="actualizarClienteModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/ClienteServlet2" method="post">
                                <div class="modal-header">
                                    <h5 class="modal-title">Actualizar cliente</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="accion" value="actualizar">
                                    <input type="hidden" name="id" value="<%= cliente.getId() %>">
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="nombre<%= cliente.getId() %>" name="nombre" value="<%= cliente.getNombre() %>" placeholder=" " required>
                                        <label for="nombre<%= cliente.getId() %>" class="form-label"><span>Nombre</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="email" class="form-control" id="email<%= cliente.getId() %>" name="email" value="<%= cliente.getEmail() %>" placeholder=" " required>
                                        <label for="email<%= cliente.getId() %>" class="form-label"><span>Email</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="password" class="form-control" id="contrasena<%= cliente.getId() %>" name="contrasena" value="<%= cliente.getContrasena() %>" placeholder=" " required>
                                        <label for="contrasena<%= cliente.getId() %>" class="form-label"><span>Contraseña</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="telefono<%= cliente.getId() %>" name="telefono" value="<%= cliente.getTelefono() %>" placeholder=" " required>
                                        <label for="telefono<%= cliente.getId() %>" class="form-label"><span>Teléfono</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="direccion<%= cliente.getId() %>" name="direccion" value="<%= cliente.getDireccion() %>" placeholder=" " required>
                                        <label for="direccion<%= cliente.getId() %>" class="form-label"><span>Dirección</span></label>
                                    </div>
                                    <div class="mb-3 form-group">
                                        <input type="text" class="form-control" id="estado<%= cliente.getId() %>" name="estado" value="<%= cliente.getEstado() %>" placeholder=" " required>
                                        <label for="estado<%= cliente.getId() %>" class="form-label"><span>Estado</span></label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btx-flotante-c btx-flotante-c-headery" data-bs-dismiss="modal">Cerrar</button>
                                    <button type="submit" class="btx-flotante btx-flotante-header">Guardar Cambios</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
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
    <div class="alert alert-danger" role="alert">Error al obtener clientes: <%= e.getMessage() %></div>
    <%
        }
    %>
</section>
<!-- ================ Cliente Fin ================= -->

<!-- Script para la eliminación de clientes -->
<script>
    let deleteClienteId;

    function setDeleteClienteId(id) {
        deleteClienteId = id;
    }

    document.getElementById('confirmDeleteClienteButton').onclick = function() {
        const form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/ClienteServlet2';

        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'accion';
        actionInput.value = 'eliminar';
        form.appendChild(actionInput);

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = deleteClienteId;
        form.appendChild(idInput);

        document.body.appendChild(form);
        form.submit();
    };
</script>
        
        
        
        

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




        <script>
            let deleteId;

            function setDeleteId(id) {
                deleteId = id; // Guarda el ID del empleado que se va a eliminar
            }

            document.getElementById('confirmDeleteButton').onclick = function () {
                // Crear un formulario dinámicamente
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '${pageContext.request.contextPath}/EmpleadoServlet';

                // Crear un input para la acción de eliminar
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'accion';
                actionInput.value = 'eliminar';
                form.appendChild(actionInput);

                // Crear un input para el ID del empleado
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = deleteId; // Usar el ID guardado
                form.appendChild(idInput);

                // Agregar el formulario al documento y enviarlo
                document.body.appendChild(form);
                form.submit();
            };
        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>

        <!-- Estilo de carrusel -->
        <script src="../otros/cr.js" type="text/javascript"></script>
    </body>
</html>