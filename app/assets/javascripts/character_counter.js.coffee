updateCharacters = ($element, show) ->
	$charactersField = $("em")
	nbCharacters = $element.val().length
	nbCharactersLeft = 140 - nbCharacters
	if (show)
		$charactersField.text(nbCharactersLeft)

	if nbCharactersLeft <= 10
		$charactersField.css("color", "red");
	else 
		$charactersField.css("color", "#808080");

	if nbCharactersLeft < 0 or nbCharactersLeft == 140
		$("input").attr("disabled", "disabled")
	else
		$("input").removeAttr("disabled")


$(document).on "page:change", ->
	micropost_content = $( "#micropost_content" );
	if micropost_content.length
		micropost_content.keyup(( event ) ->
			if event.which == 13
				event.preventDefault()
			updateCharacters($(this), true)
		)
		updateCharacters(micropost_content, false)
		$("em").css("vertical-align", "middle")

