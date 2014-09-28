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

	// $('.table-rx .table > tbody').append();

    console.log("Rx table refreshed");
});

// function addRxToTable(patient_id, drug, status) {
// 	console.log("addedRxToTable()");
// 	console.log(drug);
// 	console.log(drug.name);
// 	$('.table-rx .table > tbody:last').append('<tr>' + 
// 		'<td>' + patient_id + '</td>' + 
// 		'<td>' + drug.name + '</td>' + 
// 		'<td>' + drug.number + '</td>' + 
// 		'<td>' + drug.mass + '</td>' + 
// 		'<td>' + drug.quantity + '</td>' + 
// 		'<td>' + status + '</td>' + 
// 		'</tr>');
		
// 	};