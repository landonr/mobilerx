var myFirebaseRef = new Firebase("https://amber-inferno-3172.firebaseio.com/");
var rx_ref = myFirebaseRef.child('rx');

$(document).ready(function(){	
	$("#createRx").click(function(){
		console.log("createRxclicked")

		var patient_id = $('#patient-id').val();
 		var drug_name = $('#drug-name').val();
 		var drug_number = $('#drug-number').val();
 		var drug_mass = $('#drug-mass').val();
 		var drug_quantity = $('#drug-quantity').val();

 		rx_ref.push({
 			patientId: patient_id,
 			drug: {
 				name: drug_name,
 				number: drug_number,
 				mass: drug_mass,
 				quantity: drug_quantity
 			},
 			status: "pending"
 		});
	});
});

function GetURLParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');

    for (var i = 0; i < sURLVariables.length; i++)
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam)
        {
            return sParameterName[1];
        }
    }
}

function loadImage()
{
	var orderID = GetURLParameter('id')
	//console.log(GetURLParameter('id'));
	var _patientID;
	if (typeof GetURLParameter('id') !== "undefined") {
		$('#patient-id').val(GetURLParameter('id'));
		_patientID = GetURLParameter('patientId')
	}
	var canvas = document.getElementById("canvas");
	var wo_ref = myFirebaseRef.child('work_orders');
	wo_ref.on('value', function (snapshot) {
		snapshot.forEach(function(obj) {
			if(obj.name()==orderID){
				var jpegData = obj.val()["image"];
				var jpegUrl = canvas.toDataURL(jpegData); //
				var ctx = canvas.getContext("2d");
				if(ctx){
					var image = new Image();
					image.src = jpegUrl;
					image.onload = function() {
						ctx.drawImage(image, 0,0);
						ctx.fillStyle = "rgb(200,0,0)";  
						ctx.fillRect(10, 10, 55, 50);
					}
				}
			}
		});
	});
}

// new Rx table update
rx_ref.on('value', function(snapshot) {
	console.log("Rx added to Firebase");

	$('.table-rx .table > tr').remove();

	console.log(snapshot.val());

	$.each(snapshot.val(), function (key, val) {

		console.log('.eachcalled');

		var rx = '<tr><td>' + val.patientId + '</td>' +
			'<td>' + val.drug.name + '</td>' +
			'<td>' + val.drug.number + '</td>' +
			'<td>' + val.drug.mass + '</td>' +
			'<td>' + val.drug.quantity + '</td>' +
			'<td>' + val.status + '</td></tr>';
	    
	    $('.table-rx .table > tbody').append(rx);
    });

    console.log("Rx table refreshed");
});

loadImage();