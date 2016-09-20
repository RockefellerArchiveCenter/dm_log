# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
	console.log("loaded!")
	return
	
$(document).on 'click', '#find_in_as', (e) ->
    e.preventDefault()
    console.log("click!")
    return
###
$(document).on 'click', '.btn.refid', (e) ->
  e.preventDefault()
  $.getJSON('/meta/' + $('#link_list_ext_id_type').val() + '/' + $('#link_list_ext_id').val()).done((data, status, jqXHR) ->
    if data['body']
      $('#modal-metadata .modal-field-title .content').text data.title
      $('#modal-metadata .modal-field-author .content').text data.author
      $('#modal-metadata .modal-field-publication .content').text data.publication
      $('#modal-metadata .modal-fields').show()
      $('#modal-metadata .modal-blank').hide()
      $('#modal-metadata .btn.meta-accept').show()
    else
      $('#modal-metadata .modal-blank').show()
      $('#modal-metadata .modal-fields').hide()
      $('#modal-metadata .btn.meta-accept').hide()
    $('#modal-metadata').modal()
    return
  ).fail (data, status, jqXHR) ->
    $('#modal-metadata .modal-blank').show()
    $('#modal-metadata .modal-fields').hide()
    $('#modal-metadata .btn.meta-accept').hide()
    $('#modal-metadata').modal()
    return
  return
###