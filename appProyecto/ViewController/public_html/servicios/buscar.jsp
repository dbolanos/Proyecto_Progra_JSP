<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Sise - Busqueda de Servicios</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <ol class="container breadcrumb">
                <li>
                    <a href="#">Servicios</a>
                </li>
                 
                <li class="active">Buscar</li>
            </ol>
            <%@ include file="/servicios/segmento_sub_menu_izq.jspf"%>
            <div class="col-md-8 text-left jumbotron">
                <h2 class="text-center">Busqueda de Servicios</h2>
                 
                <h:form>
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