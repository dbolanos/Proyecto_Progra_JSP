<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Sise - Registro de Ordenes</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <ol class="container breadcrumb">
                <li>
                    <a href="#">Ordenes</a>
                </li>
                 
                <li class="active">Registro</li>
            </ol>
            <%@ include file="/ordenes/segmento_sub_menu_izq.jspf"%>
            <div class="col-md-8 text-left jumbotron">
                <h2 class="text-center">Registro de Ordenes</h2>
                 
                <h:form>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="cliente_orden" class="control-label">Cliente:</label>
                                 
                                <h:selectOneMenu id="cliente_orden" value="#{BeanOrden.idCliente}" styleClass="form-control">
                                    <f:selectItems value="#{BeanOrden.lstClienteOrden}"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="servicio_orden" class="control-label">Servicio:</label>
                                 
                                <h:selectOneMenu id="servicio_orden" value="#{BeanOrden.idServicio}" styleClass="form-control">
                                    <f:selectItems value="#{BeanOrden.lstServicioOrden}"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="estado" class="control-label">Estado:</label>
                                 
                                <h:selectOneMenu styleClass="form-control" id="estado" value="#{BeanOrden.estado}">
                                    <f:selectItem itemLabel="Pendiente" itemValue="Pendiente"/>
                                    <f:selectItem itemLabel="Desarroyo" itemValue="Desarroyo"/>
                                    <f:selectItem itemLabel="Finalizada" itemValue="Finalizada"/>
                                    <f:selectItem itemLabel="Cancelada" itemValue="Cancelada"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="fecha_ejecucion">Fecha de ejecucion:</label>
                                 
                                <h:inputText styleClass="form-control" id="fecha_ejecucion" value="#{BeanOrden.fechaEjecucion}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="estimacion_horas">Estimacion horas de duracion:</label>
                                 
                                <h:inputText id="estimacion_horas" styleClass="form-control" value="#{BeanOrden.estimacionHorasDuracion}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="provincia">Provincia:</label>
                                 
                                <h:inputText id="provincia" styleClass="form-control"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="canton">Canton:</label>
                                 
                                <h:inputText id="canton" styleClass="form-control"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="distrito">Distrito:</label>
                                 
                                <h:inputText id="distrito" styleClass="form-control" value="#{BeanOrden.idDistrito}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="lugar">Lugar:</label>
                                 
                                <h:inputText id="lugar" styleClass="form-control" value="#{BeanOrden.lugarServicio}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="otrasSennas">Otras Se&ntilde;as:</label>
                                 
                                <h:inputText id="otrasSennas" styleClass="form-control" value="#{BeanOrden.otrasSennas}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="detalle">Detalle del servicio:</label>
                                 
                                <h:inputText styleClass="form-control" id="detalle" value="#{BeanOrden.detalleServicio}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="costo_variable_descripcion">Costo variable descripcion:</label>
                                 
                                <h:inputText id="costo_variable_descripcion" styleClass="form-control" value="#{BeanOrden.costosVariablesDescripcion}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="costo_variable_monto">Costo variable monto:</label>
                                 
                                <h:inputText id="costo_variable_monto" styleClass="form-control" value="#{BeanOrden.costosVariablesMonto}"/>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="text-center">
                            <h:outputText value="#{BeanOrden.mensaje}"/>
                        </div>
                    </div>
                    <hr></hr>
                    <div class="row text-center">
                        <h:commandButton value="Crear Orden" styleClass="btn btn-primary btn-raised" action="#{BeanOrden.crearOrden}"/>
                    </div>
                    <hr></hr>
                    <%-- <h:dataTable styleClass="table table-stripe" var="lis"> <h:column> <f:facet name="header"> <h:outputText value="Descripcion"/> </f:facet> <h:outputText
                         value="#{lis.descripcion}"/> </h:column> <h:column> <f:facet name="header"> <h:outputText value="Precio Hora"/> </f:facet> <h:outputText value="#{lis.precioHora}"/>
                         </h:column> <h:column> <f:facet name="header"> <h:outputText value="Activo"/> </f:facet> <h:outputText value="#{lis.activo}"/> </h:column> <h:column> <f:facet name="header">
                         <h:outputText value="Tipo Servicio"/> </f:facet> <h:outputText value="#{lis.tipoServicio.descripcion}"/> </h:column> <h:column> <f:facet name="header"> <h:outputText
                         value="Acciones"/> </f:facet> <h:commandButton image="/resources/img/Icon-Remove.png" style="height:22px;" onclick="cargarServicio(#{lis.id})"/> </h:column> </h:dataTable>--%>
                </h:form>
            </div>
            <%@ include file="/ordenes/segmento_sub_menu_der.jspf"%>
             
            <%@ include file="/segmento_pie_pagina.jspf"%>
            <div id="modalAyuda" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                             
                            <h4 class="modal-title">Modal Header</h4>
                        </div>
                        <div class="modal-body">
                            <p>Some text in the modal.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </body>
    </html>
</f:view>