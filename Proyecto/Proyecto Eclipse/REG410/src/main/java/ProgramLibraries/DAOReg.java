package ProgramLibraries;
/**
 * Objeto de acceso a datos
 * @author jose.inestroza@unah.edu.hn
 * @version 0.1.1
 */
public class DAOReg {
	
	private String csvModelFileName;
	
	public DAOReg(String csvModelFileName){
		this.csvModelFileName = csvModelFileName;
	}
	/**
	 * File Manager Response
	 * @author alhanis.espina@unah.hn
	 * @version 0.1.0
	 * El metodo ahora retona una cadena de texto y no un hash map
	 * @return data - datos del guardado en el DataSourceModel.csv
	 */
	public String getData(){
		
		StringBuilder data = new StringBuilder('{');
		int count=0;
		FileManager fm = new FileManager();
		FileManagerResponse fmr = fm.read(csvModelFileName);
		
		if(fmr.isStatus()) {
			String textContent = fmr.getContent();
			String[] textLines = textContent.split("<->\\n+");
			
			for(String row: textLines) {
				count++;
				data.append(String.format("%s",row));
				if(textLines.length > count) {
					data.append("<->");
				}
				}
		}
		
		return data.toString();
	}
}
