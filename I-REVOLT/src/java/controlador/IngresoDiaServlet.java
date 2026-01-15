package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import conexion.Conexion;
import com.google.gson.Gson;

@WebServlet("/IngresoDiaServlet")
public class IngresoDiaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String yearParam = request.getParameter("year");
        String monthParam = request.getParameter("month");

        try {
            RadarChartData chartData = fetchRadarChartData(yearParam, monthParam);
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(chartData));
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private RadarChartData fetchRadarChartData(String yearParam, String monthParam) throws SQLException {
        String baseSql = "SELECT " +
                "DATEPART(dw, o.actualizado_en) AS dia_semana, " +
                "SUM(do.cantidad * do.precio_unitario) AS total_ventas " +
                "FROM ordenes o " +
                "JOIN detalles_orden do ON o.id = do.orden_id " +
                "WHERE o.estado = 'confirmado' %s " +
                "GROUP BY DATEPART(dw, o.actualizado_en)";

        String whereClause = "";
        List<Object> params = new ArrayList<>();

        if (yearParam != null && !yearParam.isEmpty()) {
            whereClause += " AND YEAR(o.actualizado_en) = ?";
            params.add(Integer.parseInt(yearParam));
        }

        if (monthParam != null && !monthParam.isEmpty()) {
            whereClause += " AND MONTH(o.actualizado_en) = ?";
            params.add(Integer.parseInt(monthParam));
        }

        String sql = String.format(baseSql, whereClause);

        List<RadarIndicator> indicators = new ArrayList<>();
        List<Double> values = new ArrayList<>();
        double maxValue = 0;

        try (Connection conn = Conexion.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set parameters dynamically
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                // Mapeo de días de la semana (1 = Domingo, 2 = Lunes, etc.)
                String[] diasSemana = {"Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sá"};

                // Inicializar valores para cada día
                for (int i = 0; i < 7; i++) {
                    indicators.add(new RadarIndicator(diasSemana[i], 1000));
                    values.add(0.0);
                }

                while (rs.next()) {
                    int diaSemana = rs.getInt("dia_semana");
                    double totalVentas = rs.getDouble("total_ventas");

                    // Ajustar índice para coincidir con el arreglo (1 = Domingo -> índice 0)
                    int index = (diaSemana % 7);
                    values.set(index, totalVentas);
                    maxValue = Math.max(maxValue, totalVentas);
                }

                // Actualizar máximo para los indicadores
                for (RadarIndicator indicator : indicators) {
                    indicator.max = Math.max(1000, maxValue * 1.2);
                }
            }
        }

        return new RadarChartData(indicators, values);
    }

    // Clases internas para estructurar los datos
    private static class RadarChartData {
        List<RadarIndicator> indicators;
        List<Double> values;

        RadarChartData(List<RadarIndicator> indicators, List<Double> values) {
            this.indicators = indicators;
            this.values = values;
        }
    }

    private static class RadarIndicator {
        String text;
        double max;

        RadarIndicator(String text, double max) {
            this.text = text;
            this.max = max;
        }
    }
}
