package modelo;

import DAO.SNMPExceptions;

import java.sql.SQLException;

public class Distrito {

    private int id;
    private int idCanton;
    private String nombre;
    private Canton canton;


    public Distrito() {
        super();
    }

    public Distrito(int id, int idCanton, String nombre) {
        this.setId(id);
        this.setIdCanton(idCanton);
        this.setNombre(nombre);
    }


    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setIdCanton(int idCanton) {
        this.idCanton = idCanton;
    }

    public int getIdCanton() {
        return idCanton;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setCanton(Canton canton) {
        this.canton = canton;
    }

    public Canton getCanton() throws SNMPExceptions, SQLException {
        if (canton == null) {
            CantonDB cantonDb = new CantonDB();
            this.setCanton(cantonDb.obtenerPorId(this.getIdCanton()).getFirst());
        }
        return canton;
    }
}

