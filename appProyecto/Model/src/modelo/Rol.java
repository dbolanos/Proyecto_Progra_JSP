package modelo;

public class Rol {
    private int id;
    private String nombre;
    private String descripcion;
    private int activo;

    public Rol(int id, String nombre, String descripcion, int activo) {
        this.setId(id);
        this.setNombre(nombre);
        this.setDescripcion(descripcion);
        this.setActivo(activo);
    }

    public Rol() {
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

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setActivo(int estado) {
        this.activo = estado;
    }

    public int getActivo() {
        return activo;
    }
}
