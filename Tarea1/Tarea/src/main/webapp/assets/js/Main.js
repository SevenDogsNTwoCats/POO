/**
* Envia los datos al backEnd para la generacion de la respuesta
* @author alhanis.espinal@unah.hn
* @date 2022/03/17
* @version 0.1.1
 */
	let dynamicAnswer = new DynamicAnswer();
	
	let sendButton = document.querySelector("input#sendButton");
	sendButton.addEventListener("click", dynamicAnswer.send.bind(dynamicAnswer));