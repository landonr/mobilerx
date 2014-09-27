var myFirebaseRef = new Firebase("https://dazzling-torch-5422.firebaseio.com/");


$(document).ready(function(){
	$(".test").click(function(){
		console.log("createRxclicked")
		createRx();
	});
});

function createRx() {
	console.log("createRxFcn");
	myFirebaseRef.set({
		"id": 1,
		"drug" : [{
			"name": "designer-drug",
			"number": 22,
			"mass": 22,
			"quantity": 2
		}],
		"patientId": 8675309,
		"status": "pending"
	});
}


