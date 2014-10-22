jQuery ->
  jQuery('textarea.markdown').on 'input', ->
    value = jQuery('textarea.markdown').val()
    html = markdown.toHTML value
    # html = marked value
    jQuery('.html-result').html html