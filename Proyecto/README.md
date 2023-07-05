# **REG410**

@author alhanis.espinal@unah.hn
@version 0.1.3
@date 2022/04/26

# **1. Definición De Proyecto**
Creación de un programa de JAVA JSP para la administración de un sistema registros de solicitantes, haciendo uso de una única view y la comunicación con múltiples componentes Controller y Model. Con la integración de la operación de DTO, DAO y objetos de DOM, clases y otros objetos de Java y objetos en la web.

![image1](https://github.com/SevenDogsNTwoCats/Imagenes/blob/main/reg410-1.png)
![image2](https://github.com/SevenDogsNTwoCats/Imagenes/blob/main/reg410-2.png)
![image3](https://github.com/SevenDogsNTwoCats/Imagenes/blob/main/reg410-3.png)
![image4](https://github.com/SevenDogsNTwoCats/Imagenes/blob/main/reg410-4.png)
![image5](https://github.com/SevenDogsNTwoCats/Imagenes/blob/main/reg410-5.png)

## <center> **Requerimientos** </center>
1. Deberá existir una única View en todo el proyecto, donde se centraliza toda la funcionalidad del sistema, la cual invoca distintas ventanas modales de Bootstrap (https://getbootstrap.com/docs/5.1/components/modal/), con distintos Controller, Objetos, Javascripts, DTO y DAO para las diferentes funcionalidades del sistema.
2. Debe existir un menú superior que permita crear un nuevo registro. Esta acción deberá habilitar una ventana modal para la recepción de los datos de registro: correo, tipo y descripción.
3. Debe existir un menú superior que permita limpiar por completo el modelo de datos. Su programa deberá leer un archivo de modelo de datos en la ruta generada por Path() según el FileManager, sobre un archivo llamado DataSourceModel.csv.
4. Debe existir un menú superior que permita visualizar la información del autor del sistema, como una ventana modal que imprime la información de nombre, correo institucional, asignatura, fecha, docente y número de cuenta.

---
---
---
---

# **2. Análisis**

Información general del análisis de lo solicitado en el proyecto:

## **Primer Requerimiento**

La única view que contendrá el proyecto se ubicará en un archivo central ***index.jsp*** la cual contendrá el debido formato de diseño requerido, con los elementos de sistema como ser barras, cuadros de texto y botones, incluyendo de los debidos llamados a las clases de JavaScript que invoquen las ventanas modales, las cuales se comunicaran mediante botones con los controladores para el procesamiento de los datos.

## **Segundo Requerimiento**

Usando algunas de los diferentes formatos de barras de menú que permite Bootstrap (https://getbootstrap.com/docs/5.1/components/navbar/) se creara un menú desplegable el cual contendrá el botón de crear registros, botón el cual se manejara mediante una clase de JavaScript para asignarle su debida función para abrir la ventana modal.
La ventana modal contendrá un input de texto para el ingreso del correo electrónico, un input del tipo select con los diferentes tipos de solicitud y un textarea con un máximo de 200 palabras, además del botón de cancelar el cual cerrara la ventana modal, y el botón de guardar el cual enviará los datos al controlador quien con ayuda de la clase ***FileManager*** los guardará en un archivo de modelo de datos ***DataSourceModel.csv***, archivo del cual tambien se cargaran los datos para mostrarse en la vista.

## **Tercer Requerimiento**
La barra de menú desplegable contendrá el botón para limpiar los datos, botón el cual se manejará su acción mediante una clase de JavaScript quien se comunicara con un controller donde se asignará la función de buscar la ruta en la cual esta guardado el ***DataSourceModel.csv*** con ayuda de una clase ***FileManger*** y eliminará los datos almacenados.

## **Cuarto Requerimiento**
El menú superior contendrá el nombre del sistema el cual se ha decidido será REG410, unión de la palabra registro y código de la clase para la cual se desarrolla el proyecto y al lado aparecerá el nombre del autor del proyecto. También contendrá el botón ***“Acerca de”*** el cual abrirá una ventana modal la cual contiene información del autor y la asignatura.

---
---
---
---

# **3. Detalles de implementación**

---
---

## **3.1 SOBRE LA VISTA**

---
---

## <center>**index**</center>
El archivo index.jsp corresponde a la vista a la que tiene acceso el usuario, desde aqui el usuario puede administrar las solicitudes de registro: crear nuevos registros y eliminarlos desde la barra superior, además de visualizarlos y contabilizarlos en la vista.

***Ingreso a la aplicación***

Cuando un usuario ingresa al programa se hace un llamado mediante setTimeout() y usando la clase **Action.js** se cargan los registros existens en la vista.

            let action = new Action();
            setTimeout(action.runOneTime.bind(action), action.getTime);
***Botones para ventanas modales***

Los botones del sistema se manejan mediante la clase **BtnActions.js**: se crea una instancia de la clase, se obtine el ID del modal que corresponda, se selecciona el boton y se agrega un evento para abrir la ventana modal que corresponda.

		let instancia = new BtnActions();
		instacia.setId("IDModal");
		let seleccionBoton = document.querySelector("button#IDBoton");
		seleccionBoton.addEventListener("click", instancia .callModal
				.bind(instancia));

Para los botones que se agregan de forma dinamica cada vez que hay un nuevo registro, se leen todos los clicks sobre botones del documento, y se obtiene el ID; luego se comprueba que tengan el formato correcto y si es asi se obtiene la ventana modal a la que corresponda el boton, finalmente se aplica la logica anterior.           
            
		$(document).on("click","button",function() {
	        let btn = this.id;
	        //los botones de ventanas modales de descriptcion se enumeran
	        let id = Number(btn.split("-")[1]);
	        //Si tiene enumeracion entonces en efecto es un boton de ventana modal
	        if(!isNaN(id)){
	        	
	        	let actionBtnDescription = new BtnActions();
	        	/**las ventanas modales tambien se enumeran, la ventana modal correspondiende al boton de ver descripcion 
	        	"btn-1" es "descriptionModal1" por eso se anade el digito del boton a la cadena "descriptionModal" 
	        	*/
	        	let modal = "descriptionModal"+id;
	        	let button = "button#"+btn;
	        	//se hace el llamado correspondiente con el Id de la ventana modal y el evento del boton
	    		actionBtnDescription.setId(modal);
	    		let descriptionWindow = document.querySelector(button);
	    		descriptionWindow.addEventListener("click", actionBtnDescription.callModal
	    				.bind(actionBtnDescription));
	        }
	    });

---
---

## **3.2 SOBRE LAS CLASES DE JAVASCRIPT**

---
---

## <center>**Action**</center>
Esta es la clase que ejecutaca con setTimeuut cuando se ingresa al administrador. El metodo runOneTime() se encarga de cargar a la vista los registros existentes si los hay. Este se comunica con **firstTimeOutService.jsp** y el controlador le retorna true si existe el archivo con registros y false si no los hay, si los hay entonces refresca los elemntos de la vista con la clase **createViewReg.js**.

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

---

## <center>**createViewReg**</center>

Metodo para agregar los registros a la vista. El metodo addToView() agrega los elementos correspondientes a la vista. recibiendo un string que contiene los datos de registros.

        //separar los diferentes resgistros
		let data = datas.split("<->");
		let regList = document.querySelector("div#regList");
		let div = document.createElement("div");
		div.className = "card";
	
		let ul = document.createElement("ul");
		ul.className = "list-group list-group-flush";
								
		let descriptions = document.querySelector("div#descriptions");

		//Cada registro se anade  a la lista un formato numero | tipo de registro + correo | boton ver descripcion					
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

---

## <center>**BtnActions**</center>

Clase concreta para la ejecucion de una accion para la apertura de un modal. El metodo setId() recibe el Id de la ventana modal que se tiene que abrir, y el metodo callModal() hace el llamado.

        setId(modalId){
            this.modalId=modalId;
        }
        
        callModal(){
            let modal = new bootstrap.Modal(document.querySelector(`#${this.modalId}`));
            modal.show();
        }

---

## <center>**RegManager**</center>

Clase para la creacion de un nuevo registro. El metodo senReg() envia los datos ingresados de descripcion, email y tipo de registro al controlador **newRegService.jsp**, el service retona un json con status=true y los datos si se crear un nuevo registro, o con status = false si el servidor no pudo generar una respuesta.
Si se pudo generar una respuesta se agregan los registros a la vista con ayuda de la clase CreateViewReg() y se aumenta en uno los contadores que correspondan. Si no se pudo generar una respuesta se abre una ventana de error para avisar al usuario.

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

El metodo deleteReg() se comunica con el controlador **deleteRegService.jsp** para eliminar el archivo donde se almacenan los registros creados, este retorna un json con status=true si se pudo borrar, o igual false si hubo algun error. Si se pudo borrar se limpia la lista de registros y se reinician los contadores. SI no se imprime mensaje de error.

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

---

## <center>**Validator**</center>

Clase para la validacion de texto. El metodo countWords() cuenta las palabras de un texto  retorna true si contiene menos de 200 palabras o false si contiene mas o esta vacio.

        // /\W/g split con expresion regular de todo lo que no se palabra
		let words = text.split(/\W/g).length;
		if(text!=="" && words < 200 ){
			return true;
		}
		return false;

---
---

## **3.3 SOBRE LOS CONTROLADORES**

---
---
## <center>**firstTimeOutService**</center>

Service para cada vez que se ingresa a la aplicacion. Este controlador carga los registros a la vista si es que hay para ello crea una instancia de **FileMnager.java** y **FileManagerResponse.java** y comprueba que hay registros en el archivo, si es asi los carga con ayuda de la clase **DAOReg.java**, y cuenta los registros con ayuda de la clase **FirstTimeOutManager.java**, finalmente guarda los contadores en un DTO **RegDTO.java**, los agreaga a la session y retorna los datos en json.

	//obtencion de los datos
	RegDTO regDTO = new RegDTO();
	FirstTimeOutManager cm = new FirstTimeOutManager();
	DAOReg dao = new DAOReg("Documentos/DataSourceModel.csv");
	String data = dao.getData();
	
	//se cuentan cuantos resgistros totales y de cada tipo hay
	int total = cm.getTotal();
	int regT1 = cm.getTypeRequest1();
	int regT2 = cm.getTypeRequest2();
	
	//se anaden los contadores a la sesion
	regDTO.setTotalReg(total);
	regDTO.setTypeRequest1(regT1);
	regDTO.setTypeRequest2(regT2);
	session.setAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE, regDTO);
	
	//json respuesta
	StringBuilder json = new StringBuilder("{");	
    json.append(String.format("\"status\": %s,",true));
    json.append(String.format("\"total\": %s,",total));
    json.append(String.format("\"typeRequest1\": %s,",regT1));
    json.append(String.format("\"typeRequest2\": %s,",regT2));
    json.append(String.format("\"data\": \"%s\"",data));
    
    json.append("}");
    
    out.print(json.toString().replaceAll("\\n+",""));

---

## <center>**deleteRegService**</center>

Service para la limpiar los registros. Este controlador elimina el archivo de registros, y limpia los contadores del DTO de la sesion, ademas retorna un json con status=true para corrobar que se han eliminado los datos y si es asi posteriormente el metodo deleteReg() de la clase **RegManager.js** pueda limpiar la vista.

        //acceso al archivo que contiene los datos para eliminarlo
        FileManager fm = new FileManager();
        FileManagerResponse fmr = fm.delete("Documentos/DataSourceModel.csv");
        RegDTO regDTO = (RegDTO) session.getAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE);
        //se reinician los contadores a 0
        regDTO.setTotalReg(0);
        regDTO.setTypeRequest1(0);
        regDTO.setTypeRequest2(0);
        session.setAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE, regDTO);
        
        //json respuesta
        StringBuilder json = new StringBuilder("{");
        
        json.append(String.format("\"status\": %s",fmr.isStatus()));
            
        json.append("}");
        
        out.print(json.toString().replaceAll("\\n+",""));

---

## <center>**newRegService**</center>

Service para la creacion de un nuevo registro. Este controlador se encarga de generar una respuesta con los datos recibidos, y agregar tanto los registros a un archivo **DataSourceModel.csv** como de aumentar los contadores en +1 del DTO de la session. Para retornar un json con la respuesta.

        //clase para la creacion de un un nuevo registro
        NewRegManager newReg = new NewRegManager(request);
        String typeRequest = newReg.getTypeRequest();
        String description = newReg.getDescription();
        String email = newReg.getEmail();
        //obtencion del DTO que ocntiene los contadores mediante la session
        RegDTO regDTO = (RegDTO) session.getAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE);
        
        //json respuesta
        StringBuilder json = new StringBuilder("{");
        
        if (typeRequest.matches("No Request")){
            
            json.append(String.format("\"status\": %s,",false));
            json.append(String.format("\"message\": \"%s\"","El tipo de solicitud no es valida."));
            
            
        }else{
            json.append(String.format("\"status\": %s,",true));
            
            //si se puedo crear un nuevo regsitro se aumenta en uno el contador total
            // y el contador del tipo al que corresponda
            regDTO.setTotalReg(regDTO.getTotalReg()+1);
            if(typeRequest.matches("Tipo1")){
                regDTO.setTypeRequest1(regDTO.getTypeRequest1()+1);
            }else if(typeRequest.matches("Tipo2")){
                regDTO.setTypeRequest2(regDTO.getTypeRequest2()+1);
            }
            //actualizacion de los nuevos contadores en la sesion
            session.setAttribute(FirstTimeOutManager.COUNTMANAGER_DTO_ATTRIBUTE, regDTO);
            boolean writeStatus = newReg.writeData();
            
            json.append(String.format("\"email\": \"%s\",",email));
            json.append(String.format("\"typeRequest\": \"%s\",",typeRequest));
            json.append(String.format("\"description\": \"%s\",",description)); 
            json.append(String.format("\"writeCsvStatus\": %s,",writeStatus));
            json.append(String.format("\"total\": %s,",regDTO.getTotalReg()));
            json.append(String.format("\"typeRequest1\": %s,",regDTO.getTypeRequest1()));
            json.append(String.format("\"typeRequest2\": %s",regDTO.getTypeRequest2()));
            
        }
        json.append("}");
        
        out.print(json.toString().replaceAll("\\n+",""));

---
---

## **3.4 SOBRE LAS CLASES DE JAVA**

---
---

## <center>**DAOReg**</center>

Objeto de acceso a datos. Accede a un archivo y retorna el contenido, con cierto formato, en este caso se retorna como cadena de texto.

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

---

## <center>**FileManager y FileManagerResponse**</center>

Files Managers para la lectura o escritura de archivos.

---

## <center>**FirstTimeOutManager**</center>

Objeto para la obtencion de la cantidad de registros cada vez que se ingresa a la aplicacion, es un DTOManager. Contiene una variable COUNTMANAGER_DTO_ATTRIBUTE = "counter" para agregarlo como atributo a la sesion con los contadores. En el contructor hace la lectura del contenido y crea una Lista< String> con los datos.

		FileManager fm = new FileManager();
		FileManagerResponse fmr = fm.read("Documentos/DataSourceModel.csv");
		if(fmr.isStatus()) {
			String textContent = fmr.getContent();
			String[] textLines = textContent.split("<->\\n+");
			
			for(String row: textLines) {
				String[] columns = row.split("->");
				this.data.add(columns[0]);
			}
		}

La cual sirve para contar los tipos de registros y el total, los cuales se bueden obtener mediante los metodos getTotal(), getTypeRequest2(), y getTypeRequest1().

	public int getTotal() {
		
		int count=0;
		
		for (String element: data) {
		    count++;
		}
		
		return count;
	}

#puede ser 1 o 2

	public int getTypeRequest#() {
		
		int count=0;
		
		for (String element: data) {
            
			if(element.matches("Tipo#")) {
				count++;
			}
				
		}
		
		return count;
	}

---

## <center>**NewRegManager**</center>

Clase para la creacion de nuevo registro. Aqui se recibe el request en el constructor de la clase y se obtiene los parametros.

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

y con el metodo writeData() se guardan en un archivo de nombre **DataSourceModel.csv** el cual se crea en la ruta Documentos: "Documentos/DataSourceModel.csv".

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

Ademas cuenta con los setter and getters para obtener o modificar el tipo de solicitud, email, y descripcion.

---

## <center>**RegDTO**</center>

Objeto para la transferencia datos, en este caso en concreto para los contadores. contiene las variables totalReg, typeRequest1, typeRequest2 y sus setter and getters.

---
---
---
---
