package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;

public class DistritoDB {
    private AccesoDatos accesoDatos = new AccesoDatos();
    private String tabla = "distritos";

    public DistritoDB() {
        super();
    }

    private LinkedList<Distrito> obtener(String strSQL) throws SNMPExceptions, SQLException {
        ResultSet rsDistritos = null;
        LinkedList<Distrito> distritos = new LinkedList<Distrito>();
        try {
            rsDistritos = this.accesoDatos.ejecutaSQLRetornaRS(strSQL);
            while (rsDistritos.next()) {
                int id = rsDistritos.getInt("id");
                int idCanton = rsDistritos.getInt("id_canton");
                String nombre = rsDistritos.getString("nombre");
                Distrito Distrito = new Distrito(id, idCanton, nombre);
                distritos.add(Distrito);
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsDistritos);
        }
        return distritos;
    }

    public void guardar(Distrito distrito) throws SNMPExceptions, SQLException {
        String strSQL = "";
        try {
            strSQL = "INSERT INTO " + this.getTabla() + " (id_canton, nombre) VALUES (" + distrito.getIdCanton() + ",'" + distrito.getNombre() + "')";
            this.accesoDatos.ejecutaSQL(strSQL);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Distrito> obtenerPorId(int id) throws SNMPExceptions, SQLException {
        String select = "";
        try {
            select = "SELECT id, id_canton, nombre FROM " + this.getTabla() + " WHERE id = " + id;
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Distrito> obtenerPorCanton(int idCanton) throws SNMPExceptions, SQLException {
        String select = "";
        try {
            select = "SELECT id, id_canton, nombre FROM " + this.getTabla() + " WHERE id_canton = " + idCanton;
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public void actualizar(Distrito Distrito) throws SNMPExceptions, SQLException, NamingException {
        //Datos de Medicamento
        int id = Distrito.getId();
        int idCanton = Distrito.getIdCanton();
        String nombre = Distrito.getNombre();
        //Se crea la sentencia de actualización
        String update = "UPDATE " + this.getTabla() + " SET nombre = '" + nombre + "', id_canton = " + idCanton + " WHERE id = " + id;
        //Se ejecuta la sentencia SQL
        accesoDatos.ejecutaSQL(update);
    }

    public boolean existe(int id) throws SNMPExceptions, SQLException {
        ResultSet rsDistrito = null;
        String select = "";
        boolean existe = false;
        try {
            select = "SELECT id FROM " + this.getTabla() + " WHERE id =" + id;
            //Se ejecuta la sentencia SQL
            rsDistrito = accesoDatos.ejecutaSQLRetornaRS(select);
            if (rsDistrito.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsDistrito);
        }
        return existe;
    }

    public void eliminar(int id) throws SNMPExceptions, SQLException, NamingException {
        String delete = "DELETE FROM " + this.getTabla() + " WHERE id = " + id;
        accesoDatos.ejecutaSQL(delete);
    }

    public LinkedList<Distrito> todo() throws SNMPExceptions, SQLException {
        String select = "";
        try {
            //Se crea la sentencia de búsqueda
            select = "SELECT id, id_canton, nombre FROM " + this.getTabla();
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
