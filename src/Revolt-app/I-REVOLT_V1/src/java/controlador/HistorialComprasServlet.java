package controlador;

import dao.HistorialComprasDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import modelo.HistorialCompra;

@WebServlet(name = "HistorialComprasServlet", urlPatterns = {"/HistorialComprasServlet"})
public class HistorialComprasServlet extends HttpServlet {

    private final HistorialComprasDAO historialDAO = new HistorialComprasDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el idCliente de la solicitud
        int clienteId = (Integer) request.getAttribute("idCliente");

        try {
            // Llamamos al método del DAO para obtener el historial de compras
            List<HistorialCompra> historial = historialDAO.obtenerHistorialCompras(clienteId);

            // Pasamos los resultados a la vista JSP
            request.setAttribute("historial", historial);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/vistas/hCompras.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            // Manejo de excepciones, loguear el error
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener historial de compras.");
        }
    }
}
