<%
/**
* Service para la creacion de un nuevo registro
* @author alhanis.espinal@unah.hn
* @date 2022/04/23
* @version 0.1.1
 */
%>
<%@page import="ProgramLibraries.NewRegManager"%>
<%@page import="ProgramLibraries.RegDTO"%>
<%@page import="ProgramLibraries.FirstTimeOutManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	//clase para la creacion de un un nuevo registro
	NewRegManager newReg = new NewRegManager(request);
	String typeRequest = newReg.getTypeRequest();
	String description = newReg.getDescription();
	String email = newReg.getEmail();
	//obtencion del DTO que ocntiene los contadores mediante la session
	RegDTO regDTO = (RegDTO) session.getAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE);
	
	//json respuesta
    StringBuilder json = new StringBuilder("{");
    
    if (typeRequest.matches("No Request")){
    	
    	json.append(String.format("\"status\": %s,",false));
    	json.append(String.format("\"message\": \"%s\"","El tipo de solicitud no es valida."));
    	
    	
    }else{
    	json.append(String.format("\"status\": %s,",true));
    	
    	//si se puedo crear un nuevo regsitro se aumenta en uno el contador total
    	// y el contador del tipo al que corresponda
    	regDTO.setTotalReg(regDTO.getTotalReg()+1);
    	if(typeRequest.matches("Tipo1")){
    		regDTO.setTypeRequest1(regDTO.getTypeRequest1()+1);
    	}else if(typeRequest.matches("Tipo2")){
    		regDTO.setTypeRequest2(regDTO.getTypeRequest2()+1);
    	}
    	//actualizacion de los nuevos contadores en la sesion
    	session.setAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE, regDTO);
    	boolean writeStatus = newReg.writeData();
    	
    	json.append(String.format("\"email\": \"%s\",",email));
    	json.append(String.format("\"typeRequest\": \"%s\",",typeRequest));
    	json.append(String.format("\"description\": \"%s\",",description)); 
    	json.append(String.format("\"writeCsvStatus\": %s,",writeStatus));
    	json.append(String.format("\"total\": %s,",regDTO.getTotalReg()));
        json.append(String.format("\"typeRequest1\": %s,",regDTO.getTypeRequest1()));
        json.append(String.format("\"typeRequest2\": %s",regDTO.getTypeRequest2()));
    	
    }
    json.append("}");
    
    out.print(json.toString().replaceAll("\\n+",""));
%>