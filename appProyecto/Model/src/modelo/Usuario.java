package modelo;

import DAO.SNMPExceptions;

import java.sql.SQLException;

import java.util.Iterator;
import java.util.LinkedList;

import javax.faces.model.SelectItem;

public class Usuario {
    private int id;
    private String nombre;
    private String apellido;
    private String nombreUsuario;
    private String email;
    private String contrasenna;
    private int activo;
    private Rol rolActivo;
    LinkedList<Rol> roles = new LinkedList<Rol>();

    public Usuario(int id, String nombre, String apellido, String nombreUsuario, String email, String contrasenna, int activo) {
        this.setId(id);
        this.setNombre(nombre);
        this.setApellido(apellido);
        this.setNombreUsuario(nombreUsuario);
        this.setEmail(email);
        this.setContrasenna(contrasenna);
        this.setActivo(activo);
    }

    public boolean esRolValido(int rolId) throws SNMPExceptions, SQLException {
        for (Iterator iter = this.getRoles().iterator(); iter.hasNext(); ) {
            Rol rol = (Rol)iter.next();
            if (rol.getId() == rolId) {
                this.setRolActivo(rol);
                return true;
            }
        }
        return false;
    }

    public String nombreCompleto() {
        return this.getNombre() + " " + this.getApellido();
    }

    public Usuario() {
        super();
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getApellido() {
        return apellido;
    }

    public void setNombreUsuario(String nombre_usuario) {
        this.nombreUsuario = nombre_usuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setContrasenna(String contrasenna) {
        this.contrasenna = contrasenna;
    }

    public String getContrasenna() {
        return contrasenna;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getActivo() {
        return activo;
    }

    public void setRoles(LinkedList<Rol> roles) {
        this.roles = roles;
    }

    public LinkedList<Rol> getRoles() throws SNMPExceptions, SQLException {
        if (roles.size() == 0) {
            RolDB rolDb = new RolDB();
            this.setRoles(rolDb.obtenerPorUsuario(this.getId()));
        }
        return roles;
    }

    public void setRolActivo(Rol rolActivo) {
        this.rolActivo = rolActivo;
    }

    public Rol getRolActivo() {
        return rolActivo;
    }
}
