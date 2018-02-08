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
<template:addResources type="javascript" resources="jquery.min.js,slide-it.js"/>
<template:addResources type="css" resources="slide-it.css"/>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<c:set var="slideItItems" value="${jcr:getChildrenOfType(currentNode, 'jnt:slideItItem')}"/>

<c:set var="displaySlideIt" value="true"/>
<c:if test="${renderContext.editMode && renderContext.mainResource.node.path ne renderContext.site.home.path}">
    <c:set var="displaySlideIt" value="false"/>
</c:if>
<c:if test="${jcr:isNodeType(currentNode, 'jmix:slideItAdvancedSettings')}">
    <c:set var="bgcolor" value="${currentNode.properties.bgcolor.string}"/>
    <c:set var="top" value="${currentNode.properties.top.string}"/>
    <c:if test="${empty bgcolor}">
        <c:set var="bgcolor" value="#00A0E3"/>
    </c:if>
    <c:if test="${empty top}">
        <c:set var="top" value="200px"/>
    </c:if>
    <c:set var="style"> style="background-color:${bgcolor};top=${top}"</c:set>
</c:if>
<c:if test="${displaySlideIt}">
    <div class="floatingButtonsFrame center"${style}>
        <c:forEach items="${slideItItems}" var="slideItItem">
            <template:module node="${slideItItem}" nodeTypes="jnt:slideItItem" editable="true" view="button"/>
        </c:forEach>
    </div>
    <c:forEach items="${slideItItems}" var="slideItItem">
        <template:module node="${slideItItem}" nodeTypes="jnt:slideItItem" editable="true" view="dialog"/>
    </c:forEach>
    <c:if test="${renderContext.editMode}">
        <template:module path="*" nodeTypes="jnt:slideItItem"/>
    </c:if>
</c:if>


<c:if test="${! renderContext.editMode}">
    <template:addResources type="inline">
        <script>
            var sliderDialog = "#${currentNode.identifier}"

            function slideIt() {
                var sliderId = '#' + $('.pollSlider.open').attr('id');
                var slideWidth;
                if ($('.pollSlider').hasClass('open')) {
                    slideWidth = $('.pollSlider.open').width();
                    $('.pollSlider.open').animate({"margin-right": '-=' + slideWidth}, function () {
                        if (sliderId != sliderDialog) {
                            slideIt();
                        }
                    });
                    // $('#slider-button').animate({"margin-right": '-=' + slideWidth});
                    $('.pollSlider.open').removeClass('open');
                } else {
                    slideWidth = $(sliderDialog).width();
                    $(sliderDialog).addClass('open');
                    // $('#slider-button').animate({"margin-right": '+=' + slideWidth});
                    $(sliderDialog).animate({"margin-right": '+=' + slideWidth});
                }
            }

            function bindControls() {
                <c:forEach items="${slideItItems}" var="slideItItem">
                $('#${slideItItem.identifier}').click(function () {
                    sliderDialog = "#${slideItItem.identifier}Dialog";
                    slideIt();
                });
                </c:forEach>

                /* Dissmiss button */
                $(".dismissButton").click(slideIt);

            }
            // init;
            $(document).ready(function () {
                bindControls();
            });
        </script>
    </template:addResources>
</c:if>