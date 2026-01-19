package controlador;

import dao.ClienteDAO;
import modelo.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ClienteServlet2")
public class ClienteServlet2 extends HttpServlet {

       private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        String mensaje = null;

        try {
            if ("crear".equals(accion)) {
                mensaje = crearCliente(request);
            } else if ("actualizar".equals(accion)) {
                mensaje = actualizarCliente(request);
            } else if ("eliminar".equals(accion)) {
                mensaje = eliminarCliente(request);
            } else {
                mensaje = "Acción no reconocida";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            mensaje = "Error en la operación: " + e.getMessage();
        }

        // Enviar el mensaje de éxito o error al JSP
        request.setAttribute("mensaje", mensaje);
        response.sendRedirect(request.getContextPath() + "/vistas/bd.jsp");
    }

    private String crearCliente(HttpServletRequest request) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setNombre(request.getParameter("nombre"));
        cliente.setEmail(request.getParameter("email"));
        cliente.setContrasena(request.getParameter("contrasena"));
        cliente.setTelefono(request.getParameter("telefono"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setEstado(request.getParameter("estado"));
        clienteDAO.agregarCliente(cliente);
        return "Cliente creado exitosamente";
    }

    private String actualizarCliente(HttpServletRequest request) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setId(Long.parseLong(request.getParameter("id")));
        cliente.setNombre(request.getParameter("nombre"));
        cliente.setEmail(request.getParameter("email"));
        cliente.setContrasena(request.getParameter("contrasena"));
        cliente.setTelefono(request.getParameter("telefono"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setEstado(request.getParameter("estado"));
        clienteDAO.actualizarCliente(cliente);
        return "Cliente actualizado exitosamente";
    }

    private String eliminarCliente(HttpServletRequest request) throws SQLException {
        long id = Long.parseLong(request.getParameter("id"));
        clienteDAO.eliminarCliente(id);
        return "Cliente eliminado exitosamente";
    }
}
