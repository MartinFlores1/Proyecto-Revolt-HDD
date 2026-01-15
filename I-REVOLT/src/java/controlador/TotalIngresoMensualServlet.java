package controlador;

import dao.TotalRevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;

@WebServlet("/TotalIngresoMensualServlet")
public class TotalIngresoMensualServlet extends HttpServlet {
    private TotalRevenueDAO revenueDAO = new TotalRevenueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Get month and year parameters
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        try (PrintWriter out = response.getWriter()) {
            // Call DAO method to get total monthly revenue
            double totalRevenue = revenueDAO.getTotalIngresoMensual(monthParam, yearParam);
            
            // Format the response as JSON with two decimal places
            DecimalFormat df = new DecimalFormat("#.00");
            String jsonResponse = String.format("{\"totalRevenue\": %.2f}", totalRevenue);
            out.print(jsonResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}
