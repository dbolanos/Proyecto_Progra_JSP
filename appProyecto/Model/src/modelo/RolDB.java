package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;

public class RolDB {
    private AccesoDatos accesoDatos = new AccesoDatos();
    private String tabla = "roles";
    LinkedList<Rol> listaRol = new LinkedList<Rol>();

    public RolDB() {
        super();
    }

    private LinkedList<Rol> obtener(String strSQL) throws SNMPExceptions, SQLException {
        ResultSet rsRoles = null;
        LinkedList<Rol> roles = new LinkedList<Rol>();
        try {
            rsRoles = this.accesoDatos.ejecutaSQLRetornaRS(strSQL);
            while (rsRoles.next()) {
                int id = rsRoles.getInt("id");
                String nombre = rsRoles.getString("nombre");
                String descripcion = rsRoles.getString("descripcion");
                int activo = rsRoles.getInt("activo");

                Rol rol = new Rol(id, nombre, descripcion, activo);
                roles.add(rol);
            }
            rsRoles.close();

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsRoles);
        }
        return roles;
    }

    public void guardar(Rol rol) throws SNMPExceptions, SQLException {

        String strSQL = "";
        try {
            strSQL = "INSERT INTO " + this.getTabla() + " (nombre,descripcion) VALUES ('" + rol.getNombre() + "','" + rol.getDescripcion() + "')";
            this.accesoDatos.ejecutaSQL(strSQL);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Rol> obtenerPorUsuario(int id_usuario) throws SNMPExceptions, SQLException {
        String select = "";
        LinkedList<Rol> roles = new LinkedList<Rol>();
        try {
            select = "SELECT * FROM " + this.getTabla() + " WHERE id IN (SELECT id_rol FROM roles_usuarios WHERE id_usuario = " + id_usuario + ")";
            roles = this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return roles;
    }

    public LinkedList<Rol> obtenerPorId(int id) throws SNMPExceptions, SQLException {
        String select = "";
        LinkedList<Rol> roles = new LinkedList<Rol>();
        try {
            select = "SELECT id, nombre, descripcion, activo FROM " + this.getTabla() + " WHERE id = " + id;
            roles = this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return roles;
    }

    public void actualizar(Rol rol) throws SNMPExceptions, SQLException, NamingException {
        //Datos de Medicamento
        int id = rol.getId();
        String nombre = rol.getNombre();
        String descripcion = rol.getDescripcion();
        int activo = rol.getActivo();
        //Se crea la sentencia de actualización
        String update = "UPDATE " + this.getTabla() + " SET nombre = '" + nombre + "', descripcion=" + descripcion + "', activo=" + activo + " WHERE id = " + id;
        //Se ejecuta la sentencia SQL
        accesoDatos.ejecutaSQL(update);
    }

    public boolean existe(int id) throws SNMPExceptions, SQLException {
        ResultSet rsROL = null;
        String select = "";
        boolean existe = false;
        try {
            select = "SELECT id FROM " + this.getTabla() + " WHERE id =" + id;
            //Se ejecuta la sentencia SQL
            rsROL = accesoDatos.ejecutaSQLRetornaRS(select);
            if (rsROL.next()) {
                existe = true;
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsROL);
        }
        return existe;
    }

    public void eliminar(int id) throws SNMPExceptions, SQLException, NamingException {
        String delete = "DELETE FROM " + this.getTabla() + " WHERE id = " + id;
        accesoDatos.ejecutaSQL(delete);
    }

    public LinkedList<Rol> todo() throws SNMPExceptions, SQLException {
        String select = "";
        LinkedList<Rol> roles = new LinkedList<Rol>();

        try {
            //Se crea la sentencia de búsqueda
            select = "SELECT * FROM " + this.getTabla();
            roles = this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return roles;
    }

    public void setListaRol(LinkedList<Rol> listaRol) {
        this.listaRol = listaRol;
    }

    public LinkedList<Rol> getListaRol() {
        return listaRol;
    }

    public String getTabla() {
        return tabla;
    }
}
