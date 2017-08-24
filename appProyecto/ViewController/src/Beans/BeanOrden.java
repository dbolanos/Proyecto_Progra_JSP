package Beans;

import DAO.SNMPExceptions;

import java.sql.SQLException;

import java.util.Iterator;
import java.util.LinkedList;

import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;

import javax.servlet.http.HttpSession;

import modelo.Cliente;
import modelo.ClienteDB;
import modelo.Orden;
import modelo.OrdenDB;
import modelo.Servicio;
import modelo.ServicioDB;
import modelo.Usuario;

public class BeanOrden {
    private HttpSession session = (HttpSession)FacesContext.getCurrentInstance().getExternalContext().getSession(true);
    private String fechaEjecucion;
    private int idCliente;
    private int idServicio;
    private double estimacionHorasDuracion;
    private String lugarServicio;
    private int idDistrito;
    private String otrasSennas;
    private String detalleServicio;
    private String costosVariablesDescripcion;
    private double costosVariablesMonto;
    private String estado;
    private int idUsuarioRegistra;
    private String fechaRegistra;
    private int idUsuarioEdita;
    private String fechaEdita;

    private String mensaje;

    LinkedList<SelectItem> lstClienteOrden = new LinkedList<SelectItem>();
    LinkedList<SelectItem> lstServicioOrden = new LinkedList<SelectItem>();

    ClienteDB accesoClienteDB = new ClienteDB();
    ServicioDB accesoServicioDB = new ServicioDB();
    OrdenDB ordenDb = new OrdenDB();


    public BeanOrden() throws SNMPExceptions, SQLException {
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        this.setIdUsuarioRegistra(usuario.getId());
        this.setIdUsuarioEdita(usuario.getId());
        this.cargarClienteOrdenCombo();
        this.cargarServicioOrdenCombo();
    }

    public String crearOrden() throws SNMPExceptions, SQLException {
        if (fechaEjecucion.isEmpty()) {
            this.setMensaje("Ingrese la fecha de ejecucion");
            return "";
        }
        if (idCliente == 0) {
            this.setMensaje("Seleccione un cliente");
            return "";
        }
        if (idServicio == 0) {
            this.setMensaje("Seleccione un servicio");
            return "";
        }
        if (estimacionHorasDuracion == 0) {
            this.setMensaje("Ingrese la estimacion de duracion");
            return "";
        }
        if (lugarServicio.isEmpty()) {
            this.setMensaje("Ingrese un lugar");
            return "";
        }
        if (idDistrito == 0) {
            this.setMensaje("Ingrese un distrito");
            return "";
        }
        if (otrasSennas.isEmpty()) {
            this.setMensaje("Ingrese otras señas para la direccion");
            return "";
        }
        if (detalleServicio.isEmpty()) {
            this.setMensaje("Ingrese detalle del servicio.");
            return "";
        }

        Orden nuevaOrden =
            new Orden(0, this.getFechaEjecucion(), this.getIdCliente(), this.getIdServicio(), this.getEstimacionHorasDuracion(), this.getLugarServicio(), this.getIdDistrito(), this.getOtrasSennas(),
                      this.getDetalleServicio(), this.getCostosVariablesDescripcion(), this.getCostosVariablesMonto(), this.getEstado(), this.getIdUsuarioRegistra(), "2017", this.getIdUsuarioEdita(),
                      "2017");
        ordenDb.guardar(nuevaOrden);
        this.limpiar();
        return "";
    }

    public String limpiar() {
        fechaEjecucion = "";
        idCliente = 0;
        idServicio = 0;
        estimacionHorasDuracion = 0;
        lugarServicio = "";
        idDistrito = 0;
        otrasSennas = "";
        detalleServicio = "";
        costosVariablesDescripcion = "";
        costosVariablesMonto = 0;
        estado = "";
        idUsuarioRegistra = 0;
        fechaRegistra = "";
        idUsuarioEdita = 0;
        fechaEdita = "";
        return "";
    }

    public void cargarClienteOrdenCombo() throws SNMPExceptions, SQLException {

        LinkedList<SelectItem> listaCliente = new LinkedList<SelectItem>();
        listaCliente.add(new SelectItem(0, "Seleccione Un Cliente"));
        for (Iterator iter = this.accesoClienteDB.obtenerClienteOrdenCombo().iterator(); iter.hasNext(); ) {
            Cliente cliente = (Cliente)iter.next();
            listaCliente.add(new SelectItem(cliente.getId(), cliente.getNombre()));
        }
        this.setLstClienteOrden(listaCliente);

    }


    public void cargarServicioOrdenCombo() throws SNMPExceptions, SQLException {

        LinkedList<SelectItem> listaServicio = new LinkedList<SelectItem>();
        listaServicio.add(new SelectItem(0, "Seleccione Un Servicio"));
        for (Iterator iter = this.accesoServicioDB.obtenerServicioOrdenActivoCombo().iterator(); iter.hasNext(); ) {
            Servicio servicio = (Servicio)iter.next();
            listaServicio.add(new SelectItem(servicio.getId(), servicio.getDescripcion()));
        }
        this.setLstServicioOrden(listaServicio);

    }

    public void setFechaEjecucion(String fechaEjecucion) {
        this.fechaEjecucion = fechaEjecucion;
    }

    public String getFechaEjecucion() {
        return fechaEjecucion;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }

    public int getIdServicio() {
        return idServicio;
    }

    public void setEstimacionHorasDuracion(double estimacionHorasDuracion) {
        this.estimacionHorasDuracion = estimacionHorasDuracion;
    }

    public double getEstimacionHorasDuracion() {
        return estimacionHorasDuracion;
    }

    public void setLugarServicio(String lugarServicio) {
        this.lugarServicio = lugarServicio;
    }

    public String getLugarServicio() {
        return lugarServicio;
    }

    public void setIdDistrito(int idDistrito) {
        this.idDistrito = idDistrito;
    }

    public int getIdDistrito() {
        return idDistrito;
    }

    public void setOtrasSennas(String otrasSennas) {
        this.otrasSennas = otrasSennas;
    }

    public String getOtrasSennas() {
        return otrasSennas;
    }

    public void setCostosVariablesDescripcion(String costosVariablesDescripcion) {
        this.costosVariablesDescripcion = costosVariablesDescripcion;
    }

    public String getCostosVariablesDescripcion() {
        return costosVariablesDescripcion;
    }

    public void setCostosVariablesMonto(double costosVariablesMonto) {
        this.costosVariablesMonto = costosVariablesMonto;
    }

    public double getCostosVariablesMonto() {
        return costosVariablesMonto;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getEstado() {
        return estado;
    }

    public void setIdUsuarioRegistra(int idUsuarioRegistra) {
        this.idUsuarioRegistra = idUsuarioRegistra;
    }

    public int getIdUsuarioRegistra() {
        return idUsuarioRegistra;
    }

    public void setFechaRegistra(String fechaRegistra) {
        this.fechaRegistra = fechaRegistra;
    }

    public String getFechaRegistra() {
        return fechaRegistra;
    }

    public void setIdUsuarioEdita(int idUsuarioEdita) {
        this.idUsuarioEdita = idUsuarioEdita;
    }

    public int getIdUsuarioEdita() {
        return idUsuarioEdita;
    }

    public void setFechaEdita(String fechaEdita) {
        this.fechaEdita = fechaEdita;
    }

    public String getFechaEdita() {
        return fechaEdita;
    }

    public void setLstClienteOrden(LinkedList<SelectItem> lstClienteOrden) {
        this.lstClienteOrden = lstClienteOrden;
    }

    public LinkedList<SelectItem> getLstClienteOrden() {
        return lstClienteOrden;
    }

    public void setLstServicioOrden(LinkedList<SelectItem> lstServicioOrden) {
        this.lstServicioOrden = lstServicioOrden;
    }

    public LinkedList<SelectItem> getLstServicioOrden() {
        return lstServicioOrden;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setDetalleServicio(String detalleServicio) {
        this.detalleServicio = detalleServicio;
    }

    public String getDetalleServicio() {
        return detalleServicio;
    }
}
