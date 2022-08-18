
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="alhanis.espinal@unah.hn">
<meta name="date" content="2022/04/25">
<meta name="version" content="0.1.3">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
	integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
	crossorigin="anonymous">

<title>Administrador de Registros</title>
</head>
<body>
<!-- Contenedor para la barra de navegacion -->

	<div class="container" id="navBar">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="#">REG410 - Alhanis Espinal</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarText" aria-controls="navbarText"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<div class="btn-group" role="group">
							<button id="regButton" type="button"
								class="btn btn-primary dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false">Registros</button>
							<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
								<button type="button" id="newRegButton" class="btn btn-success form-control">Nuevo
									Registro</button>
								<button type="button"
									class="btn btn-outline-danger form-control" id="deleteRegButton">Limpiar
									Registro</button>
							</div>
							</div>
					</li>

					<li class="nav-item"><button type="button"
							class="btn btn-link" id="infoButton">Info Author</button></li>
				</ul>
				<span class="navbar-text"> Administrador de Registros </span>
			</div>
		</nav>
	</div>

<!-- Contenedor para la visualizacion de las solicitudes de registro que se creen -->
	<div class="container" id="viewReg">
		<div class="row">
<!-- Region del listado de solicitudes de registros que hay en el sistema -->
			<div class="col-8" id="regListView">
				<h4 class="text-center">Listado de registros actuales en el
					modelo de datos</h4>
				<div id="regList">
				
				</div>
			</div>
<!--  Region de contadores -->
			<div class="col justify-content-center">
				<h4>
					<small class="text-muted">Contadores</small>
				</h4>
				<div class="card text-white bg-dark mb-3"  style="max-width: 18rem;">
					<div class="card-header">Cantidad de registros</div>
					<div class="card-body">
						<h2 class="text-center" id = "total"></h2>
					</div>
				</div>
				
				<div class="card text-white bg-danger mb-3"  style="max-width: 18rem;">
					<div class="card-header">Cantidad de Tipo solicitud 1</div>
					<div class="card-body">
						<h2 class="text-center" id="regT1"></h2>
					</div>
				</div>
				<div class="card text-white bg-warning mb-3" 
					style="max-width: 18rem;">
					<div class="card-header">Cantidad de Tipo solicitud 2</div>
					<div class="card-body">
						<h2 class="text-center" id="regT2"></h2>
					</div>
				</div>

			</div>

	</div>
	</div>
<!-- Region de los modales -->
<!-- Modal Para la informacion de autor -->
	<div class="modal" id="infoModal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Información del Autor</h5>
				</div>
				<div class="modal-body">
					<p class="text-justify">Programa para la administración de un
						sistema de registro de solicitantes.</p>
					<p class="text-justify">
						Alhanis Espinal<br> cta. 20181031451<br>
						alhanis.espinal@unah.hn.
					</p>
					<footer class="blockquote-footer">
						Universidad Nacional Autónoma de Honduras.<br> Programacion
						Orientada a Objetos, IS-410. Jose Inestroza,
						jose.inestroza@unha.edu.hn.
					</footer>
					<p class="text-muted text-right"">v0.1.3. 2022/04/25</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
				</div>
			</div>
		</div>
	</div>
<!-- Modal para la creacion de un nuevo registro -->
		<div class="modal" id="newRegModal" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Crear un nuevo registro</h5>
					</div>
					<div class="modal-body">
						<p>Correo Electrónicodel solicitante</p> 
						<input id="email" class="form-control" type="email" class="form-control" id="email"
							placeholder="nombre@institucion.com" style="border-bottom-width: 1px;margin-bottom: 25px;"> 
						<p>Tipo de solicitud</p> 
						<select  name="typeRequest" id="typeRequest" class="form-control" style="border-bottom-width: 1px;margin-bottom: 25px;">
							<option value="1">Tipo 1</option>
							<option value="2">Tipo 2</option>
						</select> 
						<p>Descripción de la solicitud</p>
						<textarea class="form-control" name="message" id="description"
							placeholder="Escriba una descripción de su solicitud con un maximo de 200 palabras"
							style="border-bottom-width: 1px; margin-bottom: 25px;" required></textarea>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
						<button type="button" id ="saveButton" class="btn btn-success" data-dismiss="modal">Guardar</button>
					</div>
				</div>
			</div>
		</div>
<!-- Modal para la confirmacion de eliminacion de registros -->	
			<div class="modal" id="deleteRegModal" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Limpiar Registros</h5>
					</div>
					<div class="modal-body">
						<p>Se eliminarán todas las solicitudes de registros. ¿Desea continuar?</p> 
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
						<button type="button" id="cleanRegButton" class="btn btn-warning" data-dismiss="modal">Borrar</button>
					</div>
				</div>
			</div>
		</div>
<!-- Modal para la alerta por exceder el maximo de palabras -->	
			<div class="modal" id="alert" tabindex="-1">
			<div class="modal-dialog">
					<div class="alert alert-warning absolute" role="alert">
						<p >Ingrese datos correctos. Correo y descripción con máximo de 200 palabras, obligatorios.</p>
					</div>
			</div>
		</div>
<!-- Modal para la alerta de errores y excepciones-->	
			<div class="modal" id="alertError" tabindex="-1">
			<div class="modal-dialog">
					<div class="alert alert-danger absolute" role="alert">
						<p id="error"></p>
					</div>
			</div>
		</div>
<!-- Region para la hubicacion de los modales de descripcion de registros -->
		<div id="descriptions">
		</div>

		<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF"
		crossorigin="anonymous"></script>
		<script src="modules/assets/js/CreateViewReg.js"></script>
	<script src="modules/assets/js/BtnActions.js"></script>
	<script src="modules/assets/js/Action.js"></script>
	<script src="modules/assets/js/RegManager.js"></script>
	<script src="modules/assets/js/Validator.js"></script>
	<script type="text/javascript">
	
	//Eventos de los botones 
			
		//cargar informacion al ingresar
		let action = new Action();
		setTimeout(action.runOneTime.bind(action), action.getTime);
		
		/**
		Evento del boton para visualizar la informacion de autor
		*/
		let actionBtnInfo = new BtnActions();
		actionBtnInfo.setId("infoModal");
		let infoWindow = document.querySelector("button#infoButton");
		infoWindow.addEventListener("click", actionBtnInfo.callModal
				.bind(actionBtnInfo));
		
		/**
		Evento del boton para crear nuevo registro
		*/
		let actionBtnNewReg = new BtnActions();
		actionBtnNewReg.setId("newRegModal");
		let newRegWindow = document.querySelector("button#newRegButton");
		newRegWindow.addEventListener("click", actionBtnNewReg .callModal
				.bind(actionBtnNewReg));
		
		/**
		Evento del boton para guardar el registro que se esta creando
		*/
		let rm = new RegManager();
		let saveRegBtn = document.querySelector("button#saveButton");
		saveRegBtn.addEventListener("click", rm.sendReg.bind(rm));
		
		let deleteRegBtn = document.querySelector("button#cleanRegButton");
		deleteRegBtn.addEventListener("click", rm.deleteReg.bind(rm));
		
		/**
		Evento del boton para limpiar los registros
		*/
		let actionBtndeleteReg = new BtnActions();
		actionBtndeleteReg.setId("deleteRegModal");
		let deleteRegWindow = document.querySelector("button#deleteRegButton");
		deleteRegWindow .addEventListener("click", actionBtndeleteReg.callModal
				.bind(actionBtndeleteReg));
		
		/**Se lee el boton al que se le da click y si es un boton para una ventana de descripcion
		se llama a la clase para que abra la ventana modal, aqui se hace la lectura de cada boton al que el usuario le da click 
		para confirmar que es un boton de "ver descripcion"
	*/
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

		
	</script>

</body>
</html>