package ProgramLibraries;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Objeto para la obtencion de la cantidad de cada vez que se ingresa a la aplicacion
 * @author alhanis.espinal@unah.hn
 *@date 2022/04/25
 *@version 0.1.0
 */
public class FirstTimeOutManager {
	
	//atributo para anadir los contadores a la sesion
	public static final String COUNTMANAGER_DTO_ATTRIBUTE = "counter";
	private List<String> data = new ArrayList<String>();
	/**
	 * Metodo para la obtencion de los registros que ya hay en el DataSourceModel.csv
	 */
	public FirstTimeOutManager() {
		FileManager fm = new FileManager();
		FileManagerResponse fmr = fm.read("Documentos/DataSourceModel.csv");
		if(fmr.isStatus()) {
			String textContent = fmr.getContent();
			String[] textLines = textContent.split("<->\\n+");
			
			for(String row: textLines) {
				String[] columns = row.split("->");
				this.data.add(columns[0]);
			}
		}
		
		
	}
	
	/**
	 * Obtencion del total de resgistros
	 * @return count - total de registros
	 */
	public int getTotal() {
		
		int count=0;
		
		for (String element: data) {
		    count++;
		}
		
		return count;
	}
	/**
	 * Obtencion del total de resgistros tipo 1
	 * @return count - total de registros tipo 1
	 */
	public int getTypeRequest1() {
		
		int count=0;
		
		for (String element: data) {
			if(element.matches("Tipo1")) {
				count++;
			}
				
		}
		
		return count;
	}
	/**
	 * Obtencion del total de resgistros tipo 2
	 * @return count - total de registros tipo 2
	 */
	public int getTypeRequest2() {
		
		int count=0;
		
		for (String element: data) {
			if(element.matches("Tipo2")) {
				count++;
			}
				
		}
		
		return count;
	}
	
}
