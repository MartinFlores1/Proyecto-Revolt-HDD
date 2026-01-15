package controlador;

import dao.TotalOrdersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/TotalOrdenesMensualesServlet")
public class TotalOrdenesMensualesServlet extends HttpServlet {
    private TotalOrdersDAO ordersDAO = new TotalOrdersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Get month and year parameters
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        try (PrintWriter out = response.getWriter()) {
            // Call DAO method to get total monthly orders
            int totalOrdenes = ordersDAO.getTotalOrdenesMensuales(monthParam, yearParam);
            
            // Format the response as JSON
            String jsonResponse = String.format("{\"totalOrdenes\": %d}", totalOrdenes);
            out.print(jsonResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}