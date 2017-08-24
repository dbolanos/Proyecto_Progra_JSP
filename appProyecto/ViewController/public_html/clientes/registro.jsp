<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Sise - Registro de Clientes</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <ol class="container breadcrumb">
                <li>
                    <a href="#">Clientes</a>
                </li>
                 
                <li class="active">Registro</li>
            </ol>
            <%@ include file="/clientes/segmento_sub_menu_izq.jspf"%>
            <div class="col-md-8 text-left jumbotron">
                <h2 class="text-center">Registro de Cliente</h2>
                 
                <h:form>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="nombre" class=" control-label">Nombre:</label>
                                 
                                <h:inputText styleClass="form-control" id="nombre" value="#{BeanCliente.nombre}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="correo" class=" control-label">Correo:</label>
                                 
                                <h:inputText styleClass="form-control" id="email" value="#{BeanCliente.email}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="telefono" class="control-label">Telefono:</label>
                                 
                                <h:inputText styleClass="form-control" id="telefono" value="#{BeanCliente.telefono}"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="tipo_tel" class="control-label">Tipo telefono:</label>
                                 
                                <h:selectOneMenu id="tipo_tel" value="#{BeanCliente.idTipoTelefono}" styleClass="form-control">
                                    <f:selectItems value="#{BeanCliente.lstTiposTelefonoCliente}"/>
                                </h:selectOneMenu>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="provincia" class="control-label">Provincia:</label>
                                 
                                <h:inputText styleClass="form-control" id="provincia" value="#{BeanCliente.provincia}"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="canton" class="control-label">Canton:</label>
                                 
                                <h:inputText styleClass="form-control" id="canton" value="#{BeanCliente.canton}"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="distrito" class="control-label">Distrito:</label>
                                 
                                <h:inputText styleClass="form-control" id="distrito" value="#{BeanCliente.distrito}"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="barrio" class="control-label">Barrio:</label>
                                 
                                <h:inputText styleClass="form-control" id="barrio" value="#{BeanCliente.barrio}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="otras_sennas" class="control-label">Otras Se&ntilde;as:</label>
                                 
                                <h:inputText styleClass="form-control" id="otras_sennas" value="#{BeanCliente.otrasSennas}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="porc_descuento" class="control-label">% de Descuento</label>
                                 
                                <h:inputText styleClass="form-control" id="porc_descuento" value="#{BeanCliente.descuento}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row text-center">
                        <h:outputLabel id="mensaje1" value="#{BeanCliente.mensaje}"/>
                         
                        <br></br>
                         
                        <h:commandButton value="Nuevo" styleClass="btn btn-primary btn-raised" action="#{BeanCliente.limpiar}"/>
                         
                        <h:commandButton value="Guardar" styleClass="btn btn-primary btn-raised" action="#{BeanCliente.guardar}"/>
                    </div>
                </h:form>
            </div>
            <%@ include file="/clientes/segmento_sub_menu_der.jspf"%>
             
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