/**
Clse para cuando se ingresa a la aplicacion
@author alhanis.espinal@unah.hn
@version 0.1.0
@date 2022/04/25
 */
 
class Action{
	constructor(){
		
		this.timeTrigger=1;
		this.method = "GET";
		this.action = "modules/controllers/firstTimeOutRegService.jsp";
	}
	
	/**
	* Metodo para mostrar el numero de registros y mostrar la lista en la vista
	 */
	runOneTime(){
		let xhr = new XMLHttpRequest();
		xhr.open(this.method,this.action,true);
		xhr.onreadystatechange = function(){
			if(this.readyState === XMLHttpRequest.DONE){
				if(this.status === 200){
					
					try{
						
						
						let json = JSON.parse(this.responseText);
						if(json.status){
							//mostrar los contadores
							let total = document.querySelector("h2#total");
							let regT1 = document.querySelector("h2#regT1");
							let regT2 = document.querySelector("h2#regT2");
							
							total.innerHTML = json.total;
							regT1.innerHTML = json.typeRequest1;
							regT2.innerHTML = json.typeRequest2;
							
							
							
							if(json.total>0){
								//instanciacion de la clase que muestra la lista en la vista
								let cv = new CreateViewReg();
								cv.addRegToView(json.data,0);
							
							}
							
						}else{
							let error = document.querySelector("p#error");
							error.innerHTML = "El servidor no ha podido generar una respuesta";
							let alertError = new bootstrap.Modal(document.querySelector("div#alertError"));
							alertError.show();
						}
						
						
					}catch(exception){
						let error = document.querySelector("p#error");
						error.innerHTML = `Exception: ${exception}`;
						let alertError = new bootstrap.Modal(document.querySelector("div#alertError"));
						alertError.show();
					}
					
				}else{
					let error = document.querySelector("p#error");
					error.innerHTML = `No se ha podido conectar con el servidor`;
					let alertError = new bootstrap.Modal(document.querySelector("div#alertError"));
					alertError.show();
				}
				
			}
			
		}
		
		xhr.send();
	}
	
	//obtener el tiempo
	getTime(){
		return this.timeTrigger*1000;
	}
	
}