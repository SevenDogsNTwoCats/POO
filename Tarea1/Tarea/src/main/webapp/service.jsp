<%
/**
* Service para la aplicacion del filtro al texto
* @author alhanis.espinal@unah.hn
* @date 2022/03/17
* @version 0.1.1
 */
%>
<%@page import ="ProgramLibraries.RegExp" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	trimDirectiveWhitespaces="true"%>
<%
	//aplica el filtro
	RegExp regExp = new RegExp();
	String result = regExp.createRegExp(request);
	
	StringBuilder json = new StringBuilder("{");
	
	//generacion del json respuesta
	if(result.trim().length()>0){
		json.append(String.format("\"status\" : %s,",true));
		json.append(String.format("\"responseText\": \"%s\"",result));
	}else{
		json.append(String.format("\"status\" : %s,",false));
		json.append(String.format("\"message\": \"Los parametros recibidos no han generado una respuesta\""));
		}
	json.append("}");
	
	out.print(json.toString().replaceAll("\\n+",""));
	
	
%>