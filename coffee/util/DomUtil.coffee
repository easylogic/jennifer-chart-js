class DomUtil

  @el : (tagName, attr) ->
    new Transform(tagName, attr)

  constructor: (@tagName = "g", @attrs = {}) ->
    @children = [];
    @styles = [];
    @text = "";

    @init();

  init: () ->

  put : (key, value) ->
    @attrs[key] = value
    @

  get : (key) -> @attrs[key]
  css : (key, value) ->

    if typeof key is "object"
      for k, v of key
        @styles[k] = v
    else if typeof value isnt "undefined"
      @styles[key] = value
      @
    else
      @styles[key]

  append : (dom) ->
    @children.push dom
    dom

  textNode : (text) ->
    @text = text;
    @

  collapseStyle : () ->
    str = for key, value of @styles
      "#{key}:#{value}"

    str.join ";"

  collapseAttr : () ->
    style = @collapseStyle()

    @put "style", style

    str = for key, value of @attrs
      "#{key}=\"#{value}\""

    str.join " "

  collapseChildren : () ->
    str = for dom in @children
      "#{dom.render()}"

    str.join "\n"

  render : () ->

    ret = ["<#{@tagName} #{@collapseAttr()}"]

    if @children.length is 0
      if @text is ""
        ret.push " />"
      else
        ret.push ">#{@text}</#{@tagName}>"
    else
      ret.push ">\n#{@collapseChildren()}#{@text}\n</#{@tagName}>"

    ret.join ""

  toString : () ->
    @render()

  defs : (attr) -> @append(el("defs", attr))
  marker : (attr) -> @append(el("marker", attr))
  symbol : (attr) -> @append(el("symbol", attr))
  clipPath : (attr) -> @append(el("clip-path", attr))
  g : (attr) -> @append(el("g", attr))
  group : (attr) -> @g(attr)
  rect : (attr) -> @append(el("rect", attr))
  line : (attr) -> @append(el("line", attr))
  circle : (attr) -> @append(el("circle", attr))
  text : (attr) -> @append(el("text", attr))
  tspan : (attr) -> @append(el("tspan", attr))
  ellipse : (attr) -> @append(el("ellipse", attr))
  image : (attr) -> @append(el("image", attr))
  path : (attr) -> @append(new Path(attr))
  polygon : (attr) -> @append(new Polygon(attr))
  polyline : (attr) -> @append(new Polyline(attr))

  radialGradient : (attr) -> @append(el("radialGradient", attr))
  linearGradient : (attr) -> @append(el("linearGradient", attr))
  mask : (attr) -> @append(el("mask", attr))
  pattern : (attr) -> @append(el("pattern", attr))
  stop : (attr) -> @append(el("stop", attr))
  animate : (attr) -> @append(el("animate", attr))
  animateColor : (attr) -> @append(el("animateColor", attr))
  animateMotion : (attr) -> @append(el("animateMotion", attr))
  animateTransform : (attr) -> @append(el("animateTransform", attr))
  mpath : (attr) -> @append(el("mpath", attr))
  set : (attr) -> @append(el("set", attr))
  attr : (o = {}) ->
    for key, value of o
      @attrs[key] = value
    @

  addClass : (s) ->
    list = @attrs['class'].split(" ")
    listEx = s.split("")
    result = {}

    for str in list
      result[str] = true

    for str in listEx
      result[str] = true

    ret = (key for key, value of result)

    @put "class", ret.join(" ")

  removeClass : (s) ->
    list = @attrs['class'].split(" ")
    listEx = s.split("")
    result = {}

    for str in list
      result[str] = true

    for str in listEx
      result[str] = false

    ret = (key for key, value of result if value)

    @put "class", ret.join(" ")

  hasClass : (s) ->
    list = @attrs['class'].split(" ")

    for str in list
      if str is s
        return true

    false

el = () ->
  DomUtil.el.apply(null, arguments)