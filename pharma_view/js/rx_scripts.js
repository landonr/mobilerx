var myFirebaseRef = new Firebase("https://amber-inferno-3172.firebaseio.com/");
var rx_ref = myFirebaseRef.child('rx');


$(document).ready(function(){

	console.log(GetURLParameter('id'));

	if (typeof GetURLParameter('id') !== "undefined") {
		$('#patient-id').val(GetURLParameter('id'));
	}
	
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

// serial -> jpeg
var canvas = document.getElementById("rx-image");
var jpegUrl = canvas.toDataURL(); //
document.getElementById("rx-image").value = jpegUrl;