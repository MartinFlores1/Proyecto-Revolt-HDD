package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import conexion.Conexion;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/api/categoria-ingresos")
public class CategoriaIngresosServlet extends HttpServlet {
    private Gson gson;

    public void init() {
        gson = new Gson();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Get month and year parameters
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        try (Connection conn = Conexion.getConexion()) {
            // Base SQL with dynamic filtering
            String sql = """
            SELECT 
                c.nombre AS categoria,
                DATEPART(dw, o.actualizado_en) AS dia_semana,
                SUM(do.cantidad * do.precio_unitario) AS total_ingresos
            FROM 
                ordenes o
            JOIN 
                detalles_orden do ON o.id = do.orden_id
            JOIN 
                productos p ON do.producto_id = p.id
            JOIN 
                categorias c ON p.categoria_id = c.id
            WHERE 
                o.estado = 'confirmado'
                %s
            GROUP BY 
                c.nombre, DATEPART(dw, o.actualizado_en)
            """;

            // Build dynamic where clause based on parameters
            List<Object> params = new ArrayList<>();
            String whereClause = "";
            
            if (yearParam != null && !yearParam.isEmpty()) {
                whereClause += " AND YEAR(o.actualizado_en) = ?";
                params.add(Integer.parseInt(yearParam));
            }
            
            if (monthParam != null && !monthParam.isEmpty()) {
                whereClause += " AND MONTH(o.actualizado_en) = ?";
                params.add(Integer.parseInt(monthParam));
            }

            sql = String.format(sql, whereClause);

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                // Set parameters
                for (int i = 0; i < params.size(); i++) {
                    pstmt.setObject(i + 1, params.get(i));
                }

                // Execute query
                try (ResultSet rs = pstmt.executeQuery()) {
                    Map<String, List<Double>> seriesData = new HashMap<>();
                    List<String> dias = List.of("Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sá");

                    // Initialize data for each category and day
                    List<String> categorias = new ArrayList<>();
                    for (String categoria : getCategorias(conn)) {
                        categorias.add(categoria);
                        seriesData.put(categoria, new ArrayList<>(List.of(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)));
                    }

                    // Populate data
                    while (rs.next()) {
                        String categoria = rs.getString("categoria");
                        int diaSemana = rs.getInt("dia_semana");
                        double totalIngresos = rs.getDouble("total_ingresos");

                        // Adjust day index (SQL DATEPART starts from Sunday=1)
                        int index = (diaSemana - 1 + 7) % 7;
                        
                        if (seriesData.containsKey(categoria)) {
                            seriesData.get(categoria).set(index, totalIngresos);
                        }
                    }

                    // Prepare response
                    Map<String, Object> responseData = new HashMap<>();
                    responseData.put("categorias", categorias);
                    responseData.put("seriesData", new ArrayList<>(seriesData.values()));

                    String jsonResponse = gson.toJson(responseData);
                    response.getWriter().write(jsonResponse);
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    // Helper method to get unique categories
    private List<String> getCategorias(Connection conn) throws SQLException {
        List<String> categorias = new ArrayList<>();
        String sql = "SELECT DISTINCT nombre FROM categorias";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                categorias.add(rs.getString("nombre"));
            }
        }
        return categorias;
    }
}