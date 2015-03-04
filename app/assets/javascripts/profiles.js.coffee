# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#profiles').imagesLoaded ->
		$('#profiles').masonry
			itemSelector: '.container-profiles'
			isFitWidth: true

$ ->
	$('#photos').imagesLoaded ->
		$('#photos').masonry
			itemSelector: '.photo'
			isFitWidth: true

$ ->
	$('#posts').imagesLoaded ->
		$('#posts').masonry
			itemSelector: '.container-post-index'
			isFitWidth: true