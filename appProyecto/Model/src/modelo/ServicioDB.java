package modelo;

import DAO.AccesoDatos;

import DAO.SNMPExceptions;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.LinkedList;

import javax.naming.NamingException;

public class ServicioDB {
    private String tabla = "SERVICIOS";
    AccesoDatos accesoDatos = new AccesoDatos();


    public ServicioDB() {
        super();
    }

    public LinkedList<Servicio> obtnerServicios() throws SNMPExceptions, SQLException {
        String select = "";
        ResultSet rsServicios = null;
        LinkedList<Servicio> lstServicios = new LinkedList<Servicio>();

        select =
                "select ser.id, ser.descripcion, ser.precio_hora, ser.activo, ser.id_tipo_servicio, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita, tip.descripcion as tipo_servicio\n" +
                "from  servicios ser inner join tipos_servicio tip on ser.id_tipo_servicio = tip.id";
        try {
            rsServicios = accesoDatos.ejecutaSQLRetornaRS(select);
            while (rsServicios.next()) {
                TipoServicio tipoServicio = new TipoServicio();
                tipoServicio.setId(rsServicios.getInt("ID_TIPO_SERVICIO"));
                tipoServicio.setDescripcion(rsServicios.getString("TIPO_SERVICIO"));
                Servicio servicio =
                    new Servicio(rsServicios.getInt("ID"), rsServicios.getString("DESCRIPCION"), rsServicios.getDouble("PRECIO_HORA"),
                                 rsServicios.getInt("ACTIVO"), tipoServicio, rsServicios.getInt("ID_USUARIO_REGISTRA"),
                                 rsServicios.getDate("FECHA_REGISTRA"), rsServicios.getInt("ID_USUARIO_EDITA"),
                                 rsServicios.getDate("FECHA_EDITA"));
                lstServicios.add(servicio);
            }

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsServicios);
        }

        return lstServicios;

    }
    
    

    public Servicio buscarServicio(int idServicio) throws SNMPExceptions, SQLException {
        String select = "";
        Servicio servicio = new Servicio();
        ResultSet rsServicios = null;

        select =
                "select ser.id, ser.descripcion, ser.precio_hora, ser.activo, ser.id_tipo_servicio, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita, tip.descripcion as tipo_servicio\n" +
                "from  servicios ser inner join tipos_servicio tip on ser.id_tipo_servicio = tip.id\n" +
                "where ser.id =" + idServicio;
        try {
            rsServicios = accesoDatos.ejecutaSQLRetornaRS(select);
            while (rsServicios.next()) {
                TipoServicio tipoServicio = new TipoServicio();
                tipoServicio.setId(rsServicios.getInt("ID_TIPO_SERVICIO"));
                tipoServicio.setDescripcion(rsServicios.getString("TIPO_SERVICIO"));
                servicio.setId(rsServicios.getInt("ID"));
                servicio.setDescripcion(rsServicios.getString("DESCRIPCION"));
                servicio.setPrecioHora(rsServicios.getDouble("PRECIO_HORA"));
                servicio.setActivo(rsServicios.getInt("ACTIVO"));
                servicio.setTipoServicio(tipoServicio);

            }

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsServicios);
        }

        return servicio;
    }
    
    
    public Servicio buscarServicioActivo(int idServicio) throws SNMPExceptions, SQLException {
        String select = "";
        Servicio servicio = new Servicio();
        ResultSet rsServicios = null;

        select =
                "select ser.id, ser.descripcion, ser.precio_hora, ser.activo, ser.id_tipo_servicio, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita, tip.descripcion as tipo_servicio\n" +
                "from  servicios ser inner join tipos_servicio tip on ser.id_tipo_servicio = tip.id\n" +
                "where ser.id = " + idServicio + " and\n" +
                "ser.activo = 1";
        try {
            rsServicios = accesoDatos.ejecutaSQLRetornaRS(select);
            while (rsServicios.next()) {
                TipoServicio tipoServicio = new TipoServicio();
                tipoServicio.setId(rsServicios.getInt("ID_TIPO_SERVICIO"));
                tipoServicio.setDescripcion(rsServicios.getString("TIPO_SERVICIO"));
                servicio.setId(rsServicios.getInt("ID"));
                servicio.setDescripcion(rsServicios.getString("DESCRIPCION"));
                servicio.setPrecioHora(rsServicios.getDouble("PRECIO_HORA"));
                servicio.setActivo(rsServicios.getInt("ACTIVO"));
                servicio.setTipoServicio(tipoServicio);

            }

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsServicios);
        }

        return servicio;
    }
    

    public String guardarServicio(Servicio servicio) throws SNMPExceptions, SQLException {

        DateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy hh:mm");

        String strSQL = "";
        int resultado = 0;
        System.out.println("Fecha Actual: " + dateFormat.format(servicio.getFechaUsuarioRegistra()));


        try {
            strSQL =
                    "INSERT INTO " + this.getTabla() + " (descripcion, precio_hora, activo, id_tipo_servicio, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita) VALUES " +
                    "('" + servicio.getDescripcion() + "'," + servicio.getPrecioHora() + "," + servicio.getActivo() +
                    "," + servicio.getTipoServicio().getId() + "," + servicio.getUsuarioRegistra() + ",'" +
                    dateFormat.format(servicio.getFechaUsuarioRegistra()) + "'," + servicio.getUsuarioEdita() + ",'" +
                    dateFormat.format(servicio.getFechaUsuarioEdita()) + "')";
            resultado = this.accesoDatos.ejecutaSQL(strSQL);
            if (resultado == 1) {
                return "Servicio Almacenado correctamente";
            } else {
                return "Error, No se almaceno el servicio";
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    }


    public String actualizarServicio(Servicio servicioActualizar) throws SNMPExceptions, SQLException {
        int resultado = 0;
        DateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy hh:mm");
        
        try {
            //Se crea la sentencia de actualización
            String update =
                "UPDATE Servicios SET descripcion = '" + servicioActualizar.getDescripcion() + "', precio_hora = " +
                servicioActualizar.getPrecioHora() + ", activo = " + servicioActualizar.getActivo() +
                ", id_tipo_servicio =" + servicioActualizar.getTipoServicio().getId() + ", id_usuario_edita = " +
                servicioActualizar.getUsuarioEdita() + ", fecha_edita= '" +
                dateFormat.format(servicioActualizar.getFechaUsuarioEdita()) + "' where id = " + servicioActualizar.getId();

            //Se ejecuta la sentencia SQL
            resultado = accesoDatos.ejecutaSQL(update);
            if (resultado == 1) {
                return "Servicio Actualizado correctamente";
            } else {
                return "Error, No se actualizo el servicio";
            }
        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }

    }
    
    
    public LinkedList<Servicio> obtnerServiciosFiltroTipoServicio(int filtroIdTipoServicio) throws SNMPExceptions, SQLException {
        String select = "";
        ResultSet rsServicios = null;
        LinkedList<Servicio> lstServicios = new LinkedList<Servicio>();

        select =
                "select ser.id, ser.descripcion, ser.precio_hora, ser.activo, ser.id_tipo_servicio, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita, tip.descripcion as tipo_servicio\n" +
                "from  servicios ser inner join tipos_servicio tip on ser.id_tipo_servicio = tip.id\n" +
                "where ser.id_tipo_servicio = " + filtroIdTipoServicio;
        try {
            rsServicios = accesoDatos.ejecutaSQLRetornaRS(select);
            while (rsServicios.next()) {
                TipoServicio tipoServicio = new TipoServicio();
                tipoServicio.setId(rsServicios.getInt("ID_TIPO_SERVICIO"));
                tipoServicio.setDescripcion(rsServicios.getString("TIPO_SERVICIO"));
                Servicio servicio =
                    new Servicio(rsServicios.getInt("ID"), rsServicios.getString("DESCRIPCION"), rsServicios.getDouble("PRECIO_HORA"),
                                 rsServicios.getInt("ACTIVO"), tipoServicio, rsServicios.getInt("ID_USUARIO_REGISTRA"),
                                 rsServicios.getDate("FECHA_REGISTRA"), rsServicios.getInt("ID_USUARIO_EDITA"),
                                 rsServicios.getDate("FECHA_EDITA"));
                lstServicios.add(servicio);
            }

        } catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        } finally {
            accesoDatos.closeResultSet(rsServicios);
        }

        return lstServicios;

    }
    
    
    public LinkedList<Servicio> obtenerServicioOrdenActivoCombo () throws SNMPExceptions, SQLException{
        String select = "";
        ResultSet rsServicio = null;
        LinkedList<Servicio> lstServicio = new LinkedList<Servicio>();
        
        //select = "SELECT ID, DESCRIPCION, ACTIVO FROM " + this.getTabla() + " where activo = 1 ";
        select ="select ser.id, ser.descripcion, ser.precio_hora, ser.activo, ser.id_tipo_servicio, id_usuario_registra, fecha_registra, id_usuario_edita, fecha_edita, tip.descripcion as tipo_servicio\n" +
                "from  servicios ser inner join tipos_servicio tip on ser.id_tipo_servicio = tip.id\n" +
                "where ser.activo = 1 ";
        try{
            rsServicio = accesoDatos.ejecutaSQLRetornaRS(select);  
            while(rsServicio.next()){
                Servicio servicio = new Servicio();
                servicio.setId(rsServicio.getInt("ID"));
                servicio.setDescripcion(rsServicio.getString("DESCRIPCION")); 
                lstServicio.add(servicio);
            } 
        }catch (SQLException e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage(), e.getErrorCode());
        } catch (Exception e) {
            throw new SNMPExceptions(SNMPExceptions.SQL_EXCEPTION, e.getMessage());
        }
    return lstServicio;
    }
    


    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getTabla() {
        return tabla;
    }

    public void setAccesoDatos(AccesoDatos accesoDatos) {
        this.accesoDatos = accesoDatos;
    }

    public AccesoDatos getAccesoDatos() {
        return accesoDatos;
    }
}
