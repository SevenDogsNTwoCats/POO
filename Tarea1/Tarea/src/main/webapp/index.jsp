<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Tarea</title>
		<meta name="author" content="alhanis.espinal@unah.hn">
		<meta name="date" content="2022/03/17">
		<meta name="version" content="0.1.1">
		<link rel="styleSheet" href="assets/css/styles.css">
	</head>
	<body>
		<section id="main">
			<h1>Agregar un texto cualquiera y filtrar sus palabras</h1>
			<p id ="main">Texto Cualquiera</p>
			<textarea id="text" rows = "5" cols ="50"></textarea>
			<br>
			<p id ="main">Expresión Regular</p>
			<input type="text" id ="regexp" >
			<br>
			<input type="button" id="sendButton" value ="Aplicar Expresion">
		</section>
		<hr>
		<section id="responseText">
		</section>
		
		<script src="assets/js/DynamicAnswer.js"></script>
		<script src="assets/js/Main.js"></script>
	
	</body>
</html>