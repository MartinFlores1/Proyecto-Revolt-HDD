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
import conexion.Conexion;

@WebServlet("/CantidadUsuariosServlet")
public class CantidadUsuariosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
            SELECT COUNT(DISTINCT cliente_id) AS customer_count 
            FROM ordenes 
            WHERE estado = 'confirmado'
            %s
            """;

            // Build dynamic where clause based on parameters
            StringBuilder whereClause = new StringBuilder();
            if (yearParam != null && !yearParam.isEmpty()) {
                whereClause.append(" AND YEAR(actualizado_en) = ?");
            }
            if (monthParam != null && !monthParam.isEmpty()) {
                whereClause.append(" AND MONTH(actualizado_en) = ?");
            }

            sql = String.format(sql, whereClause.toString());

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                int paramIndex = 1;
                if (yearParam != null && !yearParam.isEmpty()) {
                    pstmt.setInt(paramIndex++, Integer.parseInt(yearParam));
                }
                if (monthParam != null && !monthParam.isEmpty()) {
                    pstmt.setInt(paramIndex, Integer.parseInt(monthParam));
                }

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int customerCount = rs.getInt("customer_count");
                        response.getWriter().write("{\"customerCount\": " + customerCount + "}");
                    } else {
                        response.getWriter().write("{\"customerCount\": 0}");
                    }
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}