class @API
  @load: (path, callback) ->
    jQuery.getJSON(@url(path), callback)

  @url: (path) ->
    "#{@baseURL}/#{path}"

  @baseURL: 'https://jsonp.afeld.me/?url=http://open-api.electricobjects.com/v4/artworks'