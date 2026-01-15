package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import modelo.Cliente;
import dao.ClienteDAO;

@WebServlet(name = "EditarPerfilServlet", urlPatterns = {"/EditarPerfilServlet"})
public class EditarPerfilServlet extends HttpServlet {

    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        clienteDAO = new ClienteDAO(); // Asegúrate de que ClienteDAO esté correctamente implementado.
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            actualizarCliente(request);
            // Redirigir a cuenta.jsp después de la actualización
            response.sendRedirect(request.getContextPath() + "/vistas/cuenta.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar el cliente.");
        }
    }

    private void actualizarCliente(HttpServletRequest request) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setId(Long.parseLong(request.getParameter("id")));
        cliente.setNombre(request.getParameter("nombre"));
        cliente.setEmail(request.getParameter("email"));

        // Verificar si la contraseña fue modificada
        String nuevaContrasena = request.getParameter("contrasena");
        if (nuevaContrasena == null || nuevaContrasena.isEmpty() || nuevaContrasena.equals("*********")) {
            // Si no se proporcionó una nueva contraseña (o es igual a los asteriscos), mantener la contraseña actual
            cliente.setContrasena(request.getParameter("contrasena_actual"));
        } else {
            // Si se proporcionó una nueva contraseña, usarla
            cliente.setContrasena(nuevaContrasena);
        }

        cliente.setTelefono(request.getParameter("telefono"));
        cliente.setDireccion(request.getParameter("direccion"));

        clienteDAO.actualizarCliente(cliente);
    }

    @Override
    public void destroy() {
        clienteDAO = null; // Limpieza de recursos
        super.destroy();
    }
}
