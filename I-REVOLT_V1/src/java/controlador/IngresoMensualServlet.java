package controlador;

import dao.IngresoMesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/IngresoMensualServlet")
public class IngresoMensualServlet extends HttpServlet {
    private IngresoMesDAO revenueDAO = new IngresoMesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Get month and year parameters
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");
        
        try (PrintWriter out = response.getWriter()) {
            // Call DAO method with optional filtering
            List<Double> revenues = revenueDAO.getIngresoMensual(monthParam, yearParam);
            
            StringBuilder json = new StringBuilder("{\"months\":[\"Ene\",\"Feb\",\"Mar\",\"Abr\",\"May\",\"Jun\",\"Jul\",\"Ago\",\"Sep\",\"Oct\",\"Nov\",\"Dic\"],\"revenues\":[");
            for (int i = 0; i < revenues.size(); i++) {
                json.append(revenues.get(i));
                if (i < revenues.size() - 1) json.append(",");
            }
            json.append("]}");
            out.print(json.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}