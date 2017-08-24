package modelo;

public class TipoTelefono {
    
    private int idTipoTelefono;
    private String descripcion;
    
    public TipoTelefono() {
        super();
    }

    public TipoTelefono(int idTipoTelefono, String descripcion) {
        this.setIdTipoTelefono(idTipoTelefono);
        this.setDescripcion(descripcion);
    }

    public void setIdTipoTelefono(int idTipoTelefono) {
        this.idTipoTelefono = idTipoTelefono;
    }

    public int getIdTipoTelefono() {
        return idTipoTelefono;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescripcion() {
        return descripcion;
    }
}
