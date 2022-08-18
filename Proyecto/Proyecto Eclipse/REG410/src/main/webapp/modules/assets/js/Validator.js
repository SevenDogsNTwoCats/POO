/**
 * Clase para la validacion de texto
 *@author jose.inestroza@unah.hn
 *@version 0.1.1
 */
 
 class Validator{
	
	constructor(){}
	
	removeHTML(text){
		return `${text}`.replace(/<[^>]+>/g,"");
	}
	
	removeSpecialCharacter(text){
		return `${text}`.replace(/[^\w\t., -:; ]+/g,"");
	}
	
	onlyNumbers(text){
		return `${text}`.trim().replace(/\D+/g,"");
	}
	
	onlyDouble(text){
		return `${text}`.trim().replace(/[^\d.]+/g,"");
	}
	/**
	 * Metodo para contar las palabras de un texto
	 *@author alhanis.espinal@unah.hn
	 *@since 0.1.1
	 @return boolean - true si cumple con el maximo, false si excede el maximo
	 */
	countWords(text){
		
		let words = text.split(/\W/g).length;
		if(text!=="" && words < 200 ){
			return true;
		}
		return false;
	}
	
}