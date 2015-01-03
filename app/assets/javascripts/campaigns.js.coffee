# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#campaigns').imagesLoaded ->
		$('#campaigns').masonry
			itemSelector: '.free-campaign'
			isFitWidth: true

$ ->
	$('#campaigns2').imagesLoaded ->
		$('#campaigns2').masonry
			itemSelector: '.campaign-md'
			isFitWidth: true

$ ->
	$('#campaigns3').imagesLoaded ->
		$('#campaigns3').masonry
			itemSelector: '.campaign-md'
			isFitWidth: true

$ ->
	$('#campaign-art').imagesLoaded ->
		$('#campaign-art').masonry
			itemSelector: '.campaign-art-each'
			isFitWidth: true