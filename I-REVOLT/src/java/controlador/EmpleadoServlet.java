package controlador;

import dao.EmpleadoDAO;
import modelo.Empleado;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EmpleadoServlet")
public class EmpleadoServlet extends HttpServlet {

    private EmpleadoDAO empleadoDAO = new EmpleadoDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        String mensaje = null;

        try {
            if ("crear".equals(accion)) {
                mensaje = crearEmpleado(request);
            } else if ("actualizar".equals(accion)) {
                mensaje = actualizarEmpleado(request);
            } else if ("eliminar".equals(accion)) {
                mensaje = eliminarEmpleado(request);
            } else {
                mensaje = "Acción no reconocida";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            mensaje = "Error en la operación: " + e.getMessage();
        }

        // Enviar el mensaje de éxito o error al JSP
        request.setAttribute("mensaje", mensaje);
        response.sendRedirect(request.getContextPath() + "/vistas/bd.jsp");

    }

    private String crearEmpleado(HttpServletRequest request) throws SQLException {
        Empleado empleado = new Empleado();
        empleado.setNombre(request.getParameter("nombre"));
        empleado.setEmail(request.getParameter("email"));
        empleado.setContrasena(request.getParameter("contrasena"));
        empleado.setRol(request.getParameter("rol"));
        empleado.setTelefono(request.getParameter("telefono"));
        empleado.setPuesto(request.getParameter("puesto"));
        empleado.setEstado(request.getParameter("estado"));
        empleadoDAO.agregarEmpleado(empleado);
        return "Empleado creado exitosamente";
    }

    private String actualizarEmpleado(HttpServletRequest request) throws SQLException {
        Empleado empleado = new Empleado();
        empleado.setIdEmpleado(Long.parseLong(request.getParameter("id")));
        empleado.setNombre(request.getParameter("nombre"));
        empleado.setEmail(request.getParameter("email"));
        empleado.setContrasena(request.getParameter("contrasena"));
        empleado.setRol(request.getParameter("rol"));
        empleado.setTelefono(request.getParameter("telefono"));
        empleado.setPuesto(request.getParameter("puesto"));
        empleado.setEstado(request.getParameter("estado"));
        empleadoDAO.actualizarEmpleado(empleado);
        return "Empleado actualizado exitosamente";
    }

    private String eliminarEmpleado(HttpServletRequest request) throws SQLException {
        long id = Long.parseLong(request.getParameter("id"));
        empleadoDAO.eliminarEmpleado(id);
        return "Empleado eliminado exitosamente";
    }
}
