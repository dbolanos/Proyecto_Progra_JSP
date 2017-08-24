<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Sise-Busqueda de Facturas</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <ol class="container breadcrumb">
                <li>
                    <a href="#">Facturas</a>
                </li>
                 
                <li class="active">Buscar</li>
            </ol>
            <%@ include file="/facturas/segmento_sub_menu_izq.jspf"%>
            <div class="col-md-8 text-left jumbotron">
                <h2 class="text-center">Busqueda de Facturas</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                   et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                   aliquip ex ea commodo consequat. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui
                   officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor
                   incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                   ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                <hr></hr>
                <h3>Test</h3>
                <p>Lorem ipsum...</p>
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