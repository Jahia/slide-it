<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<c:set var="subnodes" value="${jcr:getChildrenOfType(currentNode, 'jmix:droppableContent')}"/>
<c:set var="icon" value="${currentNode.properties['faIcon'].string}"/>



<div id="${currentNode.identifier}Dialog" class="dialog${renderContext.editMode? 'edit' : ''} pollSlider">
    <div class="dismissButton"><i class="fas fa-times"></i></div>
    <c:if test="${renderContext.editMode}">
        <h4><i class=""fa ${icon}></i> ${currentNode.displayableName}</h4>
    </c:if>
    <c:forEach items="${subnodes}" var="subnode">
        <template:module path="${subnode.path}" editable="true"/>
    </c:forEach>
    <c:if test="${renderContext.editMode}">
        <template:module path = "*" nodeTypes="jmix:droppableContent"/>
    </c:if>
</div>
