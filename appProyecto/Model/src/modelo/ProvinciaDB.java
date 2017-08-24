package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;

public class ProvinciaDB {
    private AccesoDatos accesoDatos = new AccesoDatos();
    private String tabla = "provincias";

    public ProvinciaDB() {
        super();
    }

    private LinkedList<Provincia> obtener(String strSQL) throws SNMPExceptions, SQLException {
        ResultSet rsProvincias = null;
        LinkedList<Provincia> provincias = new LinkedList<Provincia>();
        try {
            rsProvincias = this.accesoDatos.ejecutaSQLRetornaRS(strSQL);
            while (rsProvincias.next()) {
                int id = rsProvincias.getInt("id");
                String nombre = rsProvincias.getString("nombre");
                Provincia provincia = new Provincia(id, nombre);
                provincias.add(provincia);
            }
            rsProvincias.close();

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsProvincias);
        }
        return provincias;
    }

    public void guardar(Provincia provincia) throws SNMPExceptions, SQLException {
        String strSQL = "";
        try {
            strSQL = "INSERT INTO " + this.getTabla() + " (nombre) VALUES ('" + provincia.getNombre() + "')";
            this.accesoDatos.ejecutaSQL(strSQL);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Provincia> obtenerPorId(int id) throws SNMPExceptions, SQLException {
        String select = "";
        try {
            select = "SELECT id, nombre FROM " + this.getTabla() + " WHERE id = " + id;
            return this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public void actualizar(Provincia provincia) throws SNMPExceptions, SQLException, NamingException {
        //Datos de Medicamento
        int id = provincia.getId();
        String nombre = provincia.getNombre();
        //Se crea la sentencia de actualización
        String update = "UPDATE " + this.getTabla() + " SET nombre = '" + nombre + "' WHERE id = " + id;
        //Se ejecuta la sentencia SQL
        accesoDatos.ejecutaSQL(update);
    }

    public boolean existe(int id) throws SNMPExceptions, SQLException {
        ResultSet rsProvincia = null;
        String select = "";
        boolean existe = false;
        try {
            select = "SELECT id FROM " + this.getTabla() + " WHERE id =" + id;
            //Se ejecuta la sentencia SQL
            rsProvincia = accesoDatos.ejecutaSQLRetornaRS(select);
            if (rsProvincia.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsProvincia);
        }
        return existe;
    }

    public void eliminar(int id) throws SNMPExceptions, SQLException, NamingException {
        String delete = "DELETE FROM " + this.getTabla() + " WHERE id = " + id;
        accesoDatos.ejecutaSQL(delete);
    }

    public LinkedList<Provincia> todo() throws SNMPExceptions, SQLException {
        String select = "";


        try {
            //Se crea la sentencia de búsqueda
            select = "SELECT id, nombre FROM " + this.getTabla();
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
