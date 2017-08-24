package modelo;

import java.util.Date;

public class Servicio {
    
    private int             id;
    private String          descripcion;
    private double          precioHora;
    private int             activo;
    private TipoServicio    tipoServicio;
    private int             usuarioRegistra;
    private Date            fechaUsuarioRegistra;
    private int             usuarioEdita;
    private Date            fechaUsuarioEdita;
    
    public Servicio(int id, String descripcion, double precioHora, int activo, TipoServicio tipoServicio,
                    int usuarioRegistra, Date fechaUsuarioRegistra, int usuarioEdita, Date fechaUsuarioEdita){
        
        this.setId(id);
        this.setDescripcion(descripcion);
        this.setPrecioHora(precioHora);
        this.setActivo(activo);
        this.setTipoServicio(tipoServicio);
        this.setUsuarioRegistra(usuarioRegistra);
        this.setFechaUsuarioRegistra(fechaUsuarioRegistra);
        this.setUsuarioEdita(usuarioEdita);
        this.setFechaUsuarioEdita(fechaUsuarioEdita);
    }
    
    public Servicio() {
        super();
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setPrecioHora(double precioHora) {
        this.precioHora = precioHora;
    }

    public double getPrecioHora() {
        return precioHora;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getActivo() {
        return activo;
    }

    public void setTipoServicio(TipoServicio tipoServicio) {
        this.tipoServicio = tipoServicio;
    }

    public TipoServicio getTipoServicio() {
        return tipoServicio;
    }

    public void setUsuarioRegistra(int usuarioRegistra) {
        this.usuarioRegistra = usuarioRegistra;
    }

    public int getUsuarioRegistra() {
        return usuarioRegistra;
    }

    public void setFechaUsuarioRegistra(Date fechaUsuarioRegistra) {
        this.fechaUsuarioRegistra = fechaUsuarioRegistra;
    }

    public Date getFechaUsuarioRegistra() {
        return fechaUsuarioRegistra;
    }

    public void setUsuarioEdita(int usuarioEdita) {
        this.usuarioEdita = usuarioEdita;
    }

    public int getUsuarioEdita() {
        return usuarioEdita;
    }

    public void setFechaUsuarioEdita(Date fechaUsuarioEdita) {
        this.fechaUsuarioEdita = fechaUsuarioEdita;
    }

    public Date getFechaUsuarioEdita() {
        return fechaUsuarioEdita;
    }
}
