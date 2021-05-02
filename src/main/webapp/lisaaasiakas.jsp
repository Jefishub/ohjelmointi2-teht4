<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
<style>
.oikealle{
	text-align: right;
}
</style>
</head>
<body>
<form id="tiedot">
	<table >
		<thead class="headers">	
			<tr>
				<th class="oikealle">Hakusana:</th>
				<th colspan="2"><input type="text" id="hakusana"></th>
				<th><input type="button" value="hae" id="hakunappi"></th>
			</tr>			
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>							
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="rekNo"></td>
				<td><input type="text" name="sukunimi" id="merkki"></td>
				<td><input type="text" name="puhelin" id="malli"></td>
				<td><input type="text" name="email" id="vuosi"></td> 
				<td><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function(){
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true,
				minlength: 1				
			},	
			sukunimi:  {
				required: true,
				minlength: 1				
			},
			puhelin:  {
				required: true,
				minlength: 1
			},	
			email:  {
				required: true,
				minlength: 5,
			}	
		},
		messages: {
			etunimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			email: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},			
		submitHandler: function(form) {	
			lisaaTiedot();
		}
	});
})


//funktio tietojen lisäämistä varten. Kutsutaan backin POST-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//POST /autot/
function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
    	$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
    }else if(result.response==1){			
    	$("#ilmo").html("Asiakkaan lisääminen onnistui.");
    	$("#etunimi", "#sukunimi", "#puhelin", "#email").val("");
		}
	}});	
}

</script>
</body>
</html>