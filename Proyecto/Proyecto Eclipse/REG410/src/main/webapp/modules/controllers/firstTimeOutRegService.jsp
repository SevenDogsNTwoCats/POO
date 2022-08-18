<%
/**
* Service para cada vez que se ingresa a la aplicacion
* @author alhanis.espinal@unah.hn
* @date 2022/04/24
* @version 0.1.1
 */
%>

<%@page import="ProgramLibraries.DAOReg"%>
<%@page import="ProgramLibraries.RegDTO"%>
<%@page import="ProgramLibraries.FirstTimeOutManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	//obtencion de los datos
	RegDTO regDTO = new RegDTO();
	FirstTimeOutManager cm = new FirstTimeOutManager();
	DAOReg dao = new DAOReg("Documentos/DataSourceModel.csv");
	String data = dao.getData();
	
	//se cuentan cuantos resgistros totales y de cada tipo hay
	int total = cm.getTotal();
	int regT1 = cm.getTypeRequest1();
	int regT2 = cm.getTypeRequest2();
	
	//se anaden los contadores a la sesion
	regDTO.setTotalReg(total);
	regDTO.setTypeRequest1(regT1);
	regDTO.setTypeRequest2(regT2);
	session.setAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE, regDTO);
	
	//json respuesta
	StringBuilder json = new StringBuilder("{");	
    json.append(String.format("\"status\": %s,",true));
    json.append(String.format("\"total\": %s,",total));
    json.append(String.format("\"typeRequest1\": %s,",regT1));
    json.append(String.format("\"typeRequest2\": %s,",regT2));
    json.append(String.format("\"data\": \"%s\"",data));
    
    json.append("}");
    
    out.print(json.toString().replaceAll("\\n+",""));
%>