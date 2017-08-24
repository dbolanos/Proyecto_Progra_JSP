package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.LinkedList;


public class ClienteDB {
    private String tabla = "clientes";
    AccesoDatos accesoDatos = new AccesoDatos();


    public ClienteDB() {
        super();
    }


    public String guardarCliente(Cliente cliente) throws SNMPExceptions, SQLException {
        String strSQL = "";
        int resultado = 0;
        try {
            strSQL =
                    "INSERT INTO " + this.getTabla() + " (nombre, provincia, canton, distrito, barrio, otras_sennas, email, id_tipo_telefono, telefono, descuento, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita, activo) VALUES " +
                    "('" + cliente.getNombre() + "', '" + cliente.getProvincia() + "', '" + cliente.getCanton() + "','" + cliente.getDistrito() + "', '" + cliente.getBarrio() + "','" +
                    cliente.getOtrasSennas() + "','" + cliente.getEmail() + "', " + cliente.getIdTipoTelefono() + ", '" + cliente.getTelefono() + "'," + cliente.getDescuento() + "," +
                    cliente.getUsuarioRegistra() + ",'" + cliente.getFechaUsuarioRegistra() + "'," + cliente.getUsuarioEdita() + ",'" + cliente.getFechaUsuarioEdita() + "'," + cliente.getActivo() +
                    ")";
            resultado = this.accesoDatos.ejecutaSQL(strSQL);
            if (resultado == 1) {
                return "Cliente Almacenado correctamente";
            } else {
                return "Error, No se almaceno el cliente";
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }


    public LinkedList<Cliente> obtenerClienteOrdenCombo() throws SNMPExceptions, SQLException {
        String select = "";
        ResultSet rsCliente = null;
        LinkedList<Cliente> lstCliente = new LinkedList<Cliente>();

        select = "SELECT ID, NOMBRE, ACTIVO FROM " + this.getTabla();
        try {
            rsCliente = accesoDatos.ejecutaSQLRetornaRS(select);
            while (rsCliente.next()) {
                Cliente cliente = new Cliente();
                cliente.setId(rsCliente.getInt("ID"));
                cliente.setNombre(rsCliente.getString("NOMBRE"));
                lstCliente.add(cliente);
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return lstCliente;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getTabla() {
        return tabla;
    }
}

