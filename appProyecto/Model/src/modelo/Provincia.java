package modelo;

import DAO.SNMPExceptions;

import java.sql.SQLException;

import java.util.LinkedList;

public class Provincia {
    private int id;
    private String nombre;
    LinkedList<Canton> cantones = new LinkedList<Canton>();

    public Provincia() {
        super();
    }

    public Provincia(int id, String nombre) {
        this.setId(id);
        this.setNombre(nombre);
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

    public void setCantones(LinkedList<Canton> roles) {
        this.cantones = roles;
    }

    public LinkedList<Canton> getCantones() throws SNMPExceptions, SQLException {
        if (cantones == null) {
            CantonDB cantonDb = new CantonDB();
            this.setCantones(cantonDb.obtenerPorProvincia(this.getId()));
        }
        return cantones;
    }
}
