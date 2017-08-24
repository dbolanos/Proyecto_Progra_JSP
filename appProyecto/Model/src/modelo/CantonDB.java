package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;

public class CantonDB {
    private AccesoDatos accesoDatos = new AccesoDatos();
    private String tabla = "cantones";

    public CantonDB() {
        super();
    }

    private LinkedList<Canton> obtener(String strSQL) throws SNMPExceptions, SQLException {
        ResultSet rsCantones = null;
        LinkedList<Canton> cantones = new LinkedList<Canton>();
        try {
            rsCantones = this.accesoDatos.ejecutaSQLRetornaRS(strSQL);
            while (rsCantones.next()) {
                int id = rsCantones.getInt("id");
                int idProvincia = rsCantones.getInt("id_provincia");
                String nombre = rsCantones.getString("nombre");
                Canton canton = new Canton(id, idProvincia, nombre);
                cantones.add(canton);
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsCantones);
        }
        return cantones;
    }

    public void guardar(Canton canton) throws SNMPExceptions, SQLException {
        String strSQL = "";
        try {
            strSQL = "INSERT INTO " + this.getTabla() + " (id_provincia, nombre) VALUES (" + canton.getIdProvincia() + ",'" + canton.getNombre() + "')";
            this.accesoDatos.ejecutaSQL(strSQL);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Canton> obtenerPorId(int id) throws SNMPExceptions, SQLException {
        String select = "";
        try {
            select = "SELECT id, id_provincia, nombre FROM " + this.getTabla() + " WHERE id = " + id;
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Canton> obtenerPorProvincia(int idProvincia) throws SNMPExceptions, SQLException {
        String select = "";
        try {
            select = "SELECT id, id_provincia, nombre FROM " + this.getTabla() + " WHERE id_provincia = " + idProvincia;
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public void actualizar(Canton canton) throws SNMPExceptions, SQLException, NamingException {
        //Datos de Medicamento
        int id = canton.getId();
        int idProvincia = canton.getIdProvincia();
        String nombre = canton.getNombre();
        //Se crea la sentencia de actualización
        String update = "UPDATE " + this.getTabla() + " SET nombre = '" + nombre + "', id_provincia = " + idProvincia + " WHERE id = " + id;
        //Se ejecuta la sentencia SQL
        accesoDatos.ejecutaSQL(update);
    }

    public boolean existe(int id) throws SNMPExceptions, SQLException {
        ResultSet rsCanton = null;
        String select = "";
        boolean existe = false;
        try {
            select = "SELECT id FROM " + this.getTabla() + " WHERE id =" + id;
            //Se ejecuta la sentencia SQL
            rsCanton = accesoDatos.ejecutaSQLRetornaRS(select);
            if (rsCanton.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsCanton);
        }
        return existe;
    }

    public void eliminar(int id) throws SNMPExceptions, SQLException, NamingException {
        String delete = "DELETE FROM " + this.getTabla() + " WHERE id = " + id;
        accesoDatos.ejecutaSQL(delete);
    }

    public LinkedList<Canton> todo() throws SNMPExceptions, SQLException {
        String select = "";
        try {
            //Se crea la sentencia de búsqueda
            select = "SELECT id, id_provincia, nombre FROM " + this.getTabla();
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
