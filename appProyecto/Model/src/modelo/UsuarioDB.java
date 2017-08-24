package modelo;

import DAO.AccesoDatos;
import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;

public class UsuarioDB {
    private AccesoDatos accesoDatos = new AccesoDatos();
    private String tabla = "usuarios";
    LinkedList<Usuario> usuarios = new LinkedList<Usuario>();

    public UsuarioDB() {
        super();
    }

    private LinkedList<Usuario> obtener(String strSQL) throws SNMPExceptions, SQLException {
        ResultSet rsUsuarios = null;
        LinkedList<Usuario> usuarios = new LinkedList<Usuario>();
        try {
            rsUsuarios = this.accesoDatos.ejecutaSQLRetornaRS(strSQL);
            while (rsUsuarios.next()) {
                int id = rsUsuarios.getInt("id");
                String nombre = rsUsuarios.getString("nombre");
                String apellido = rsUsuarios.getString("apellido");
                String nombreUsuario = rsUsuarios.getString("nombre_usuario");
                String email = rsUsuarios.getString("email");
                String contrasenna = rsUsuarios.getString("contrasenna");
                int activo = rsUsuarios.getInt("activo");

                Usuario usuario = new Usuario(id, nombre, apellido, nombreUsuario, email, contrasenna, activo);
                usuarios.add(usuario);
            }
            rsUsuarios.close();

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsUsuarios);
        }
        return usuarios;
    }

    public void guardar(Usuario usuario) throws SNMPExceptions, SQLException {

        String strSQL = "";
        try {
            strSQL =
                    "INSERT INTO " + this.getTabla() + " (nombre, apellido, nombre_usuario, email, contrasenna) VALUES ('" + usuario.getNombre() + "','" + usuario.getApellido() + "','" + usuario.getNombreUsuario() +
                    "','" + usuario.getEmail() + "','" + usuario.getContrasenna() + ")";
            this.accesoDatos.ejecutaSQL(strSQL);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

    public LinkedList<Usuario> inicioSesion(String nombreUsuario, String contrasenna) throws SNMPExceptions, SQLException {
        String select = "";
        LinkedList<Usuario> usuarios = new LinkedList<Usuario>();
        try {
            select =
                    "SELECT id, nombre, apellido, nombre_usuario, email, contrasenna, activo FROM " + this.getTabla() + " WHERE nombre_usuario = '" + nombreUsuario + "' AND contrasenna = '" + contrasenna +
                    "'";
            usuarios = this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return usuarios;
    }

    public void setAccesoDatos(AccesoDatos accesoDatos) {
        this.accesoDatos = accesoDatos;
    }

    public AccesoDatos getAccesoDatos() {
        return accesoDatos;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getTabla() {
        return tabla;
    }

    public void setUsuarios(LinkedList<Usuario> listaRol) {
        this.usuarios = listaRol;
    }

    public LinkedList<Usuario> getUsuarios() {
        return usuarios;
    }
}
