marked.setOptions {
  highlight: (code, lang, callback)->
    hljs.highlightAuto(code).value
}

class Editor
  constructor: ->
    @$textarea = jQuery('textarea.source')
    @$save_btn = jQuery('.toolbar a.save')
    @$update_btn = jQuery('.toolbar a.update')


  _load_storage: ->
    if localStorage['markdown-source']?
      @$textarea.val localStorage['markdown-source']
      @show_html localStorage['markdown-source']

  show_html: (value)->
    localStorage['markdown-source'] = value
    jQuery('.html-area').html marked(value)

  init: ->
    # @_load_storage()

    @cm = CodeMirror.fromTextArea @$textarea[0], {
      mode: 'gfm'
      lineNumbers: true
      styleActiveLine: true
      theme: 'vibrant-ink'
      indentWithTabs: false
      lineWrapping: true
    }

    @show_html @cm.getValue()

    @cm.on 'change', =>
      @show_html @cm.getValue()

    # 保存按钮
    @$save_btn.on 'click', =>
      $form = jQuery('form')
      $form.find('textarea').val @cm.getValue()
      $form.attr 'action', '/'
      $form.find('input[name=_method]').val 'post'
      $form.submit()

    @$update_btn.on 'click', =>
      $form = jQuery('form')
      $form.find('textarea').val @cm.getValue()
      $form.submit()



jQuery(document).on 'ready page:load', ->
  new Editor().init()