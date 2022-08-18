/**
 * Clase concreta para la ejecucion de una accion para la apertura de un modal
 *@author jose.inestroza@unah.hn
 *@version 0.1.0
 */
 
 class BtnActions{
	constructor(){
		this.modalId = "";
	}
	
	setId(modalId){
		this.modalId=modalId;
	}
	
	callModal(){
		let modal = new bootstrap.Modal(document.querySelector(`#${this.modalId}`));
		modal.show();
	}
	
}