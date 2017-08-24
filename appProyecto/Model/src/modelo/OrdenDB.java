package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;

public class OrdenDB {
    private AccesoDatos accesoDatos = new AccesoDatos();
    private String tabla = "ordenes";

    public OrdenDB() {
        super();
    }

    private LinkedList<Orden> obtener(String strSQL) throws SNMPExceptions, SQLException {
        ResultSet rsOrdenes = null;
        LinkedList<Orden> ordenes = new LinkedList<Orden>();
        try {
            rsOrdenes = this.accesoDatos.ejecutaSQLRetornaRS(strSQL);
            while (rsOrdenes.next()) {
                int id = rsOrdenes.getInt("id");
                String fechaEjecucion = rsOrdenes.getString("fecha_ejecucion");
                int idCliente = rsOrdenes.getInt("id_cliente");
                int idServicio = rsOrdenes.getInt("id_servicio");
                double estimacionHorasDuracion = rsOrdenes.getDouble("estimacion_horas_duracion");
                String lugarServicio = rsOrdenes.getString("lugar_servicio");
                int idDistrito = rsOrdenes.getInt("id_distrito");
                String otrasSennas = rsOrdenes.getString("otras_sennas");
                String detalleServicio = rsOrdenes.getString("detalle_servicio");
                String costosVariablesDescripcion = rsOrdenes.getString("costos_variables_descripcion");
                double costosVariablesMonto = rsOrdenes.getDouble("costos_variables_monto");
                String estado = rsOrdenes.getString("estado");
                int idUsuarioRegistra = rsOrdenes.getInt("id_usuario_registra");
                String fechaRegistra = rsOrdenes.getString("fecha_registra");
                int idUsuarioEdita = rsOrdenes.getInt("id_usuario_edita");
                String fechaEdita = rsOrdenes.getString("fecha_edita");

                Orden orden =
                    new Orden(id, fechaEjecucion, idCliente, idServicio, estimacionHorasDuracion, lugarServicio, idDistrito, otrasSennas, detalleServicio, costosVariablesDescripcion, costosVariablesMonto,
                              estado, idUsuarioRegistra, fechaRegistra, idUsuarioEdita, fechaEdita);
                ordenes.add(orden);
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsOrdenes);
        }
        return ordenes;
    }

    public Orden guardar(Orden orden) throws SNMPExceptions, SQLException {
        String strSQL = "";
        try {
            //Datos de Medicamento
            int id = orden.getId();
            String fechaEjecucion = orden.getFechaEjecucion();
            int idCliente = orden.getIdCliente();
            int idServicio = orden.getIdServicio();
            double estimacionHorasDuracion = orden.getEstimacionHorasDuracion();
            String lugarServicio = orden.getLugarServicio();
            int idDistrito = orden.getIdDistrito();
            String otrasSennas = orden.getOtrasSennas();
            String detalleServicio = orden.getDetalleServicio();
            String costosVariablesDescripcion = orden.getCostosVariablesDescripcion();
            double costosVariablesMonto = orden.getCostosVariablesMonto();
            String estado = orden.getEstado();
            int idUsuarioRegistra = orden.getIdUsuarioRegistra();
            String fechaRegistra = orden.getFechaRegistra();
            int idUsuarioEdita = orden.getIdUsuarioEdita();
            String fechaEdita = orden.getFechaEdita();
            strSQL =
                    "INSERT INTO " + this.getTabla() + " (fecha_ejecucion,id_cliente,id_servicio,estimacion_horas_duracion,lugar_servicio,id_distrito,otras_sennas,detalle_servicio,costos_variables_descripcion,costos_variables_monto,estado,id_usuario_registra,fecha_registra,id_usuario_edita,fecha_edita) VALUES ('" +
                    fechaEjecucion + "'," + idCliente + "," + idServicio + "," + estimacionHorasDuracion + ",'" + lugarServicio + "'," + idDistrito + ",'" + otrasSennas + "','" + detalleServicio +
                    "','" + costosVariablesDescripcion + "'," + costosVariablesMonto + ",'" + estado + "'," + idUsuarioRegistra + ",'" + fechaRegistra + "'," + idUsuarioEdita + ",'" + fechaEdita +
                    "');SELECT id,fecha_ejecucion,id_cliente,id_servicio,estimacion_horas_duracion,lugar_servicio,id_distrito,otras_sennas,detalle_servicio,costos_variables_descripcion,costos_variables_monto,estado,id_usuario_registra,fecha_registra,id_usuario_edita,fecha_edita FROM " +
                    this.getTabla() + " WHERE id = SCOPE_IDENTITY();";
            return this.obtener(strSQL).getFirst();
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Orden> obtenerPorId(int id) throws SNMPExceptions, SQLException {
        String select = "";
        try {
            select =
                    "SELECT id,fecha_ejecucion,id_cliente,id_servicio,estimacion_horas_duracion,lugar_servicio,id_distrito,otras_sennas,detalle_servicio,costos_variables_descripcion,costos_variables_monto,estado,id_usuario_registra,fecha_registra,id_usuario_edita,fecha_edita FROM " +
                    this.getTabla() + " WHERE id = " + id;
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public void actualizar(Orden orden) throws SNMPExceptions, SQLException, NamingException {
        //Datos de Medicamento
        int id = orden.getId();
        String fechaEjecucion = orden.getFechaEjecucion();
        int idCliente = orden.getIdCliente();
        int idServicio = orden.getIdServicio();
        double estimacionHorasDuracion = orden.getEstimacionHorasDuracion();
        String lugarServicio = orden.getLugarServicio();
        int idDistrito = orden.getIdDistrito();
        String otrasSennas = orden.getOtrasSennas();
        String detalleServicio = orden.getDetalleServicio();
        String costosVariablesDescripcion = orden.getCostosVariablesDescripcion();
        double costosVariablesMonto = orden.getCostosVariablesMonto();
        String estado = orden.getEstado();
        int idUsuarioRegistra = orden.getIdUsuarioRegistra();
        String fechaRegistra = orden.getFechaRegistra();
        int idUsuarioEdita = orden.getIdUsuarioEdita();
        String fechaEdita = orden.getFechaEdita();
        //Se crea la sentencia de actualización
        String update =
            "UPDATE " + this.getTabla() + " SET fecha_ejecucion = '" + fechaEjecucion + "', id_cliente = " + idCliente + ", id_servicio =" + idServicio + ", estimacion_horas_duracion = '" +
            estimacionHorasDuracion + "',lugar_servicio = '" + lugarServicio + "',id_distrito = '" + idDistrito + "',otras_sennas '" + otrasSennas + "', detalle_servicio = '" + detalleServicio +
            "',costos_variables_descripcion ='" + costosVariablesDescripcion + "', costos_variables_monto = " + costosVariablesMonto + ", estado = '" + estado + "',id_usuario_registra = " +
            idUsuarioRegistra + ",fecha_registra = '" + fechaRegistra + "',id_usuario_edita = " + idUsuarioEdita + ",fecha_edita = '" + fechaEdita + "' WHERE id = " + id;
        //Se ejecuta la sentencia SQL
        accesoDatos.ejecutaSQL(update);
    }

    public boolean existe(int id) throws SNMPExceptions, SQLException {
        ResultSet rsOrden = null;
        String select = "";
        boolean existe = false;
        try {
            select = "SELECT id FROM " + this.getTabla() + " WHERE id =" + id;
            //Se ejecuta la sentencia SQL
            rsOrden = accesoDatos.ejecutaSQLRetornaRS(select);
            if (rsOrden.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsOrden);
        }
        return existe;
    }

    public void eliminar(int id) throws SNMPExceptions, SQLException, NamingException {
        String delete = "DELETE FROM " + this.getTabla() + " WHERE id = " + id;
        accesoDatos.ejecutaSQL(delete);
    }

    public LinkedList<Orden> todo() throws SNMPExceptions, SQLException {
        String select = "";
        try {
            //Se crea la sentencia de búsqueda
            select =
                    "SELECT id,fecha_ejecucion,id_cliente,id_servicio,estimacion_horas_duracion,lugar_servicio,id_distrito,otras_sennas,detalle_servicio,costos_variables_descripcion,costos_variables_monto,estado,id_usuario_registra,fecha_registra,id_usuario_edita,fecha_edita FROM " +
                    this.getTabla();
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public String getTabla() {
        return tabla;
    }
}
