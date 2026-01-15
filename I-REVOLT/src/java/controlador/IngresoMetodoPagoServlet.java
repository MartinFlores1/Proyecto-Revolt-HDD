package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import conexion.Conexion;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/IngresoMetodoPagoServlet")
public class IngresoMetodoPagoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        try (Connection conn = Conexion.getConexion()) {
            String baseQuery = """
                SELECT  
                    mp.nombre AS payment_method,
                    COUNT(o.id) AS transaction_count,
                    SUM(do.cantidad * do.precio_unitario) AS total_amount,
                    ROUND(SUM(do.cantidad * do.precio_unitario) * 100.0 /  
                          (SELECT SUM(do2.cantidad * do2.precio_unitario)  
                           FROM ordenes o2  
                           JOIN detalles_orden do2 ON o2.id = do2.orden_id 
                           WHERE o2.estado = 'confirmado'), 2) AS percentage
                FROM ordenes o
                JOIN metodos_pago mp ON o.metodo_pago_id = mp.id
                JOIN detalles_orden do ON o.id = do.orden_id
                WHERE o.estado = 'confirmado' %s
                GROUP BY mp.nombre
            """;

            StringBuilder whereClause = new StringBuilder();
            List<Object> params = new ArrayList<>();

            if (yearParam != null && !yearParam.isEmpty()) {
                whereClause.append(" AND YEAR(o.fecha) = ?");
                params.add(Integer.parseInt(yearParam));
            }
            if (monthParam != null && !monthParam.isEmpty()) {
                whereClause.append(" AND MONTH(o.fecha) = ?");
                params.add(Integer.parseInt(monthParam));
            }

            String finalQuery = String.format(baseQuery, whereClause.toString());

            try (PreparedStatement pstmt = conn.prepareStatement(finalQuery)) {
                for (int i = 0; i < params.size(); i++) {
                    pstmt.setObject(i + 1, params.get(i));
                }

                try (ResultSet rs = pstmt.executeQuery()) {
                    List<Map<String, Object>> paymentMethodStats = new ArrayList<>();

                    while (rs.next()) {
                        Map<String, Object> stat = new HashMap<>();
                        stat.put("product", rs.getString("payment_method"));
                        stat.put("score", rs.getDouble("percentage"));
                        stat.put("amount", rs.getDouble("total_amount"));
                        paymentMethodStats.add(stat);
                    }

                    Gson gson = new Gson();
                    String jsonResponse = gson.toJson(paymentMethodStats);
                    response.getWriter().write(jsonResponse);
                }
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching data: " + e.getMessage());
        }
    }
}
