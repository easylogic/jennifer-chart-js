###
Time Class
###
class Time
  @years : "years"
  @months : "months"
  @days: "days"
  @hours : "hours"
  @minutes : "minutes"
  @seconds : "seconds"
  @milliseconds : "milliseconds"
  @weeks: "weeks"
###
TimeUtil Class
  add()
  format()
###
class TimeUtil
  @add : (date) ->
    if arguments.length <= 2
      return date

    if arguments.length > 2
      d = new Date(+date)

      i = 1
      while(i < arguments.length)
        split = arguments[i]
        time = arguments[i+1]

        switch split
          when "years" then d.setFullYear(d.getFullYear() + time)
          when "months" then d.setMonth(d.getMonth() + time)
          when "days" then d.setDate(d.getDate() + time)
          when "hours" then d.setHours(d.getHours() + time)
          when "minutes" then d.setMinutes(d.getMinutes() + time)
          when "seconds" then d.setSeconds(d.getSeconds() + time)
          when "milliseconds" then d.setMilliseconds(d.getMilliseconds() + time)
          when "weeks" then d.setDate(d.getDate() + time * 7)

        i += 2

      return d
  @format : (date, format, utc) ->
    # TODO: implements date format
    ""
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

  get : (key) ->
    @attrs[key]

  css : (key, value) ->

    if typeof value is not undefined
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

    if @attrs.style
      @attrs.style += ";" + style

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
class Transform extends DomUtil
  orders : {}
  translate : (x, y) ->
    @orders.translate = [x, y].join(" ")
    @
  rotate : (angle, x, y) ->
    @orders.rotate = [angle, x, y].join(" ")
    @
  render: () ->
    list = ("#{key}(#{value})" for key, value of @orders)

    @put "transform", list.join(" ")

    super()
class Path extends Transform
  paths : [],
  constructor : (attr) ->
    super "path", attr

  moveTo: (x, y) ->
    @paths.push "m#{x},#{y}"
    @
  MoveTo: (x, y) ->
    @paths.push "M#{x},#{y}"
    @
  lineTo: (x, y) ->
    @paths.push "l#{x},#{y}"
    @
  LineTo: (x, y) ->
    @paths.push "L#{x},#{y}"
    @
  hLineTo: (x) ->
    @paths.push "h#{x}"
    @
  HLineTo: (x) ->
    @paths.push "h#{x}"
    @
  vLineTo: (x, y) ->
    @paths.push "v#{x}"
    @
  VLineTo: (x, y) ->
    @paths.push "V#{x}"
    @
  curveTo: ( x1,  y1,  x2,  y2,  x,  y) ->
    @paths.push "c" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x + "," + y
    @
  CurveTo: ( x1,  y1,  x2,  y2,  x,  y) ->
    @paths.push "C" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x + "," + y
    @
  sCurveTo: (  x2,  y2,  x,  y) ->
    @paths.push "s" + x2 + "," + y2 + " " + x + "," + y
    @
  SCurveTo: ( x2,  y2,  x,  y) ->
    @paths.push "s" + x2 + "," + y2 + " " + x + "," + y
    @
  qCurveTo: (  x1,  y1,  x,  y) ->
    @paths.push "q" + x1 + "," + y1 + " " + x + "," + y
    @
  QCurveTo: (  x1,  y1,  x,  y)  ->
    @paths.push "Q" + x1 + "," + y1 + " " + x + "," + y
    @
  tCurveTo: ( x1,  y1,  x,  y) ->
    @paths.push "t" + x1 + "," + y1 + " " + x + "," + y
    @
  TCurveTo: ( x1,  y1,  x,  y) ->
    @paths.push "T" + x1 + "," + y1 + " " + x + "," + y
    @
  arc: (  rx,  ry,  x_axis_rotation,  large_arc_flag,  sweep_flag,  x,  y) ->
    @paths.push "a" + rx + "," + ry + " " + x_axis_rotation + " " + large_arc_flag + "," + sweep_flag + " " + x + "," + y
    @
  Arc: (  rx,  ry,  x_axis_rotation,  large_arc_flag,  sweep_flag,  x,  y) ->
    @paths.push "A" + rx + "," + ry + " " + x_axis_rotation + " " + large_arc_flag + "," + sweep_flag + " " + x + "," + y
    @
  close: () ->
    @paths.push "z"
    @
  Close: () ->
    @paths.push "Z"
    @
  triangle : ( cx,  cy,  width,  height) ->
    @MoveTo(cx, cy).moveTo(0, -height/2).lineTo(width/2,height).lineTo(-width, 0).lineTo(width/2, -height)
  rect : ( cx,  cy,  width,  height) ->
    @MoveTo(cx, cy).moveTo(-width/2, -height/2).lineTo(width,0).lineTo(0, height).lineTo(-width, 0).lineTo(0, -height)
  rectangle : ( cx,  cy,  width,  height) ->
    @rect(cx, cy, width, height)
  cross : ( cx,  cy,  width,  height) ->
    @MoveTo(cx, cy).moveTo(-width/2, -height/2).lineTo(width, height).moveTo(0, -height).lineTo(-width, height);
  circle : ( cx,  cy,  r) ->
    @MoveTo(cx, cy).moveTo(-r, 0).arc(r, r, 0, 1, 1, r*2, 0).arc(r, r, 0, 1, 1, -(r*2), 0)

  render : () ->
    @put "d", @paths.join(" ")
    super()

class Svg extends DomUtil
  constructor : (attr) ->
    super("svg", attr)

  init : () ->
    @put "xmlns", "http://www.w3.org/2000/svg"

  toXml : () ->
    "<?xml version='1.1' encoding='utf-8' ?>\r\n<!DOCTYPE svg>\r\n" + @toString()
class Polygon extends Transform
  points : [],
  constructor : (attr) ->
    super "polygon", attr

  point : (x, y) ->
    @points.push [x,y].join(",")
    @
  toString : () ->
    @put "points", @points.join("-")
    super()

class Polyline extends Transform
  points : [],
  constructor : (attr) ->
    super "polyline", attr

  point : (x, y) ->
    @points.push [x,y].join(",")
    @
  render : () ->
    @put "points", @points.join("-")
    super()