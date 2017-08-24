package modelo;

import DAO.SNMPExceptions;

import java.sql.SQLException;

import java.util.LinkedList;


public class Canton {
    private int id;
    private int idProvincia;
    private String nombre;
    private Provincia provincia;
    LinkedList<Distrito> distritos = new LinkedList<Distrito>();

    public Canton() {
        super();
    }

    public Canton(int id, int idProvincia, String nombre) {
        this.setId(id);
        this.setIdProvincia(idProvincia);
        this.setNombre(nombre);
    }


    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setIdProvincia(int id_provincia) {
        this.idProvincia = id_provincia;
    }

    public int getIdProvincia() {
        return idProvincia;
    }

    public void setProvincia(Provincia provincia) {
        this.provincia = provincia;
    }

    public Provincia getProvincia() throws SNMPExceptions, SQLException {
        if (provincia == null) {
            ProvinciaDB provinciaDb = new ProvinciaDB();
            this.setProvincia(provinciaDb.obtenerPorId(this.getIdProvincia()).getFirst());
        }
        return provincia;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setDistritos(LinkedList<Distrito> distritos) {
        this.distritos = distritos;
    }

    public LinkedList<Distrito> getDistritos() throws SNMPExceptions, SQLException {
        if (distritos.size() == 0) {
            DistritoDB distritoDb = new DistritoDB();
            this.setDistritos(distritoDb.obtenerPorCanton(this.getId()));
        }


        return distritos;
    }
}

