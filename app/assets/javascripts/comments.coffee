$(document).bind 'page:change', ->
  if $('#disqus_thread').length
    do ->
      d = document
      s = d.createElement('script')
      s.src = '//elena-muzina.disqus.com/embed.js'
      s.setAttribute 'data-timestamp', +new Date
      (d.head or d.body).appendChild s
