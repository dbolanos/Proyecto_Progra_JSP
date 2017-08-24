package Beans;

import DAO.SNMPExceptions;

import java.sql.SQLException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;

import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import modelo.Cliente;
import modelo.ClienteDB;
import modelo.TipoTelefono;
import modelo.TipoTelefonoDB;
import modelo.Usuario;

public class BeanCliente {
    private HttpSession session = (HttpSession)FacesContext.getCurrentInstance().getExternalContext().getSession(true);
    private String nombre;
    private String provincia;
    private String canton;
    private String distrito;
    private String barrio;
    private String otrasSennas;
    private String email;
    private String telefono;
    private int idTipoTelefono;
    private double descuento;
    private int usuarioRegistra;
    private String fechaUsuarioRegistra;
    private int usuarioEdita;
    private String fechaUsuarioEdita;
    private int activo;

    private String mensaje;

    LinkedList<SelectItem> lstTiposTelefonoCliente = new LinkedList<SelectItem>();

    TipoTelefonoDB accesoTipoTelefonoDB = new TipoTelefonoDB();
    ClienteDB clienteDb = new ClienteDB();


    public BeanCliente() throws SNMPExceptions, SQLException {
        DateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy hh:mm");
        Date date = new Date();
        this.setFechaUsuarioRegistra(dateFormat.format(date));
        this.setFechaUsuarioEdita(dateFormat.format(date));
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        this.setUsuarioRegistra(usuario.getId());
        this.setUsuarioEdita(usuario.getId());
        this.cargarTiposTelefonoCombo();
    }

    public String cargarTiposTelefonoCombo() throws SNMPExceptions, SQLException {

        LinkedList<SelectItem> listaTipoTelefono = new LinkedList<SelectItem>();
        listaTipoTelefono.add(new SelectItem(0, "Seleccione un tipo de telefono"));
        for (Iterator iter = this.accesoTipoTelefonoDB.obtenerTiposTelefono().iterator(); iter.hasNext(); ) {
            TipoTelefono tipoTelefono = (TipoTelefono)iter.next();
            listaTipoTelefono.add(new SelectItem(tipoTelefono.getIdTipoTelefono(), tipoTelefono.getDescripcion()));
        }
        this.setLstTiposTelefonoCliente(listaTipoTelefono);
        return "";
    }

    public String guardar() throws SNMPExceptions, SQLException {

        if (nombre.isEmpty()) {
            this.setMensaje("Ingrese un nombre");
            return "";
        }
        if (provincia.isEmpty()) {
            this.setMensaje("Ingrese una provincia");
            return "";
        }
        if (canton.isEmpty()) {
            this.setMensaje("Ingrese un canton");
            return "";
        }
        if (distrito.isEmpty()) {
            this.setMensaje("Ingrese un distrito");
            return "";
        }
        if (barrio.isEmpty()) {
            this.setMensaje("Ingrese un barrio");
            return "";
        }
        if (otrasSennas.isEmpty()) {
            this.setMensaje("Ingrese otras señas para la direccion");
            return "";
        }
        if (email.isEmpty()) {
            this.setMensaje("Ingrese un correo");
            return "";
        }
        if (telefono.isEmpty()) {
            this.setMensaje("Ingrese un telefono");
            return "";
        }
        if (idTipoTelefono == 0) {
            this.setMensaje("Seleccione un tipo de telefono");
            return "";
        }
        Cliente nuevoCliente =
            new Cliente(0, nombre, provincia, canton, distrito, barrio, otrasSennas, email, idTipoTelefono, telefono, descuento, usuarioRegistra, fechaUsuarioRegistra, usuarioEdita,
                        fechaUsuarioEdita);
        String respuesta = this.clienteDb.guardarCliente(nuevoCliente);
        this.limpiar();
        this.setMensaje(respuesta);
        return "";
    }

    public String limpiar() {
        nombre = "";
        provincia = "";
        canton = "";
        distrito = "";
        barrio = "";
        otrasSennas = "";
        email = "";
        telefono = "";
        idTipoTelefono = 0;
        descuento = 0;
        usuarioRegistra = 0;
        fechaUsuarioRegistra = "";
        usuarioEdita = 0;
        fechaUsuarioEdita = "";
        activo = 0;
        mensaje = "";
        return "";
    }


    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setCanton(String canton) {
        this.canton = canton;
    }

    public String getCanton() {
        return canton;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setBarrio(String barrio) {
        this.barrio = barrio;
    }

    public String getBarrio() {
        return barrio;
    }

    public void setOtrasSennas(String otrasSennas) {
        this.otrasSennas = otrasSennas;
    }

    public String getOtrasSennas() {
        return otrasSennas;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setUsuarioRegistra(int usuarioRegistra) {
        this.usuarioRegistra = usuarioRegistra;
    }

    public int getUsuarioRegistra() {
        return usuarioRegistra;
    }

    public void setFechaUsuarioRegistra(String fechaUsuarioRegistra) {
        this.fechaUsuarioRegistra = fechaUsuarioRegistra;
    }

    public String getFechaUsuarioRegistra() {
        return fechaUsuarioRegistra;
    }

    public void setUsuarioEdita(int usuarioEdita) {
        this.usuarioEdita = usuarioEdita;
    }

    public int getUsuarioEdita() {
        return usuarioEdita;
    }

    public void setFechaUsuarioEdita(String fechaUsuarioEdita) {
        this.fechaUsuarioEdita = fechaUsuarioEdita;
    }

    public String getFechaUsuarioEdita() {
        return fechaUsuarioEdita;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getActivo() {
        return activo;
    }

    public void setLstTiposTelefonoCliente(LinkedList<SelectItem> lstTiposTelefonoCliente) {
        this.lstTiposTelefonoCliente = lstTiposTelefonoCliente;
    }

    public LinkedList<SelectItem> getLstTiposTelefonoCliente() {
        return lstTiposTelefonoCliente;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setIdTipoTelefono(int idTipoTelefono) {
        this.idTipoTelefono = idTipoTelefono;
    }

    public int getIdTipoTelefono() {
        return idTipoTelefono;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getMensaje() {
        return mensaje;
    }
}
