<!DOCTYPE html>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
            <title>Principal</title>
            <%@ include file="/segmento_recursos.jspf"%>
        </head>
        <body>
            <%@ include file="/segmento_menu_principal.jspf"%>
            <div class="container-fluid text-center">
                <div class="row content">
                    <div class="col-md-2 sidenav"></div>
                    <div class="col-md-8 text-left jumbotron">
                        <div class="row text-center">
                            <div class="col-lg-12">
                                <img src="${pageContext.request.contextPath}/resources/img/profile.png" alt=""
                                     class="center-block"></img>
                                <div class="intro-text">
                                    <h1 class="name">Bienvenido</h1>
                                    <hr/>
                                    <blockquote>
                                        <p>El trabajo que nunca se empieza es el que tarda m&aacute;s en finalizarse.</p>
                                        <small>
                                            Frase c&eacute;lebre de
                                            <cite title="Nombre Apellidos">J.R.R. Tolkien</cite>
                                        </small>
                                    </blockquote>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 sidenav">
                        <div class="well">
                            <img src="${pageContext.request.contextPath}/resources/img/banner-servicio.jpg"
                                 alt="Servicio al cliente." class="img-responsive"></img>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="/segmento_pie_pagina.jspf"%>
        </body>
    </html>
</f:view>