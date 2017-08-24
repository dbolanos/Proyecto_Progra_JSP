package modelo;

import java.util.Date;

public class Cliente {

    private int id;
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


    public Cliente() {
        super();
    }

    public Cliente(int id, String nombre, String provincia, String canton, String distrito, String barrio, String otrasSennas, String email, int idTipoTelefono, String telefono, double descuento,
                   int usuarioRegistra, String fechaUsuarioRegistra, int usuarioEdita, String fechaUsuarioEdita) {
        this.setId(id);
        this.setNombre(nombre);
        this.setProvincia(provincia);
        this.setCanton(canton);
        this.setDistrito(distrito);
        this.setBarrio(barrio);
        this.setOtrasSennas(otrasSennas);
        this.setEmail(email);
        this.setIdTipoTelefono(idTipoTelefono);
        this.setTelefono(telefono);
        this.setDescuento(descuento);
        this.setUsuarioRegistra(usuarioRegistra);
        this.setFechaUsuarioRegistra(fechaUsuarioRegistra);
        this.setUsuarioEdita(usuarioEdita);
        this.setFechaUsuarioEdita(fechaUsuarioEdita);
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
}


