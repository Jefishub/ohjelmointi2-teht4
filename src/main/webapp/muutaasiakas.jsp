<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaan tietojen muutos</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table >
		<thead class="headers">	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="2" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>S?hk?posti</th>							
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="email" id="email"></td> 
				<td><input type="button" id="tallenna" value="Hyv?ksy" onclick="vieTiedot()"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">	
</form>
<span id="ilmo"></span>
<script>
function tutkiKeyX(event){
	if(event.keyCode==13){//Enter
		vieTiedot();
	}		
}
var tutkiKey = (event) => {
	if(event.keyCode==13){//Enter
		vieTiedot();
	}	
}

document.getElementById("etunimi").focus();//vied??n kursori rekno-kentt??n sivun latauksen yhteydess?

//Haetaan muutettavan asiakkaan tiedot. Kutsutaan backin GET-metodia ja v?litet??n kutsun mukana muutettavan tiedon id
//GET /asiakkaat/haeyksi/asiakas_id
var asiakas_id = requestURLParam("asiakas_id"); //Funktio l?ytyy scripts/main.js 
document.getElementById("asiakas_id").value = asiakas_id;
console.log(asiakas_id)
fetch("asiakkaat/haeyksi/" + asiakas_id,{//L?hetet??n kutsu backendiin
      method: 'GET'	      
    })
.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastausteksti objektiksi
	return response.json()
})
.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss?	
	console.log(responseJson);
	document.getElementById("etunimi").value = responseJson.etunimi;		
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("email").value = responseJson.email;
});	

//Funktio tietojen muuttamista varten. Kutsutaan backin PUT-metodia ja v?litet??n kutsun mukana muutetut tiedot json-stringin?.
//PUT /autot/
function vieTiedot(){	
	var ilmo="";
	var d = new Date();
	if(document.getElementById("etunimi").value.length<1){
		ilmo="Etunimi ei kelpaa!";		
	}else if(document.getElementById("sukunimi").value.length<1){
		ilmo="Sukunimi ei kelpaa!";		
	}else if(document.getElementById("puhelin").value.length<1){
		ilmo="Puhelinnumero ei ole kelvollinen!";		
	}else if(document.getElementById("email").value.length<1){
		ilmo="S?hk?posti ei ole kelpaa!";				
	}
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
		return;
	}
	document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
	document.getElementById("email").value=siivoa(document.getElementById("email").value);	
	
	var formJsonStr=formDataToJSON(document.getElementById("tiedot")); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);
	//L?het??n muutetut tiedot backendiin
	fetch("asiakkaat",{//L?hetet??n kutsu backendiin
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
		return response.json();
	})
	.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss?	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Tietojen p?ivitys ep?onnistui";
        }else if(vastaus==1){	        	
        	document.getElementById("ilmo").innerHTML= "Tietojen p?ivitys onnistui";			      	
		}	
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset(); //tyhjennet??n tiedot -lomake
}
</script>
</body>
</html>