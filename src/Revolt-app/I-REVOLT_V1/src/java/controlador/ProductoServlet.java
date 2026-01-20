package controlador;

import dao.ProductoDAO;
import modelo.Producto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    private ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            List<Producto> productos = productoDAO.obtenerProducto();
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < productos.size(); i++) {
                Producto p = productos.get(i);
                json.append("{")
                        .append("\"id\":").append(p.getId()).append(",")
                        .append("\"name\":\"").append(p.getNombre()).append("\",")
                        .append("\"price\":").append(p.getPrecio()).append(",")
                        .append("\"category\":\"").append(p.getCategoriaNombre()).append("\",") // Cambiado
                        .append("\"brand\":\"").append(p.getMarca_nombre()).append("\",")
                        .append("\"color\":\"").append(p.getColor_nombre()).append("\",")
                        .append("\"description\":\"").append(p.getDescripcion()).append("\",")
                        .append("\"image\":\"").append(p.getImage_dir()).append("\"")
                        .append("}");
                if (i < productos.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            out.print(json.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}
