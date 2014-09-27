var _fireRef = new Firebase('https://goaltender.firebaseio.com');
var _user;
var _playerList;
var _userRef;
var skill;
var wins;
var losses;
var thumbnail;
var userlocation;
var auth = new FirebaseSimpleLogin(_fireRef, function(error, user) {
	if (error) {
		$("#state").text("error logging in");
		console.log(error);
	} else if (user) {
		_user = user;
		_userRef = new Firebase('https://goaltender.firebaseio.com/users/' + _user.id);
		_userRef.update({userData: user});
		$("#login").hide();
		$("#logout").show();
		$("#loadPics").show();
		_userRef.once('value', function(snapshot) {
			if(!snapshot.val().skill)
			{
				signUp();
			} else {
				loggedIn(user);
			}
		});
	} else {
		$("#logout").hide();
		$(".navUser").hide();
		$("#loadPics").hide();
		$("#login").show();
	}
});

$(document).ready(function(){
	$("#login").click(function(){
		console.log("login");
		auth.login("facebook");
	});
	$("#logout").click(function(){
		console.log("logout");
		auth.logout();
	});
	$("#matchTitle").click(function(){
		_userRef.update({passlist: null});
		var matchRef = new Firebase('https://goaltender.firebaseio.com/matches/' + _user.id);
		matchRef.remove();
		loadNewPlayer();
	});
	$("#chatTitle").click(function(){
		_userRef.once('value', function(snapshot){
			for(chatIDs in snapshot.val().chats){
				var chatID = snapshot.val().chats[chatIDs];
				var dataRef = new Firebase('https://goaltender.firebaseio.com/chats/' + chatID);
				dataRef.remove();
			}
			_userRef.child('chats').remove();
		});
	});
	$(".skilllevel .btn").click(function() {
		skill = $(this).attr('data-value');
		_userRef.update({skill: skill});
	});
	$(".btn-finish").click(function() {
		$("#sign-up").hide();
		loggedIn();
	});
});

function loggedIn() {
	console.log("loggedin");
	_userRef.on('value', function(snapshot) {
		wins = snapshot.val().wins;
		losses = snapshot.val().losses;
		skill = snapshot.val().skill;
		userlocation = snapshot.val().gpsLocation.coords;
		thumbnail = snapshot.val().thumbnail;
		$("#navUserStats").text(wins + " wins, " + losses + " losses");
		$('#navUserThumbnail').css('background-image', 'url(' + thumbnail + ')');
	});
	$(".navUser").show();
	$("#navUserName").text(_user.first_name);
	loadNewPlayer();
	//loadChats();
	loadChatList();
}

function signUp() {
	console.log("signup");
	var url = "https://graph.facebook.com/me/picture/";
	$.ajax({
		type: "GET",
		url: url,
		data : {
			"access_token": _user.accessToken,
			"type": "square",
			"redirect": "false",
			"height": 200,
			"width": 200
		},
		success: function(results){
			console.log(results);
			_userRef.update({picture: results.data.url});
		}
	});
	$.ajax({
		type: "GET",
		url: url,
		data : {
			"access_token": _user.accessToken,
			"type": "square",
			"redirect": "false",
		},
		success: function(results){
			console.log(results);
			_userRef.update({thumbnail: results.data.url});
		}
	});
	_userRef.once('value', function(snapshot) {
		var state = $('#state');
		if(!snapshot.val().gpsLocation || !snapshot.val().skill) {
			$("#sign-up").show();
			_userRef.update({wins: "0", losses: "0"});
		}
		if(!snapshot.val().gpsLocation) {
			console.log("UH OH - l");
			navigator.geolocation.getCurrentPosition(function(position) {
				var location = position;
				locationFound = true;
				_userRef.update({gpsLocation: location});
				console.log(location);
			});
		} else if(!snapshot.val().skill) {
			console.log("UH OH - s");
		} else {
			console.log("all g ;)");
		}
	});
}

function showPosition(position)
{
	x.innerHTML = "Latitude: " + position.coords.latitude + 
	"<br>Longitude: " + position.coords.longitude; 
}

function loadChatList()
{
	$('.chatUserListEntry').remove();
	_userRef.once('value', function(snapshot){
		for(chatIDs in snapshot.val().chats){
			var chatID = snapshot.val().chats[chatIDs];
			var chatRef = _fireRef.child('chats/' + chatID);
			var playerName;
			chatRef.once('value', function(snap){
				var currentChatID = snap.val().id;

				if(snap.val().guest == _user.first_name)
					playerName = snap.val().host;
				else
					playerName = snap.val().guest;
				console.log(playerName);
				$("#chatUserList").append("<button chatID='" + currentChatID + "' class='chatUserListEntry' onclick=\"loadChats('"+ currentChatID +"')\">" + playerName + " </button>");
			});
		}
	});
}

function loadChats(chatID) {
	$('.chatBox').remove();
	console.log("yo " + chatID);
	var chatRef = new Firebase('https://goaltender.firebaseio.com/chats/' + chatID);
	chatRef.once('value', function(snap){
		if(!snap.hasChildren()){
			console.log('removing ' + chatIDs);
			_userRef.child('chats/' + chatIDs).remove();
		} else {
			var playerName;
			if(snap.val().guest == _user.first_name)
				playerName = snap.val().host;
			else
				playerName = snap.val().guest;
			$('#chatting').append("<div class='chatBox'><div class='chatHeader'>" + playerName + "</div><div class='chatContent'></div><input type='text' class='chatInput'></div>");
			$('.chatInput').keypress(function (e) {
				if (e.keyCode == 13) {
					var text = $('.chatInput').val();
					var username = _user.first_name;
					if(!username)
						username = "Stranger";
					chatRef.child('messages').push({name: username, text: text});
					$('.chatInput').val('');
				}
			});
		}
	});
	chatRef.child('messages').on('child_added', function(snapshot) {
		var message = snapshot.val();
		$(".chatContent").append("<div class='chatLine'><div class='chatName'>" + message.name + ": </div><div class='chatMessage'>" + message.text + "</div></div>");
	});
}

function loadNewPlayer() {
	$(".matchbox").remove();
	var dataRef = new Firebase('https://goaltender.firebaseio.com/users/');
	dataRef.once('value', function(snapshot) {
		if($(".matchbox"))
			console.log("ugh");
		_playerList = snapshot;
		for(user in snapshot.val()){
			if(user != _user.id){
				var inList = false;				
				_userRef.once('value', function(usersnap) {
					for(player in usersnap.val().passlist){
						if(usersnap.val().passlist[player] == user)
							inList = true;
					}
				});

				if(!inList){
					var matchRef = new Firebase('https://goaltender.firebaseio.com/matches');
					var matchText = "Ask";
					matchRef.once('value', function(usersnap){
						if(usersnap.val()){
							for(match in usersnap.val()[user]){
								console.log(usersnap.val()[user][match]);
								if(usersnap.val()[user][match] == _user.id){
									matchText = "Match!";
									console.log("OMG <333");
									$("button#matchbox-play").text(matchText);
								}
							}
						}
					});
					console.log(snapshot.val()[user]);
					var name = snapshot.val()[user].userData.first_name;
					var wins = snapshot.val()[user].wins;
					var losses = snapshot.val()[user].losses;
					var skill = snapshot.val()[user].skill;

					if(snapshot.val()[user].gpsLocation){
						var playerLocation = snapshot.val()[user].gpsLocation.coords;
						var range = distance(userlocation.latitude, userlocation.longitude, playerLocation.latitude, playerLocation.longitude);
						$('#matching').append("<div class=\"matchbox\"><div class=\"matchbox-picture\"><div class=\"matchbox-picture-buttons\"><button type=\"button\" id=\"matchbox-pass\">Pass</button><button type=\"button\" id=\"matchbox-play\">" + matchText + "</button></div><img src=\"" + snapshot.val()[user].picture + "\"/></div><div class=\"matchbox-info\"><div class=\"matchbox-user-name\">" + name + "</div><div class=\"matchbox-user-stats\">" + wins + " wins, " + losses + " losses</div><div class=\"matchbox-user-skill\">" + skill + "</div><div class=\"matchbox-user-range\">" + range + "</div></div></div>");
					} else {
						$('#matching').append("<div class=\"matchbox\"><div class=\"matchbox-picture\"><div class=\"matchbox-picture-buttons\"><button type=\"button\" id=\"matchbox-pass\">Pass</button><button type=\"button\" id=\"matchbox-play\">" + matchText + "</button></div><img src=\"" + snapshot.val()[user].picture + "\"/></div><div class=\"matchbox-info\"><div class=\"matchbox-user-name\">" + name + "</div><div class=\"matchbox-user-stats\">" + wins + " wins, " + losses + " losses</div><div class=\"matchbox-user-skill\">" + skill + "</div><div class=\"matchbox-user-range\">?</div></div></div>");
					}
					$("#matchbox-pass").click(function() {
						var passRef = new Firebase('https://goaltender.firebaseio.com/users/' + _user.id +'/passlist');
						console.log("hey " + $(this));
						$(".matchbox").remove();
						passRef.push(user);
						loadNewPlayer();
					});
					$("#matchbox-play").click(function() {
						var playRef = new Firebase('https://goaltender.firebaseio.com/matches/' + _user.id);
						var passRef = new Firebase('https://goaltender.firebaseio.com/users/' + _user.id +'/passlist');
						console.log($("button#matchbox-play").text());
						playRef.push(user);
						passRef.push(user);

						if(matchText == "Match!"){
							var chatID = 'c' + _user.id + user;
							var msgRef = new Firebase('https://goaltender.firebaseio.com/users/' + _user.id +'/chats');
							var chatRef = new Firebase('https://goaltender.firebaseio.com/chats/' + chatID);
							var othermsgRef = new Firebase('https://goaltender.firebaseio.com/users/' + user +'/chats');
							othermsgRef.push(chatID);
							msgRef.push(chatID);
							if(!name)
								name = "Chat";
							var hostname = _user.first_name;
							if(!hostname)
								hostname = "Chat";
							chatRef.update({host: hostname, guest: name, id: chatID});
							loadChatList();
						}
						$(".matchbox").remove();
						loadNewPlayer();
					});
return;

}
}
}
});
}

function distance(lat1,lon1,lat2,lon2) {
	var R = 6371; // km (change this constant to get miles)
	var dLat = (lat2-lat1) * Math.PI / 180;
	var dLon = (lon2-lon1) * Math.PI / 180;
	var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
	Math.cos(lat1 * Math.PI / 180 ) * Math.cos(lat2 * Math.PI / 180 ) *
	Math.sin(dLon/2) * Math.sin(dLon/2);
	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
	var d = R * c;
	if (d>1) return Math.round(d)+"km";
	else if (d<=1) return Math.round(d*1000)+"m";
	return d;
}