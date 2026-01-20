
package controlador;

import dao.ClienteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import modelo.Cliente;

@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO;
    
    @Override
    public void init() {
        clienteDAO = new ClienteDAO(); // Inicializa el DAO
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtiene los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");

        // Crea un objeto Cliente con los datos del formulario
        Cliente cliente = new Cliente();
        cliente.setNombre(nombre);
        cliente.setEmail(email);
        cliente.setContrasena(contrasena);

        try {
            // Llama al método del DAO para registrar al cliente
            clienteDAO.registrarCliente(cliente);
            // Redirige a una página de éxito o inicio de sesión
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
        } catch (SQLException e) {
            // Manejo de errores
            e.printStackTrace();
            request.setAttribute("error", "Hubo un error al registrar el cliente.");
            request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    
}
