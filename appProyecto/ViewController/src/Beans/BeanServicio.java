package Beans;

import DAO.SNMPExceptions;

import modelo.UsuarioDB;
import modelo.Usuario;

import java.sql.SQLException;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.Date;

import javax.faces.context.FacesContext;

import javax.faces.model.SelectItem;

import javax.servlet.http.HttpSession;

import modelo.RolDB;
import modelo.Servicio;
import modelo.ServicioDB;
import modelo.TipoServicio;
import modelo.TipoServicioDB;


public class BeanServicio {
    private int idServicio;
    private String descripcionServicio;
    private double precioHoraServicio;
    private int activoServicio;
    private int idTipoServicio;
    private TipoServicio tipoServicio;
    LinkedList<SelectItem> lstTipoServicio = new LinkedList<SelectItem>();
    LinkedList<Servicio> lstServicio = new LinkedList<Servicio>();


    TipoServicioDB accesoTipoServicioDB = new TipoServicioDB();
    ServicioDB accesoServicioDB = new ServicioDB();

    private int idTipoServicioBuscar;
    private int idServicioActualizar;

    private UsuarioDB usuarioDb = new UsuarioDB();
    private RolDB rolDb = new RolDB();
    private HttpSession session = (HttpSession)FacesContext.getCurrentInstance().getExternalContext().getSession(true);
    private String usuario;
    private String clave;
    private String mensaje;
    private Usuario usuarioIngresa; //Objeto que contendra al usuario actual
    private String mensajeBuscar;
    private int rolSeleccionado;
    LinkedList<SelectItem> roles = new LinkedList<SelectItem>();

    public BeanServicio() throws SNMPExceptions, SQLException {
        this.setUsuarioIngresa((Usuario)session.getAttribute("usuario"));
        tipoServicio = new TipoServicio();
        this.cargarTipoServicioCombo();
        this.cargarTablaServicios();
    }

    private void cargarTipoServicioCombo() throws SNMPExceptions, SQLException {

        LinkedList<SelectItem> listaTipoServicio = new LinkedList<SelectItem>();

        listaTipoServicio.add(new SelectItem(0, "Seleccione Un Tipo"));
        for (Iterator iter = this.accesoTipoServicioDB.obtenerTipoServicios().iterator(); iter.hasNext(); ) {
            TipoServicio tipoServicio = (TipoServicio)iter.next();
            listaTipoServicio.add(new SelectItem(tipoServicio.getId(), tipoServicio.getDescripcion()));
        }
        this.setLstTipoServicio(listaTipoServicio);

    }

    public void cargarTablaServicios() throws SNMPExceptions, SQLException {

        LinkedList<Servicio> listaServicios = new LinkedList<Servicio>();

        for (Iterator iter = this.accesoServicioDB.obtnerServicios().iterator(); iter.hasNext(); ) {
            Servicio servicio = (Servicio)iter.next();
            listaServicios.add(servicio);
        }
        this.setLstServicio(listaServicios);

    }


    public String almacenarServicio() throws SNMPExceptions, SQLException {
        if (this.validarDatosServicio()) {
            Servicio servicio = new Servicio();
            servicio.setDescripcion(this.getDescripcionServicio());
            servicio.setPrecioHora(this.getPrecioHoraServicio());
            servicio.setActivo(this.getActivoServicio());
            this.tipoServicio.setId(this.getIdTipoServicio());
            servicio.setTipoServicio(this.getTipoServicio());
            Date fechaActual = new Date();
            servicio.setUsuarioEdita(this.getUsuarioIngresa().getId());
            servicio.setFechaUsuarioEdita(fechaActual);


            if (this.getIdServicioActualizar() == 0) {
                //Crear Servicio Nuevo
                servicio.setUsuarioRegistra(this.getUsuarioIngresa().getId());
                servicio.setFechaUsuarioRegistra(fechaActual);
                this.setMensaje(this.accesoServicioDB.guardarServicio(servicio));

            } else {
                //Actualizar Servicio
                servicio.setId(this.getIdServicioActualizar());
                this.setMensaje(this.accesoServicioDB.actualizarServicio(servicio));

            }

        } else {
            this.setMensaje("Datos incompletos");
        }
        this.limpiarDatos();
        this.cargarTablaServicios();


        return ""; //Este return es para que el expression builder reconozca esta funcion
    }

    private Boolean validarDatosServicio() {
        if (this.getDescripcionServicio().equals("")) {
            return false;
        }
        if (this.getPrecioHoraServicio() == 0) {
            return false;
        }
        if (this.getIdTipoServicio() == 0) {
            return false;
        }
        return true;
    }

    public void limpiarDatos() {
        this.setIdServicio(0);
        this.setDescripcionServicio("");
        this.setPrecioHoraServicio(0);
        this.setActivoServicio(0);

    }

    public String cargarServicioActualizar() throws SNMPExceptions, SQLException {
        if (this.getIdServicioActualizar() != 0) {
            Servicio servicioActualizar = new Servicio();
            servicioActualizar = this.accesoServicioDB.buscarServicio(this.getIdServicioActualizar());
            this.setIdServicio(servicioActualizar.getId());
            this.setDescripcionServicio(servicioActualizar.getDescripcion());
            this.setPrecioHoraServicio(servicioActualizar.getPrecioHora());
            this.setIdTipoServicio(servicioActualizar.getTipoServicio().getId());

        }
        return "";
    }


    public String cargarTablaServiciosFiltroTipoServicios() throws SNMPExceptions, SQLException {
        LinkedList<Servicio> listaServicios = new LinkedList<Servicio>();
        if (this.getIdTipoServicioBuscar() != 0) {
            for (Iterator iter = this.accesoServicioDB.obtnerServiciosFiltroTipoServicio(this.getIdTipoServicioBuscar()).iterator(); iter.hasNext(); ) {
                Servicio servicio = (Servicio)iter.next();
                listaServicios.add(servicio);
            }
            this.setLstServicio(listaServicios);
        } else {
            this.setMensajeBuscar("Debe seleccionar un tipo de Servicio");
        }
        //Se pone a devolver un String vacio para que el metodo sea reconocido por el expresion builder
        return "";
    }

    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }

    public int getIdServicio() {
        return idServicio;
    }

    public void setDescripcionServicio(String descripcionServicio) {
        this.descripcionServicio = descripcionServicio;
    }

    public String getDescripcionServicio() {
        return descripcionServicio;
    }

    public void setPrecioHoraServicio(double precioHoraServicio) {
        this.precioHoraServicio = precioHoraServicio;
    }

    public double getPrecioHoraServicio() {
        return precioHoraServicio;
    }

    public void setActivoServicio(int activoServicio) {
        this.activoServicio = activoServicio;
    }

    public int getActivoServicio() {
        return activoServicio;
    }

    public void setIdTipoServicio(int idTipoServicio) {
        this.idTipoServicio = idTipoServicio;
    }

    public int getIdTipoServicio() {
        return idTipoServicio;
    }

    public void setTipoServicio(TipoServicio tipoServicio) {
        this.tipoServicio = tipoServicio;
    }

    public TipoServicio getTipoServicio() {
        return tipoServicio;
    }

    public void setLstTipoServicio(LinkedList<SelectItem> lstTipoServicio) {
        this.lstTipoServicio = lstTipoServicio;
    }

    public LinkedList<SelectItem> getLstTipoServicio() {
        return lstTipoServicio;
    }

    public void setAccesoTipoServicioDB(TipoServicioDB accesoTipoServicioDB) {
        this.accesoTipoServicioDB = accesoTipoServicioDB;
    }

    public TipoServicioDB getAccesoTipoServicioDB() {
        return accesoTipoServicioDB;
    }

    public void setUsuarioDb(UsuarioDB usuarioDb) {
        this.usuarioDb = usuarioDb;
    }

    public UsuarioDB getUsuarioDb() {
        return usuarioDb;
    }

    public void setRolDb(RolDB rolDb) {
        this.rolDb = rolDb;
    }

    public RolDB getRolDb() {
        return rolDb;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    public HttpSession getSession() {
        return session;
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

    public void setRolSeleccionado(int rolSeleccionado) {
        this.rolSeleccionado = rolSeleccionado;
    }

    public int getRolSeleccionado() {
        return rolSeleccionado;
    }

    public void setRoles(LinkedList<SelectItem> roles) {
        this.roles = roles;
    }

    public LinkedList<SelectItem> getRoles() {
        return roles;
    }

    public void setIdTipoServicioBuscar(int idTipoServicioBuscar) {
        this.idTipoServicioBuscar = idTipoServicioBuscar;
    }

    public int getIdTipoServicioBuscar() {
        return idTipoServicioBuscar;
    }

    public void setLstServicio(LinkedList<Servicio> lstServicio) {
        this.lstServicio = lstServicio;
    }

    public LinkedList<Servicio> getLstServicio() {
        return lstServicio;
    }

    public void setIdServicioActualizar(int idServicioActualizar) {
        this.idServicioActualizar = idServicioActualizar;
    }

    public int getIdServicioActualizar() {
        return idServicioActualizar;
    }

    public void setMensajeBuscar(String mensajeBuscar) {
        this.mensajeBuscar = mensajeBuscar;
    }

    public String getMensajeBuscar() {
        return mensajeBuscar;
    }

    public void setUsuarioIngresa(Usuario usuarioIngresa) {
        this.usuarioIngresa = usuarioIngresa;
    }

    public Usuario getUsuarioIngresa() {
        return usuarioIngresa;
    }
}
