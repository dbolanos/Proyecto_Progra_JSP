package modelo;

import DAO.AccesoDatos;

import DAO.SNMPExceptions;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;

public class TipoTelefonoDB {
    
    private String tabla = "TIPOS_TELEFONO";
    AccesoDatos accesoDatos = new AccesoDatos();
    LinkedList<TipoTelefono> listaTiposTelefono = new LinkedList<TipoTelefono>();
    
    
    public TipoTelefonoDB() {
        super();
    }
    
    
    public LinkedList<TipoTelefono> obtenerTiposTelefono () throws SNMPExceptions, SQLException{
        String select = "";
        ResultSet rsTipoTelefono = null;
        LinkedList<TipoTelefono> lstTipoTelefono = new LinkedList<TipoTelefono>();
        
        select = "SELECT ID, DESCRIPCION FROM " + this.getTabla();
        try{
            rsTipoTelefono = accesoDatos.ejecutaSQLRetornaRS(select);  
            while(rsTipoTelefono.next()){
                TipoTelefono tipoTelefono = new TipoTelefono(rsTipoTelefono.getInt("ID"), rsTipoTelefono.getString("DESCRIPCION"));
                lstTipoTelefono.add(tipoTelefono);
            } 
        }catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    return lstTipoTelefono;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getTabla() {
        return tabla;
    }
}
