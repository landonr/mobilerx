var myFirebaseRef = new Firebase("https://amber-inferno-3172.firebaseio.com/");


$(document).ready(function(){
	$("#createRx").click(function(){
		console.log("createRxclicked")

		var patient_id = $('#patient-id').val();
 		var drug_name = $('#drug-name').val();
 		var drug_number = $('#drug-number').val();
 		var drug_mass = $('#drug-mass').val();
 		var drug_quantity = $('#drug-quantity').val();

 		var rx_ref = myFirebaseRef.child('rx');

 		rx_ref.push({
 			patientId: patient_id,
 			drug: [{
 				name: drug_name,
 				number: drug_number,
 				mass: drug_mass,
 				quantity: drug_quantity
 			}],
 			status: "pending"
 		});

	});

	// new Rx table update
	myFirebaseRef.on('child_added', function(snapshot) {
		console.log("RxAdded to Firebase");

		var rx = snapshot.val();

		addRxToTable(rx.patientId, rx.drug, rx.status);
        console.log("RxAdded to table");
	});

	function addRxToTable(patient_id, drug, status) {
		$('.table-rx .table > tbody:last').append('<tr>' + 
			'<td>' + patient_id + '</td>' + 
			'<td>' + drug.child('0').name + '</td>' + 
			'<td>' + drug[0].number + '</td>' + 
			'<td>' + drug[0].mass + '</td>' + 
			'<td>' + drug[0].quantity + '</td>' + 
			'<td>' + status + '</td>' + 
			'</tr>');
		console.log("addedRxToTable()");
	};
});


