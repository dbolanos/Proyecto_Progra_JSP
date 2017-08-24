    <!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Sise - Registro de Servicios</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <ol class="container breadcrumb">
                <li>
                    <a href="#">Servicios</a>
                </li>
                 
                <li class="active">Registro</li>
            </ol>
            <%@ include file="/servicios/segmento_sub_menu_izq.jspf"%>
            <div class="col-md-8 text-left jumbotron">
                <h:form>
                    <h2 class="text-center">Registro de Servicio</h2>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="descripcion" class="control-label">Descripcion:</label>
                                 
                                <h:inputText id="descripcion_servicio" styleClass="form-control" value="#{BeanServicio.descripcionServicio}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="tipo_servicio" class=" control-label">Tipo:</label>
                                 
                                <h:selectOneMenu styleClass="form-control" value="#{BeanServicio.idTipoServicio}">
                                    <f:selectItems value="#{BeanServicio.lstTipoServicio}"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="precio" class=" control-label">Precio por hora:</label>
                                 
                                <h:inputText styleClass="form-control" id="precio" value="#{BeanServicio.precioHoraServicio}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="estado" class=" control-label">Estado:</label>
                                 
                                <h:selectOneMenu styleClass="form-control" id="estado" value="#{BeanServicio.activoServicio}">
                                    <f:selectItem itemLabel="Activo" itemValue="1"/>
                                    <f:selectItem itemLabel="Suspendido" itemValue="2"/>
                                    <f:selectItem itemLabel="Cancelado" itemValue="3"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                    </div>
                    <div class="row text-center">
                        <h:outputLabel id="mensaje1" value="#{BeanServicio.mensaje}"/>
                    </div>
                    <div class="row text-center">
                        <h:commandButton value="Nuevo" styleClass="btn btn-primary btn-raised" action="#{BeanServicio.limpiarDatos}"/>
                         
                        <h:commandButton value="Guardar" styleClass="btn btn-primary btn-raised" action="#{BeanServicio.almacenarServicio}"/>
                    </div>
                    <hr></hr>
                    <h2 class="text-center">Busqueda de Servicios</h2>
                    <div class="form-inline">
                        <div class="form-group">
                            <label for="tipo_servicio" class="col-md-2 control-label">Tipo:</label>
                            <div class="col-md-10">
                                <h:selectOneMenu styleClass="form-control" value="#{BeanServicio.idTipoServicioBuscar}" style="width:160px;">
                                    <f:selectItems value="#{BeanServicio.lstTipoServicio}"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                        <div class="form-group">
                            <h:commandButton value="" image="/resources/img/filter-icon.png" style="height:18px;" alt="Filtrar por Tipo Servicio"
                                             action="#{BeanServicio.cargarTablaServiciosFiltroTipoServicios}"/>
                        </div>
                        <div class="form-group">
                            <h:outputLabel value="#{BeanServicio.mensajeBuscar}"/>
                        </div>
                    </div>
                    <h:inputHidden id="servicioActualizar" value="#{BeanServicio.idServicioActualizar}"/>
                    <h:dataTable styleClass="table table-stripe" value="#{BeanServicio.lstServicio}" var="lis">
                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="Id"/>
                            </f:facet>
                            <h:outputText value="#{lis.id}"/>
                        </h:column>
                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="Descripcion"/>
                            </f:facet>
                            <h:outputText value="#{lis.descripcion}"/>
                        </h:column>
                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="Precio Hora"/>
                            </f:facet>
                            <h:outputText value="#{lis.precioHora}"/>
                        </h:column>
                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="Activo"/>
                            </f:facet>
                            <h:outputText value="#{lis.activo}"/>
                        </h:column>
                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="Tipo Servicio"/>
                            </f:facet>
                            <h:outputText value="#{lis.tipoServicio.descripcion}"/>
                        </h:column>
                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="Acciones"/>
                            </f:facet>
                            <h:commandButton image="/resources/img/update-icon.png" style="height:18px;" action="#{BeanServicio.cargarServicioActualizar}" onclick="cargarServicio(#{lis.id})"/>
                        </h:column>
                    </h:dataTable>
                </h:form>
            </div>
            <%@ include file="/servicios/segmento_sub_menu_der.jspf"%>
             
            <%@ include file="/segmento_pie_pagina.jspf"%>
            <div id="modalAyuda" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                             
                            <h4 class="modal-title">Infomacion</h4>
                        </div>
                        <div class="modal-body">
                            <p>
                                <h:outputLabel value="#{BeanServicio.mensaje}"/>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
          function cargarServicio(idServicio) {
              console.log(idServicio);
              document.getElementById("j_id_id2:servicioActualizar").value = idServicio;

          }
        </script>
    </html>
</f:view>