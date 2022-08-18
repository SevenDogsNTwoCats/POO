package ProgramLibraries;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.http.HttpServletRequest;
/**
* Aplicacion de la la exprecion regular al texto
* @author alhanis.espinal@unah.hn
* @date 2022/03/17
* @version 0.1.1
 */

public class RegExp {
	
	public String createRegExp(HttpServletRequest request) {
		StringBuilder result = new StringBuilder();
		//Expresion regular
		String regex = request.getParameter("regExp").trim();
		//Al leer request.getParameter("regExp") cambia los + por espacios en blanco en los string asi que se vuelven agregar
		regex = regex.replaceAll("\\s", "+");
		
		try {
			//crea expresion regular  
			Pattern p = Pattern.compile(regex);
			//aplica la expresion regular al texto
			Matcher m = p.matcher(request.getParameter("text"));
			
			//agrega las los caracteres que coincidan a la variable result
			while(m.find()) {
				result.append(m.group());
				result.append(" ");
				
			}
			
		}catch(Exception exception) {
			result.append("Los parametros recibidos no han generado una respuesta");
			result.append("La excepcion generada es: ");
			result.append(exception);
			
		}
		
		   
		//retornando el resultado del filtro
		return result.toString();
	}
	

}
   
