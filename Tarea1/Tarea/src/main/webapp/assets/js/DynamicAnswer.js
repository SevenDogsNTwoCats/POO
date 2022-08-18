/**
* Respuesta dinamica del la aplicacion del filtro
* @author alhanis.espinal@unah.hn
* @date 2022/03/18
* @version 0.1.1
 */

class DynamicAnswer{
	
	constructor(){
		this.method = "post";
		this.action = "service.jsp"
	}
	
	/**
	* Obtener parametros de texto y expresión regular para aplicar el filtro.
	*@param {textarea} text - texto al que se le aplicara el filtro.
	* @param {input} regexp - expresión regular para aplicar el filtro.
	 */
	 
	getParamsFrom(text,regexp){
		let request = `text=${text.value}&regExp=${regexp.value}`;
		return request;
	}
	

	/**
	* Generacion de la respuesta de manera asincrona
	 */
	send(){
		
		//creacion del xhr
		let xhr = new XMLHttpRequest();
		xhr.open(this.method,this.action,true);
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		
		//generacion de la respuesta en pantalla
		xhr.onreadystatechange = function(){
			
			if(this.readyState == XMLHttpRequest.DONE){
				if(this.status==200){
					
					//manejo de posibles exepciones
					try{
						
						let json = JSON.parse(this.responseText);
							
						//demostracion de la respuesta en consola
						console.table(json);
						
						let dynamicAnswer = document.querySelector("section#responseText");
						
						//se limpia la seccion de respuesta dinamica por si existe una respuesta anterior
						dynamicAnswer.innerHTML ="";
						dynamicAnswer.appendChild(document.createElement("br"));
						
						let finalContent = document.createElement("div");
												
						if(json.status){
							//Mostrar aplicacion del filtro
							let text = document.createElement("p");
							text.innerText = json.responseText;
							finalContent.appendChild(text);
							
						}else{
							//Si no se pudo aplicar el filtro en el service
							let colorHint = document.createElement("div");
							colorHint.style.backgroundColor = "red";
							colorHint.style.color= "white";
							colorHint.innerHTML = json.message;
							
							finalContent.appendChild(colorHint);
						}
						
						dynamicAnswer.appendChild(finalContent);
						
					}catch(exception){
						// Manejo de la exepcion
						let dynamicAnswer = document.querySelector("section#responseText");
						
						let colorHint = document.createElement("p");
						colorHint.style.backgroundColor = "red";
						colorHint.style.color= "white";
						colorHint.innerHTML = `Se ha generado un error en la pagina web. Favor refresque el navegador y vuelva a intentarlo.`;
						dynamicAnswer.appendChild(colorHint);
						
						colorHint = document.createElement("p");
						colorHint.style.backgroundColor = "red";
						colorHint.style.color= "white";
						colorHint.innerHTML = `La excepcion generada por el sitio es: ${exception}`;				
						dynamicAnswer.appendChild(colorHint);
						
					}
					
				}else{
					//Manejo de status report
					let dynamicAnswer = document.querySelector("section#responseText");
					
					let colorHint = document.createElement("p");
					colorHint.style.backgroundColor = "red";
					colorHint.style.color= "white";
					colorHint.innerHTML = `Se ha generado un error en la pagina web. Favor refresque el navegador y vuelva a intentarlo.`;
					dynamicAnswer.appendChild(colorHint);
					
					colorHint = document.createElement("p");
					colorHint.style.backgroundColor = "red";
					colorHint.style.color= "white";
					colorHint.innerHTML = `El codigo de respuesta generado es: ${this.status}`;				
					dynamicAnswer.appendChild(colorHint);
				
				}
				
			}
			
		}
		//Envio de parametros al service
		let params = this.getParamsFrom(
			document.querySelector("section#main").querySelector("textarea#text"),
			document.querySelector("section#main").querySelector("input#regexp")
		);
		xhr.send(params);
	}
	
}