/**
Clase para la creacion de un nuevo registro
@author alhanis.espinal@unah.hn
@version 0.1.0
@date 2022/04/24
 */
 class RegManager{
	constructor(){
		this.action = "modules/controllers/newRegService.jsp";
		this.method = "POST";
	}
	/**
	* Metodo para la obtencion de los datos
	*@param {input} email - email
	* @param {select} typeRequest - tipo de solicitud
	@param {textarea} description - descripcion de la solicitud
	 */
	getParams(email, typeRequest, description){
		
		let params =[];
		params.push(`email=${email.value}`);
		params.push(`typeRequest=${typeRequest.value}`);
		params.push(`description=${description.value}`);
		return params.join("&");
	}
	
	//envio de los parametros al service y procesado de la respuesta
	sendReg(){
		
		let xhr = new XMLHttpRequest();
		xhr.open(this.method,this.action,true);
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		
		xhr.onreadystatechange = function(){
			if(this.readyState === XMLHttpRequest.DONE){
				if(this.status === 200){
					
					try{
						
						let json = JSON.parse(this.responseText);
						
						if(json.status){
							//actualizacion de los contadores
							let total = document.querySelector("h2#total");
							let regT1 = document.querySelector("h2#regT1");
							let regT2 = document.querySelector("h2#regT2");
							
							total.innerHTML = json.total;
							regT1.innerHTML = json.typeRequest1;
							regT2.innerHTML = json.typeRequest2;
							
							//Se anade el nuevo elemento a la lista						
							let data = `${json.typeRequest}->${json.email}->${json.description}`;
							let cv = new CreateViewReg();
							
							cv.addRegToView(data,json.total-1);
							
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
		//validacion de datos ingresados correctos, solo si estan correctos se hara peticion al service
		let validationDescription = new Validator();
		let description = document.querySelector("textarea#description");
		let email = document.querySelector("input#email");
		let type = document.querySelector("select#typeRequest");
		if(validationDescription.countWords(email.value)){
			console.log(email);
			if(validationDescription.countWords(description.value)){
				let params = this.getParams(
				email,
				type,
				description
			);
			
			xhr.send(params);
			}else{
				let alert = new bootstrap.Modal(document.querySelector("div#alert"));
				alert.show();
			}
		}else{
			let alert = new bootstrap.Modal(document.querySelector("div#alert"));
			alert.show();
		}
		
		
		description.value = "";
		email.value ="";
		
		
	}
	
	//Metodo para la limpieza del registro
	deleteReg(){
		let xhr = new XMLHttpRequest();
		xhr.open("GET","modules/controllers/deleteRegService.jsp",true);
		xhr.onreadystatechange = function(){
			if(this.readyState === XMLHttpRequest.DONE){
				if(this.status === 200){
					
					try{
						
						let json = JSON.parse(this.responseText);
						
						if(json.status){
							//Limpieza de la vista y reinicio de contadores
							let showReg = document.querySelector("div#regList");
							let descriptions = document.querySelector("div#descriptions");
							let total = document.querySelector("h2#total");
							let regT1 = document.querySelector("h2#regT1");
							let regT2 = document.querySelector("h2#regT2");
							
							descriptions.innerHTML ="";
							showReg.innerHTML = "";
							total.innerHTML = "0";
							regT1.innerHTML = "0";
							regT2.innerHTML = "0";
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
	
}