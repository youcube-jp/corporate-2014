inquiry =
  init: ->
    that = this
    this.get_form().submit (event) ->
      event.preventDefault()

      $form = that.get_form()
      $btn = that.get_btn()

      that.restore_err.call(that)
      that.restore_btn.call(that).html('<i class="fa fa-refresh fa-spin"></i> 送信中です……')

      $.ajax(
        type: $form.attr('method')
        url: $form.attr('action')
        data: $form.serialize()
        dataType: 'json'
      )
      .done (data) ->
        if data && data.status == 'CREATED'
          alert('お問い合わせありがとうございます。お返事いたしますのでしばらくお待ちくださいませ。')
          $btn.removeClass('btn-primary').addClass('btn-success').html('<i class="fa fa-check"></i> 送信しました！')
      .fail (jqXHR) ->
        $btn.removeClass('btn-primary').addClass('btn-danger').html('<i class="fa fa-times"></i> 失敗しました！')
        data = jqXHR.responseJSON
        if data && data.status == 'UNPROCESSABLE_ENTITY'
          setTimeout((-> that.restore_btn.call(that)), 4000)

          if data.errors
            for _ in Object.keys(data.errors)
              $("##{_}-error").html(data.errors[_]).show()

  get_form: ->
    $('#inquiry-form')

  get_btn: ->
    $('#inquiry-submit')

  restore_err: ->
    this.get_form().find('.error').hide()

  restore_btn: ->
    this.get_btn().removeClass('btn-success').removeClass('btn-danger').addClass('btn-primary').html('<i class="fa fa-send"></i> 上記内容で無料相談する')

$ ->
  inquiry.init()
