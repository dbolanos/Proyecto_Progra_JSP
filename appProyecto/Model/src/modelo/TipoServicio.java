package modelo;

public class TipoServicio {

    
    private int id;
    private String descripcion;
    private int activo;

    public TipoServicio(int id, String descripcion, int activo) {
        this.setId(id);
        this.setDescripcion(descripcion);
        this.setActivo(activo);
    }

    public TipoServicio() {
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

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getActivo() {
        return activo;
    }

    public String getAttribute() {
        return "";
    }
}
