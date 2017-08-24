<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Inicio de Sesion</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <div class="container-fluid text-center">
                <div class="row content">
                    <div class="col-md-2 sidenav"></div>
                    <div class="col-md-8 text-left">
                        <div class="wrapper">
                            <h:form styleClass="form-signin">
                                <img src="resources/img/sise_logo.png" alt="SISE" width="150px" class="center-block"></img>
                                <hr/>
                                <h2 class="form-signin-heading text-center">Inicio de Sesion</h2>
                                <div class="form-group">
                                    <label for="usuario" class="control-label">Usuario:</label>
                                     
                                    <h:inputText styleClass="form-control" id="usuario" value="#{BeanInicioSesion.usuario}"/>
                                </div>
                                <div class="form-group">
                                    <label for="clave" class="control-label">Clave:</label>
                                     
                                    <h:inputSecret styleClass="form-control" id="clave" value="#{BeanInicioSesion.clave}"/>
                                </div>
                                <div class="form-group">
                                    <label for="rol" class=" control-label">Rol:</label>
                                     
                                    <h:selectOneMenu id="rol" value="#{BeanInicioSesion.rolSeleccionado}" styleClass="form-control">
                                        <f:selectItems value="#{BeanInicioSesion.roles}"/>
                                    </h:selectOneMenu>
                                </div>
                                <div class="text-center">
                                    <h:outputText value="#{BeanInicioSesion.mensaje}"/>
                                </div>
                                <p></p>
                                <h:commandButton value="Cancelar" styleClass="btn btn-danger btn-raised"/>
                                <h:commandButton value="Continuar" styleClass="btn btn-primary btn-raised pull-right" action="#{BeanInicioSesion.iniciarSesion}"/>
                            </h:form>
                        </div>
                    </div>
                    <div class="col-md-2 sidenav"></div>
                </div>
            </div>
            <jsp:include page="/segmento_pie_pagina.jspf"/>
        </body>
    </html>
</f:view>