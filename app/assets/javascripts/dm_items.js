// Generate date variables
var date = new Date();
var day = date.getDate();
var month = date.getMonth() + 1;
var year = date.getFullYear();
if (month < 10) month = "0" + month;
if (day < 10) day = "0" + day;
var today = year + "-" + month + "-" + day;

$(document).ready(function() {
	if($(".dm_items.new").length) {
		// Generate IDs for new digital media item records
		generateId();
	} else if ($(".dm_items.edit").length) {
		// Disable editing of IDs for existing digital media item records
		$('#dm_item_auto_id').attr("disabled", true);
	}
	$('.dm_items .form-control').on('change', function() {
		if (validateForm()) {
			$('#submit-button').prop('disabled', false)
		} else {
			$('#submit-button').prop('disabled', true)
		}
	});
});

// Sets (or unsets) transfer date and makes tranfer method required (or optional) based on value of transfer status
$("#dm_item_status").on("change", function() {
	if($('#dm_item_status').val() == "Transferred - Success") {
		$('#dm_item_transfer_date').val(today);
		$('#dm_item_method').prop("required", true);
		$('label[for="dm_item_method"]')[0].innerHTML = $('label[for="dm_item_method"]')[0].innerHTML + "*"
	} else if (document.getElementById('dm_item_status').value == "Transferred - Failed") {
		$('#dm_item_transfer_date').val(today);
		$('#dm_item_method').prop("required", false);
		$('label[for="dm_item_method"]')[0].innerHTML = $('label[for="dm_item_method"]')[0].innerHTML.replace("*", '');
	} else {
		$('#dm_item_transfer_date').val() = '';
		$('#dm_item_method').prop("required", false);
		$('label[for="dm_item_method"]')[0].innerHTML = $('label[for="dm_item_method"]')[0].innerHTML.replace("*", '');
	}
});

// Handle click event on Find in ArchivesSpace button and delegate to getResults function
$('#find_in_as').on('click', function(e) {
	e.preventDefault();
	refid = $('#dm_item_refid').val();
	var params = "ref_id[]=" + refid;
	getResults(params, refid);
});

// Populate auto id field with unique ID
function generateId() {
	if ($('#dm_item_auto_id').val() == "") {
		var auto_id = createId();
		$('#dm_item_auto_id').val(auto_id);
	}
}

// Generate a unique ID
function createId() {
	var text = "";
	var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
	for( var i=0; i < 10; i++ )
		text += possible.charAt(Math.floor(Math.random() * possible.length));
	return text;
}

// Get JSON results from the AS endpoint
function getResults(data, refid) {
	$.ajax({
    type: "GET",
    dataType: "json",
    beforeSend: function(request) {
      request.setRequestHeader("X-ArchivesSpace-Session", token);
    },
    url: baseURL + "/repositories/"+asRepo+"/find_by_id/archival_objects?",
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
				$('#dm_item_resource').val(data["title"] + ' (' + data["id_0"] + ')');
      } else if (data["jsonmodel_type"] == "archival_object") {
				$('#dm_item_display_title').val(data['display_string'])
        getData(data["resource"]["ref"]);
      }
    }
  });
}

function validateForm() {
  var isValid = true;
  $('.dm_items .form-control[required]').each(function() {
    if ( $(this).val() == ''  ) {
			isValid = false;
		}
  });
  return isValid;
}
