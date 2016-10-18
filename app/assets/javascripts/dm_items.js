
$(document).ready(function() {
	if($(".dm_items.new").length) {
		generateId();
	}
});

// Non-expiring session token for an AS user
var token = "5e02cfee9805e081efe2ca67ae9751390f15907af235faa87c6d2ba7f06fd97c";

// Base url for your ArchivesSpace instance, including the backend port number
var baseURL = "http://192.168.50.7:8089"

$(document).on('click', '#find_in_as', function(e) {
	e.preventDefault();
	refid = document.getElementById('dm_item_refid').value;
	var params = "ref_id[]=" + refid;
	getResults(params, refid);
});

function generateId() {
	if (document.getElementById('dm_item_auto_id').value == "") {
		var auto_id = createId();
		document.getElementById('dm_item_auto_id').value = auto_id;
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
        getData(results["archival_objects"][0]["ref"]);
      }
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
				document.getElementById('dm_item_resource').value = data["title"] + ' (' + data["id_0"] + ')';
      } else if (data["jsonmodel_type"] == "archival_object") {
				document.getElementById('dm_item_display_title').value = data['display_string'];
        getData(data["resource"]["ref"]);
      }
    }
  });
}
