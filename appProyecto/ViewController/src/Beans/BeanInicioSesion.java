package Beans;

import DAO.SNMPExceptions;

import modelo.UsuarioDB;
import modelo.Usuario;

import java.sql.SQLException;

import java.util.Iterator;
import java.util.LinkedList;

import javax.faces.context.FacesContext;

import javax.faces.model.SelectItem;

import javax.servlet.http.HttpSession;

import modelo.Rol;
import modelo.RolDB;

public class BeanInicioSesion {
    private UsuarioDB usuarioDb = new UsuarioDB();
    private RolDB rolDb = new RolDB();
    private HttpSession session = (HttpSession)FacesContext.getCurrentInstance().getExternalContext().getSession(true);
    private String usuario;
    private String clave;
    private String mensaje;
    private int rolSeleccionado;
    LinkedList<SelectItem> roles = new LinkedList<SelectItem>();


    public BeanInicioSesion() throws SNMPExceptions, SQLException {
        this.cargarRoles(rolDb.todo());
    }

    public String iniciarSesion() throws SNMPExceptions, SQLException {

        LinkedList<Usuario> usuarios = usuarioDb.inicioSesion(this.getUsuario(), this.getClave());

        if (usuarios.size() == 0) {
            this.setUsuario("");
            this.setClave("");
            this.setMensaje("Datos invalidos");
            return "error";
        }

        Usuario usuario = usuarios.getFirst();

        if (this.getRolSeleccionado() != 0 && usuario.esRolValido(this.getRolSeleccionado())) {
            session.setAttribute("usuario", usuario);
            this.setUsuario("");
            this.setClave("");
            this.setMensaje("");
            return "continue";
        }

        this.setMensaje("Seleccione un rol valido");
        return "error";
    }

    private void cargarRoles(LinkedList<Rol> roles) {
        String descripcion = "Seleccione un rol";
        int codigo = 0;
        LinkedList<SelectItem> resultList = new LinkedList<SelectItem>();
        resultList.add(new SelectItem(codigo, descripcion));
        if (roles.size() > 0) {
            for (Iterator iter = roles.iterator(); iter.hasNext(); ) {
                Rol rol = (Rol)iter.next();
                codigo = rol.getId();
                descripcion = rol.getNombre();
                resultList.add(new SelectItem(codigo, descripcion));
            }
        }
        if (this.getRoles().size() <= 1) {
            this.setRoles(resultList);
        }
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getClave() {
        return clave;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setRoles(LinkedList<SelectItem> roles) {
        this.roles = roles;
    }

    public LinkedList<SelectItem> getRoles() {
        return roles;
    }

    public void setRolSeleccionado(int rolSeleccionado) {
        this.rolSeleccionado = rolSeleccionado;
    }

    public int getRolSeleccionado() {
        return rolSeleccionado;
    }
}
