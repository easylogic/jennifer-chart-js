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
class MathUtil
  # 2d rotate
  @rotate : (x, y, radian) ->
    { x : x * Math.cos(radian) - y * Math.sin(radian), y : x * Math.sin(radian) + y * Math.cos(radian) }

  # degree to radian
  @radian : (degree) ->
    degree * Math.PI / 180

  # radian to degree
  @degree : (radian) ->
    radian * 180 / Math.PI

  #중간값 계산 하기
  @interpolateNumber : (a, b) ->
    (t) ->
      a + (b - a) * t

  # 중간값 round 해서 계산하기
  @interpolateRound : (a, b) ->
    f = MathUtil.interpolateNumber(a, b)
    (t) ->
      Math.round(f(t))

  @niceNum : (range, round) ->
    exponent = Math.floor(Math.log(range) / Math.LN10)
    fraction = range / Math.pow(10, exponent)

    if round
      if fraction < 1.5
        niceFraction = 1
      else if fraction < 3
        niceFraction = 2
      else if fraction < 7
        niceFraction = 5
      else
        niceFraction = 10
    else
      if fraction <= 1
        niceFraction = 1
      else if fraction <= 2
        niceFraction = 2
      else if fraction <= 5
        niceFraction = 5
      else
        niceFraction = 10

    niceFraction * Math.pow(10, exponent)

  @nice : (min, max, ticks, isNice) ->
	  isNice = if isNice then isNice else false

		if min > max
				_max = min
				_min = max
		else
				_min = min
				_max = max

    _ticks = ticks;
    _tickSpacing = 0;
    _niceMin;
    _niceMax;

    _range = if isNice then @niceNum(_max - _min, false) else _max - _min
    _tickSpacing = if isNice then @niceNum(_range / _ticks, true) else _range / _ticks
    _niceMin = if isNice then Math.floor(_min / _tickSpacing) * _tickSpacing else _min
    _niceMax = if isNice then Math.floor(_max / _tickSpacing) * _tickSpacing else _max

    { min : _niceMin, max : _niceMax, range : _range, spacing : _tickSpacing }

class ColorUtil 
  @regex  : /(linear|radial)\((.*)\)(.*)/i
  @trim : (str) ->
    (str || "").replace(/^\s+|\s+$/g, '')
  @parse : (color) ->
    @parseGradient(color)
  @parseGradient : (color) ->
    matches = color.match(@regex)
    if !matches then return color
			
    type = @trim(matches[1])
    attr = @parseAttr(type, @trim(matches[2]))
    stops = @parseStop(@trim(matches[3]))

    obj = { type : type }
			
    for key, value in attr
      obj[key] = value

    obj.stops = stops
    obj
  @parseStop : (stop) ->
    stop_list = stop.split(",")
			
    stops = []

    for stop in stop_list
      arr = stop.split(" ")

      if arr.length is 0
        continue

      if arr.length is 1
        stops.push "stop-color" : arr[0]
      else if arr.length is 2
        stops.push "offset" : arr[0], "stop-color" : arr[1]
      else if arr.length is 3
        stops.push "offset" : arr[0], "stop-color" : arr[1], "stop-opacity" : arr[2]

    start = -1;
    end = -1;
    i = 0
    for stop in stops
      if i is 0
        if !stop.offset
          stop.offset = 0
      else if i is len - 1
        if !stop.offset
          stop.offset = 1

      if start == -1 and typeof stop.offset is 'undefined'
        start = i
      else if end == -1 and typeof stop.offset is 'undefined'
        end = i

      count = end - start;

      endOffset = if stops[end].offset.indexOf("%") > -1 then parseFloat(stops[end].offset)/100  else  stops[end].offset
      startOffset = if stops[start].offset.indexOf("%") > -1 then parseFloat(stops[start].offset)/100 else  stops[start].offset

      dist = endOffset - startOffset
      value = dist/ count

      offset = startOffset + value
      index = start + 1
      while index < end
        stops[index].offset = offset
        offset += value
        index++

      start = end
      end = -1
      i++

    stops

  @parseAttr : (type, str) ->
    if type is 'linear'
      switch str
        when "", "left" then return { x1 : 0, y1 : 0, x2 : 1, y2 : 0, direction : "left" }
        when "right" then return { x1 : 1, y1 : 0, x2 : 0, y2 : 0, direction : str }
        when "top" then return { x1 : 0, y1 : 0, x2 : 0, y2 : 1, direction : str }
        when "bottom" then return { x1 : 0, y1 : 1, x2 : 0, y2 : 0, direction : str }
        when "top left" then return { x1 : 0, y1 : 0, x2 : 1, y2 : 1, direction : str }
        when "top right" then return { x1 : 1, y1 : 0, x2 : 0, y2 : 1, direction : str }
        when "bottom left" then return { x1 : 0, y1 : 1, x2 : 1, y2 : 0, direction : str }
        when "bottom right" then return { x1 : 1, y1 : 1, x2 : 0, y2 : 0, direction : str }
        else
          arr = str.split(",")
          i = 0
          while i < arr.length
            if arr[i].indexOf("%") is -1
              arr[i] = parseFloat(arr[i])
            i++
          return { x1 : arr[0], y1 : arr[1],x2 : arr[2], y2 : arr[3] }
    else
      arr = str.split(",")
      i = 0
      while i < arr.length
        if arr[i].indexOf("%") is -1
          arr[i] = parseFloat(arr[i])
        i++
      return { cx : arr[0], cy : arr[1],r : arr[2], fx : arr[3], fy : arr[4] }

class Scale
  _rangeBand = 0
  _isRound = false
  _clamp = false
  _domain = []
  _range = []
  _key = ""

  constructor : (domain ,range) ->
    _domain = domain
    _range = range
    @init()

  init : () ->

  clamp : (clamp) ->
    if arguments.length == 0
      _clamp
    else
      _clamp = clamp
      @
    
  get : (x) -> 0
  max : () -> Math.max(_domain[0], _domain[_domain.length-1])
  min : () -> Math.min(_domain[0], _domain[_domain.length-1])
  rangeBand : () -> _rangeBand
  rate : (value, max) ->
    @get (@max() * (value / max))
  invert : (y) -> 0
  domain : (values) ->
    if arguments.length is 0
      _domain
    else
      _domain = (value for value in values)
      @
  range : (values) ->
    if arguments.length is 0
      _range
    else
      _range = (value for value in values)
      @
  round : () -> _isRound
  rangeRound : (values) ->
    _isRound = true
    @range values