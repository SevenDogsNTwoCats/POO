<%
/**
* Service para la limpiar los registros
* @author alhanis.espinal@unah.hn
* @date 2022/04/23
* @version 0.1.1
 */
%>

<%@page import="ProgramLibraries.FileManager"%>
<%@page import="ProgramLibraries.FileManagerResponse"%>
<%@page import="ProgramLibraries.RegDTO"%>
<%@page import="ProgramLibraries.FirstTimeOutManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	//acceso al archivo que contiene los datos para eliminarlo
	FileManager fm = new FileManager();
	FileManagerResponse fmr = fm.delete("Documentos/DataSourceModel.csv");
	RegDTO regDTO = (RegDTO) session.getAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE);
	//se reinician los contadores a 0
	regDTO.setTotalReg(0);
	regDTO.setTypeRequest1(0);
	regDTO.setTypeRequest2(0);
	session.setAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE, regDTO);
	
	//json respuesta
    StringBuilder json = new StringBuilder("{");
    
    json.append(String.format("\"status\": %s",fmr.isStatus()));
    	
    json.append("}");
    
    out.print(json.toString().replaceAll("\\n+",""));

%>