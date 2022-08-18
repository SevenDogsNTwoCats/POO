package ProgramLibraries;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Paths;
/**
 * File Manager
 * @author jose.inestroza@unah.edu.hn
 * @version 0.1.0
 */
public class FileManager {
	
	/**
	 * @return La ruta del sistema donde se esta guardando por defecto los archivos
	 */
	public String path(){
		
		File file = new File(".");
		return file.getAbsolutePath();
	}
	
	public FileManagerResponse read(String fileName){
		try {
			FileManagerResponse response = new FileManagerResponse();
			
			response.setPath(String.format("%s/%s", this.path(), fileName));
			response.setContent(Files.readString(Paths.get(response.getPath())));
			response.setStatus(true);
			
			return response;
			
		}catch(IOException e) {
			return new FileManagerResponse(e.toString());
			
		}
		
	}
	
	public FileManagerResponse write(String fileName, String content){
		try {
			FileManagerResponse response = new FileManagerResponse();
			response.setPath(
					Files.writeString(
						Files.createFile(
							Paths.get(String.format("%s/%s", this.path(), fileName))),
							content
				).toString());
			response.setStatus(true);
			return response;
		}catch(FileAlreadyExistsException e) {
			//return new FileManagerResponse("El archivo que usted esta creando ya existe. Error: " + e);
			return this.writeAndOverride(fileName,content);
		}catch(IOException e) {
			return new FileManagerResponse(e.toString());
		}
		
	}
	
	public FileManagerResponse writeAndOverride(String fileName, String content){
		try {
			FileManagerResponse response = new FileManagerResponse();
			response.setPath(
					Files.writeString(
							Paths.get(String.format("%s/%s", this.path(), fileName)),
							content
				).toString());
			response.setStatus(true);
			return response;
		}catch(IOException e) {
			return new FileManagerResponse(e.toString());
		}
	}
	
	public FileManagerResponse delete(String fileName) {
		try {
			FileManagerResponse response = new FileManagerResponse();
			File file = new File(fileName);
			file.delete();
			response.setStatus(true);
			return response;
		}catch(Exception e) {
			return new FileManagerResponse(e.toString());
		}
	}
	
}
