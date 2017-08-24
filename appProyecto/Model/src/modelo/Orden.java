package modelo;

import DAO.SNMPExceptions;

import java.sql.SQLException;

public class Orden {
    private int id;
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
    private Servicio servicio;
    private Distrito distrito;

    public Orden(int id, String fechaEjecucion, int idCliente, int idServicio, double estimacionHorasDuracion, String lugarServicio, int idDistrito, String otrasSennas, String detalleServicio,
                 String costosVariablesDescripcion, double costosVariablesMonto, String estado, int idUsuarioRegistra, String fechaRegistra, int idUsuarioEdita, String fechaEdita) {
        this.setId(id);
        this.setFechaEjecucion(fechaEjecucion);
        this.setIdCliente(idCliente);
        this.setIdServicio(idServicio);
        this.setEstimacionHorasDuracion(estimacionHorasDuracion);
        this.setLugarServicio(lugarServicio);
        this.setIdDistrito(idDistrito);
        this.setOtrasSennas(otrasSennas);
        this.setDetalleServicio(detalleServicio);
        this.setCostosVariablesDescripcion(costosVariablesDescripcion);
        this.setCostosVariablesMonto(costosVariablesMonto);
        this.setEstado(estado);
        this.setIdUsuarioRegistra(idUsuarioRegistra);
        this.setFechaRegistra(fechaRegistra);
        this.setIdUsuarioEdita(idUsuarioEdita);
        this.setFechaEdita(fechaEdita);
    }

    public Orden() {
        super();
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
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

    public void setDetalleServicio(String detalleServicio) {
        this.detalleServicio = detalleServicio;
    }

    public String getDetalleServicio() {
        return detalleServicio;
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

    public void setServicio(Servicio servicio) {
        this.servicio = servicio;
    }

    public Servicio getServicio() throws SNMPExceptions, SQLException {
        if (this.getServicio() == null) {
            ServicioDB servicioDb = new ServicioDB();
            this.setServicio(servicioDb.buscarServicio(this.getIdServicio()));
        }
        return servicio;
    }

    public void setDistrito(Distrito distrito) {
        this.distrito = distrito;
    }

    public Distrito getDistrito() throws SNMPExceptions, SQLException {
        if (this.getDistrito() == null) {
            DistritoDB distritoDb = new DistritoDB();
            this.setDistrito(distritoDb.obtenerPorId(this.getIdServicio()).getFirst());
        }
        return distrito;
    }
}
