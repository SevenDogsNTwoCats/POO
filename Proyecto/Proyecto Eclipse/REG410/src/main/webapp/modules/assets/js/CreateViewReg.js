/**
Clase para mostrar la lista de registros en la vista
@author alhanis.espinal@unah.hn
@version 0.1.0
@date 2022/04/25
 */
class CreateViewReg{
	constructor(){}
	
		/**
	* Metodo para agregar los registros a la vista
	*@param {String} datas - datos del DataSourceModel.csv
	* @param {int} count - total de resgistro actuales
	 */
	addRegToView(datas, count){
		//separar los diferentes resgistros
		let data = datas.split("<->");
		let regList = document.querySelector("div#regList");
		let div = document.createElement("div");
		div.className = "card";
	
		let ul = document.createElement("ul");
		ul.className = "list-group list-group-flush";
								
		let descriptions = document.querySelector("div#descriptions");
		//Cada registro se anade  a la lista un formato numero | tipo de registro + correo | boton ver descripcio						
		for(let element of data){
			count++;
			let  row = document.createElement("div");
			row.className ="row";
			let  colNum = document.createElement("div");
			colNum.className = "col-2 text-center";
			let  colType = document.createElement("div");
			colType.className = "col-6";
			let  colDescription = document.createElement("div");
			colDescription.className = "col text-nowrap";
			let button = document.createElement("button");
			button.className = "btn btn-outline-info form-control";
			button.innerHTML = "Ver Descripción";
			button.id = `btn-${count}`;
										
			let info = element.split("->");
			let  num = document.createElement("h6");
			num.style.color = "blue";
			let type = document.createElement("h6");
			let email = document.createElement("p");
			email.className = "text-muted";
			let li = document.createElement("li");
			li.className = "list-group-item";
										
			num.innerHTML = count;
			type.innerHTML = info[0];
			email.innerHTML = info[1];
										
			colNum.appendChild(num);
			colType.appendChild(type);
			colType.appendChild(email);
			colDescription.appendChild(button);
		
										
			row.appendChild(colNum);
			row.appendChild(colType);
			row.appendChild(colDescription);
										
			li.appendChild(row);
			ul.appendChild(li);
			div.appendChild(ul);
			regList.appendChild(div);
			//creacion de la ventana modal para ver la descripcion			
			let descriptionModal = document.createElement("div");
			descriptionModal.id= `descriptionModal${count}`;
			descriptionModal.className = "modal";
										
			let content = document.createElement("div");
			content.className = "modal-dialog modal-lg";
										
			let modalContent = document.createElement("div");
			modalContent.className = "modal-content";
										
			let modalBody = document.createElement("div");
			modalBody.className = "modal-body";
			let text = document.createElement("p");
			text.innerHTML = info[2];
			modalBody.appendChild(text);
										
			let modalFooter = document.createElement("div");
			modalFooter.className = "modal-footer";
										
			let buttonModal = document.createElement("button");
			buttonModal.className = "btn btn-primary";
			buttonModal.setAttribute("data-dismiss", "modal");
	
			buttonModal.innerHTML = "Ok";
										
			modalFooter.appendChild(buttonModal);
			modalContent.appendChild(modalBody);
			modalContent.appendChild(modalFooter);
			content.appendChild(modalContent);
			descriptionModal.appendChild(content);
										
			descriptions.appendChild(descriptionModal);
			
		}
	}
}