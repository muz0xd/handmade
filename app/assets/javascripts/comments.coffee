$(document).bind 'page:change', ->
  if $('#disqus_thread').length
    disqus_config = ->
      @page.url = $('.disqus_conf').data('url')
      @page.identifier = $('.disqus_conf').data('identifier')
      @page.title = $('.disqus_conf').data('title')

    do ->
      d = document
      s = d.createElement('script')
      s.src = '//elena-muzina.disqus.com/embed.js'
      s.setAttribute 'data-timestamp', +new Date
      (d.head or d.body).appendChild s

