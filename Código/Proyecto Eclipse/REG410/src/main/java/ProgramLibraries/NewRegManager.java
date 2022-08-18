package ProgramLibraries;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
/**
 * Clase para la creacion de nuevo registro
 * @author alhanis.espinal@unah.hn
 *@date 2022/04/24
 *@version 0.1.0
 */
public class NewRegManager {
	
	private String typeRequest;
	private String email;
	private String description;
	
	/**
	 * Contructor de la clase
	 * @param request - request
	 */
	public NewRegManager(HttpServletRequest request) {
		//obtencion de los datos
		this.description = request.getParameter("description");
		this.email = request.getParameter("email");
		if(Integer.parseInt(request.getParameter("typeRequest"))==1) {
			this.typeRequest = "Tipo1";
			
		}else if(Integer.parseInt(request.getParameter("typeRequest"))==2){
			this.typeRequest = "Tipo2";
		}else {
			this.typeRequest = "No Request";
		}
		
		
	}
	/**
	 * Metodo para escribir los datos del nuevo registro
	 * @return status de escritura
	 */
	public boolean writeData() {
		
		StringBuilder data = new StringBuilder();
		
		FileManager fm = new FileManager();
		FileManagerResponse fmr = fm.read("Documentos/DataSourceModel.csv");
		
		if(fmr.isStatus() && fmr.getContent() !="") {
			String oldContent = fmr.getContent();
			data.append(oldContent);
		}
		// formato que tendra el DataSourceModel.csv: TipoDeSolicitud -> email -> descripcion
		data.append(this.typeRequest);
		data.append("->");
		data.append(this.email);
		data.append("->");
		data.append(this.description);
		data.append("<->");
		data.append("\n");
		
		fmr = fm.write("Documentos/DataSourceModel.csv", data.toString());
		
		return fmr.isStatus();
		
	}

	/**
	 * @return the typeRequest
	 */
	public String getTypeRequest() {
		return typeRequest;
	}

	/**
	 * @param typeRequest the typeRequest to set
	 */
	public void setTypeRequest(String typeRequest) {
		this.typeRequest = typeRequest;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}


}
