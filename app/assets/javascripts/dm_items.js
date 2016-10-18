
$(document).on("turbolinks:load", function() {
	console.log("load");
});

$(document).ready(function() {
	generateId();
});

// Non-expiring session token for an AS user
var token = "";

// Base url for your ArchivesSpace instance, including the backend port number
var baseURL = "http://localhost:8089"

$(document).on('click', '#find_in_as', function(e) {
//	console.log("click!");
	var refid = document.getElementById('dm_item_refid').value;
//	console.log(refid);
	var params = "ref_id[]=" + refid;
//	console.log(params);
	e.preventDefault();
	getResults(params, refid);
});



function generateId() {
	if (document.getElementById('dm_item_auto_id').value == "") {
//		console.log('no id');
		var auto_id = createId()
		document.getElementById('dm_item_auto_id').value = auto_id
	} else {
		console.log('has id');
	}
}

function createId() {
	var text = "";
	var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
	for( var i=0; i < 10; i++ )
		text += possible.charAt(Math.floor(Math.random() * possible.length));
	return text;
}

function getResults(data, refid) {
//	console.log(data)
//  console.log("getResults started")
	$.ajax({
    type: "GET",
    dataType: "json",
    beforeSend: function(request) {
      request.setRequestHeader("X-ArchivesSpace-Session", token);
    },
    url: baseURL + "/repositories/2/find_by_id/archival_objects?",
    data: data,
    success: function(results) {
      if (results["archival_objects"].length < 1) {
        console.log("Sorry, I couldn't find anything for " + refid);
      } else {
		  console.log("VICTORY!!!")
        $("#refid-search-error").empty().removeClass(function(index, css) {
          return (css.match(/(^|\s)alert?\S+/g) || []).join(' ');
        });        var objectURI = results["archival_objects"][0]["ref"];
		console.log(objectURI)
        getData(objectURI);
      }
    },
	always: function(results) {
		console.log(results)
	}
  });
}

// Fetches JSON from an ArchivesSpace URI
function getData(uri) {
  $.ajax({
    type: "GET",
    dataType: "json",
    beforeSend: function(request) {
      request.setRequestHeader("X-ArchivesSpace-Session", token);
    },
    url: baseURL + uri,
    success: function(data) {
      if (data["jsonmodel_type"] == "resource") {
        console.log(data["title"] + ' (' + data["id_0"] + ')');
		document.getElementById('dm_item_resource').value = data["title"] + ' (' + data["id_0"] + ')';
      } else if (data["jsonmodel_type"] == "archival_object") {
        console.log(data['display_string']);
		document.getElementById('dm_item_display_title').value = data['display_string'];
        getData(data["resource"]["ref"]);
      }
    }
  });
}
