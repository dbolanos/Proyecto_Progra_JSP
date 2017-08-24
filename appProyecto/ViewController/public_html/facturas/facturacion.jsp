<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Sise-Facturadion</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <ol class="container breadcrumb">
                <li>
                    <a href="#">Facturas</a>
                </li>
                 
                <li class="active">Facturacion</li>
            </ol>
            <%@ include file="/facturas/segmento_sub_menu_izq.jspf"%>
            <div class="col-md-8 text-left jumbotron">
                <h2 class="text-center">Facturacion</h2>
                 
                <h:form>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="fecha" class="col-md-2 control-label">Fecha:</label>
                                <div class="col-md-10">
                                    <h:inputText styleClass="form-control" id="fecha"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="orden" class="col-md-2 control-label">Numero Orden de Servicio:</label>
                                <div class="col-md-10">
                                    <h:inputText styleClass="form-control" id="orden"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row text-center">
                        <h:commandButton value="Guardar" styleClass="btn btn-primary btn-raised"/>
                    </div>
                </h:form>
            </div>
            <%@ include file="/facturas/segmento_sub_menu_der.jspf"%>
             
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