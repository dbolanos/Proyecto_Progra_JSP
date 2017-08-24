package modelo;

import DAO.AccesoDatos;

import DAO.SNMPExceptions;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.LinkedList;

import javax.naming.NamingException;


public class TipoServicioDB {
    
    String tabla = "TIPOS_SERVICIO";
    AccesoDatos accesoDatos = new AccesoDatos();
    LinkedList<TipoServicio> listaRol = new LinkedList<TipoServicio>();
    
    
    
    public TipoServicioDB() {
        super();
    }
    
    
    public LinkedList<TipoServicio> obtenerTipoServicios () throws SNMPExceptions, SQLException{
        String select = "";
        ResultSet rsTipoServicios = null;
        LinkedList<TipoServicio> lstTipoServicio = new LinkedList<TipoServicio>();
        
        select = "SELECT ID, DESCRIPCION, ACTIVO FROM " + this.getTabla();
        try{
            rsTipoServicios = accesoDatos.ejecutaSQLRetornaRS(select);  
            while(rsTipoServicios.next()){
                TipoServicio tipoServicio = new TipoServicio(rsTipoServicios.getInt("ID"), rsTipoServicios.getString("DESCRIPCION"), rsTipoServicios.getInt("ACTIVO"));
                lstTipoServicio.add(tipoServicio);
            } 
        }catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    return lstTipoServicio;
    }
            

    public void guardar(TipoServicio tipoServicio) throws SNMPExceptions, SQLException {

        String strSQL = "";
        try {
            strSQL = "INSERT INTO " + this.getTabla() + " (descripcion) VALUES ('" + tipoServicio.getDescripcion() + "')";
            this.getAccesoDatos().ejecutaSQL(strSQL);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }

   

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    /*
    public LinkedList<TipoServicio> todo() throws SNMPExceptions, SQLException {
        String select = "";
        LinkedList<TipoServicio> tiposServicio = new LinkedList<TipoServicio>();

        try {
            //Se crea la sentencia de búsqueda
            select = "SELECT id, descripcion, activo FROM " + this.getTabla();
            tiposServicio = this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return tiposServicio;
    }

    public LinkedList<TipoServicio> activos() throws SNMPExceptions, SQLException {
        String select = "";
        LinkedList<TipoServicio> tiposServicio = new LinkedList<TipoServicio>();

        try {
            //Se crea la sentencia de búsqueda
            select = "SELECT id, descripcion, activo FROM " + this.getTabla() + " WHERE activo == 1";
            tiposServicio = this.obtener(select);
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
        return tiposServicio;
    }
*/

    public AccesoDatos getAccesoDatos() {
        return accesoDatos;
    }

    public String getTabla() {
        return tabla;
    }


    public void setListaRol(LinkedList<TipoServicio> listaRol) {
        this.listaRol = listaRol;
    }

    public LinkedList<TipoServicio> getListaRol() {
        return listaRol;
    }


    public void setAccesoDatos(AccesoDatos accesoDatos) {
        this.accesoDatos = accesoDatos;
    }
}
