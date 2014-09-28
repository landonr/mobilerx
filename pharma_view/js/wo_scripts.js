var myFirebaseRef = new Firebase("https://amber-inferno-3172.firebaseio.com/");


$(document).ready(function(){
	
	refresh_work_orders();

	function addRxToTable(id, patientId, patient_name, priority) {
		$('.table-wo .table > tbody:last').append('<tr>' + 
			'<td>' + patient_name + '</td>' + 
			'<td>' + priority + '</td>' + 
			'<td><a href="index.html?id=' + id + "&patientId=" + patientId + '" class="btn btn-default" id="createRx">Create Rx</a></td>' +

			'</tr>');
		console.log("addedRxToTable()");
	};

	function refresh_work_orders() {
		var wo_ref = myFirebaseRef.child('work_orders');
		wo_ref.on('value', function (snapshot) {
	
			snapshot.forEach(function(obj) {
				var id = obj.name()
				console.log(obj.val().doctorID);

				var priority = obj.val()["priority"];
				var patientId = obj.val()["patientId"];

				console.log(patientId);

				myFirebaseRef.child('patients/' + patientId).on('value', function(obj) {
					console.log(obj.val());

					addRxToTable(id, patientId, "Jason", priority.toUpperCase());

				}, function (errorObject) {
					console.log('The read failed: ' + errorObject.code);
				})
			})
			//GET PATIENT'S NAME
  			console.log(snapshot.val());
		}, function (errorObject) {
  			console.log('The read failed: ' + errorObject.code);
		});
	}
});


