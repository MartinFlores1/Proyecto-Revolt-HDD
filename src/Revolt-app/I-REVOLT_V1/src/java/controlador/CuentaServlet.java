package controlador;

import dao.ClienteDAO;
import modelo.Cliente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CuentaServlet", urlPatterns = {"/CuentaServlet"})
public class CuentaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Leer el parámetro "idCliente" del request
        String idClienteParam = request.getParameter("idCliente");

        if (idClienteParam == null || idClienteParam.isEmpty()) {
            // Si no se proporciona un ID, devolver un mensaje de error
            response.getWriter().println("ID del cliente no especificado.");
            return;
        }

        try {
            // Convertir el ID del cliente a un número
            long idCliente = Long.parseLong(idClienteParam);

            // Crear instancia de ClienteDAO
            ClienteDAO clienteDAO = new ClienteDAO();

            // Buscar el cliente por ID
            Cliente cliente = clienteDAO.buscarClientePorId(idCliente);

            if (cliente != null) {
                // Establecer los atributos de la solicitud para mostrarlos en la vista
                request.setAttribute("nombre", cliente.getNombre());
                request.setAttribute("email", cliente.getEmail());
                request.setAttribute("telefono", cliente.getTelefono());
                request.setAttribute("direccion", cliente.getDireccion());
                // Redirigir a la página que mostrará la cuenta del cliente 
                request.getRequestDispatcher("/vistas/cuenta.jsp").forward(request, response);
            } else {
                // Si no se encuentra el cliente, mostrar un mensaje de error
                response.getWriter().println("Cliente no encontrado.");
            }
        } catch (NumberFormatException e) {
            // Manejo de errores de conversión
            response.getWriter().println("El ID del cliente debe ser un número válido.");
        } catch (Exception e) {
            // Manejo de errores generales
            e.printStackTrace();
            response.getWriter().println("Error al recuperar los datos del cliente.");
        }
    }
}
