package controlador;

import dao.CategoriaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet("/ObtenerIngresoPorCategoria")
public class CategoriaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Get month and year parameters
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");
        
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        Gson gson = new Gson();
        
        try {
            // Pass month and year to the DAO method
            List<Object[]> ingresosPorCategoria = categoriaDAO.obtenerIngresoPorCategoria(monthParam, yearParam);
            
            List<Map<String, Object>> chartData = new ArrayList<>();
            for (Object[] categoria : ingresosPorCategoria) {
                Map<String, Object> item = new HashMap<>();
                item.put("name", categoria[0]);
                item.put("value", categoria[1]);
                chartData.add(item);
            }
            
            String jsonResponse = gson.toJson(chartData);
            response.getWriter().write(jsonResponse);
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson("Error: " + e.getMessage()));
        }
    }
}