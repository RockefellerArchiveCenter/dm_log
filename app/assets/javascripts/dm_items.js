
$(document).on("turbolinks:load", function() {
	console.log("load");
});

$(document).on('click', '#find_in_as', function(e) {
	console.log("click!");
	var refid = document.getElementById('dm_item_refid').value;
	console.log(refid)
	var params = "ref_id[]=" + refid;
	console.log(params);
	e.preventDefault();
	getResults(params, refid);
});


function getResults(data, refid) {
//	console.log(data)
  console.log("getResults started")
	$.ajax({
    type: "GET",
    dataType: "json",
    beforeSend: function(request) {
      request.setRequestHeader("X-ArchivesSpace-Session", "5c05bf8d216a8eb6071d25b4b3748d3e10fc703b9e3ccb579c055f1c6dc6fcb7");
    },
    url: "http://192.168.50.7:8089/repositories/2/find_by_id/archival_objects?ref_id[]=ref123",
//    data: data,
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
      request.setRequestHeader("X-ArchivesSpace-Session", "43f28e6b16efde6181d2acbf9f61c1ed19802d09d55e0af2e4a79ca5dd5b0e61");
    },
    url: "http://192.168.50.7:8089" + uri,
    success: function(data) {
      if (data["jsonmodel_type"] == "resource") {
        displayData("#results-footer", data["title"] + ' (' + data["id_0"] + ')');
        $("#results").fadeIn(200)
      } else if (data["jsonmodel_type"] == "archival_object") {
        displayData('#title', data['display_string'] + ' <span class="label label-default">' + data['level'] + '</span>');
        if (data['instances'].length > 0) {
          handleInstances(data['instances'])
        }
        getData(data["resource"]["ref"]);
      } else if (data["jsonmodel_type"] == "location") {
        displayData("#location", data["title"]);
        $("#locationCopy").fadeIn(200);
      }
    }
  });
}