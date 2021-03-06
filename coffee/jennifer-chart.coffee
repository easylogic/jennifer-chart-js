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

    if style
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
    list = (@attrs['class'] || "").split(" ")
    listEx = s.split(" ")
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
class Transform extends DomUtil
  constructor: (@tagName, @attr) ->
    super @tagName, @attr
    @orders = {}

  translate : (x, y) ->
    @orders.translate = [x, y].join(" ")
    @
  rotate : (angle, x, y) ->
    @orders.rotate = [angle, x, y].join(" ")
    @
  render: () ->
    list = ("#{key}(#{value})" for key, value of @orders)

    if list.length
      @put "transform", list.join(" ")

    super()
class Path extends Transform
  paths : [],
  constructor : (attr) ->
    super "path", attr
    @paths = []

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
  vLineTo: (y) ->
    @paths.push "v#{y}"
    @
  VLineTo: (y) ->
    @paths.push "V#{y}"
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
    @points = []

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
    @points = []

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
  constructor : (@_domain ,@_range) ->
    @init()

  init : () ->

  clamp : (clamp) ->
    if arguments.length == 0
      @_clamp
    else
      @_clamp = clamp
      @
    
  get : (x) -> 0
  max : () -> Math.max(@_domain...)
  min : () -> Math.min(@_domain...)
  rangeBand : (band) ->
    if arguments.length == 0
      @_rangeBand
    else
      @_rangeBand = band
      @
  rate : (value, max) ->
    @get (@max() * (value / max))
  invert : (y) -> 0
  domain : (values) ->
    if arguments.length is 0
      @_domain
    else
      @_domain = (value for value in values)
      @
  range : (values) ->
    if arguments.length is 0
      @_range
    else
      @_range = (value for value in values)
      @
  round : () -> @_isRound
  rangeRound : (values) ->
    @_isRound = true
    @range values
class LinearScale extends Scale
  constructor : (domain ,range) ->
    super domain || [0, 1], range || [0, 1]

  get : (x) ->
    index = -1
    _domain = @domain()
    _range = @range()

    i = 0
    len = _domain.length
    while(i < len)
      if i is len - 1
        if x is _domain[i]
          index = i
          break
      else
        if _domain[i] < _domain[i + 1]
          if x >= _domain[i] and x < _domain[i + 1]
            index = i
            break
        else if _domain[i] >= _domain[i + 1]
          if x <= _domain[i] and _domain[i + 1] < x
            index = i
            break
      i++

    if !_range
      if index is 0
        return 0
      else if index == -1
        return 1
      else
        min = _domain[index - 1]
        max = _domain[index]

        pos = (x - min) / (max - min)
        return pos
    else
      if _domain.length - 1 is index
        return _range[index]
      else if index == -1
        max = @max()
        min = @min()

        if max < x
          if @clamp() then return max

          last = _domain[_domain.length- 1]
          last2 = _domain[_domain.length- 2]

          rlast = _range[_range.length - 1]
          rlast2 = _range[_range.length - 2]

          distLast = Math.abs(last - last2)
          distRLast = Math.abs(rlast - rlast2)

          return rlast + Math.abs(x - max) * distRLast / distLast
        else if min > x
          if @clamp() then return min

          first = _domain[0];
          first2 = _domain[1];

          rfirst = _range[0];
          rfirst2 = _range[1];

          distFirst = Math.abs(first - first2);
          distRFirst = Math.abs(rfirst - rfirst2);

          return rfirst - Math.abs(x - min) * distRFirst / distFirst;

        return _range[_range.length - 1]
      else
        min = _domain[index];
        max = _domain[index+1];

        minR = _range[index];
        maxR = _range[index + 1];

        pos = (x - min) / (max - min);

        scale = if @round() then  MathUtil.interpolateRound(minR, maxR)  else  MathUtil.interpolateNumber(minR, maxR)
        scale(pos)

  invert : (y) ->
    new LinearScale(@range(), @domain()).get(y)

  ticks : (count, isNice, intNumber)  ->
    intNumber = intNumber || 10000

    _domain = @domain()

    if _domain[0] == 0 and _domain[1] == 0
       return []

    obj = MathUtil.nice(_domain[0], _domain[1], count || 10, isNice || false)
    arr = []

    start = obj.min * intNumber
    end = obj.max * intNumber

    arr = while start <= end
        value = start / intNumber
        start += obj.spacing * intNumber
        value

    if arr[arr.length - 1] * intNumber isnt end and start > end
      arr.push end / intNumber

    arr
class OrdinalScale extends Scale
  constructor : (domain ,range) ->
    super domain || [0, 1], range || [0, 1]
  get : (x) ->
    _domain = @domain()
    index = -1
    i = 0
    len = _domain.length
    for i in [0...len]
      if _domain[i] == x
        index = i
        break

      i++;

    _range = @range()

    if index > -1
      _range[index]
    else
      if typeof _range[x] isnt 'undefined'
        _domain[x] = x
        _range[x]
      else
        null

  rangePoints : (interval, padding) ->
    _domain = @domain()
    padding = padding || 0;

    step = _domain.length;
    unit = (interval[1] - interval[0] - padding) / step;

    range = [];
    i = 0
    len = _domain.length;
    while i < len
      if i == 0
        range[i] = interval[0] + padding / 2 + unit / 2;
      else
        range[i] = range[i - 1] + unit;
      i++

    @range range
    @rangeBand unit
    @

  rangeBands : (interval, padding, outerPadding) ->
    _domain = @domain()
    padding = padding || 0;
    outerPadding = outerPadding || 0;

    count = _domain.length;
    step = count - 1;
    band = (interval[1] - interval[0]) / step;

    range = [];
    i = 0
    while i < count
      if i == 0
        range[i] = interval[0];
      else
        range[i] = band + range[i - 1];
      i++

    @rangeBand band
    @range range
    @
class Draw
  drawBefore : () ->
    console.log('aaa')

  draw : () ->
    {}
  render : () ->
    @drawBefore()
    @draw()
extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

class ChartBuilder extends Draw

  ## private
  _area = {}
  _data = []
  _grid = {}
  _brush = []
  _widget = []
  _series = []
  _scales = []
  _hash = {}
  _widget_objects = []
  _padding = {}
  _options = {}
  _theme = {}
  svg = {}
  defs = {}
  clipId = ""
  root = {}
  themeList = {}
  grids = {}
  widgets = {}
  brushes = {}

  deepClone = (obj) ->
    value = ''

    if obj instanceof Array
      value = (deepClone(o) for o in obj)
    else if obj instanceof Date
      value = obj
    else if typeof obj is "object"
      value = {}
      for key, val of obj
        value[key] = deepClone(val)
    else
      value = obj

    value

  ## public

  constructor : (o) ->
    _options = o

    @initPadding()
    @initTheme();
    @initGrid();
    @initBrush();
    @initWidget();
    @initSvg();
    @setTheme(o.theme || "jennifer")

    if _options.style
      @setTheme(_options.style)


  initSvg : () ->
    @svg = new Svg({ width : _options.width || 400, height : _options.height || 400 })
    @root = @svg.g().translate(0.5, 0.5)

  initWidget : () ->
    ###
    @addWidget "title", TitleWidget
    @addWidget "legend", LegendWidget
    ###
  initBrush : () ->



    @addBrush "bar", BarBrush
    @addBrush "bubble", BubbleBrush
    @addBrush "candlestick", CandleStickBrush
    @addBrush "column", ColumnBrush
    @addBrush "donut", DonutBrush
    @addBrush "equalizer", EqualizerBrush
    @addBrush "line", LineBrush
    @addBrush "ohlc", OhlcBrush
    @addBrush "path", PathBrush
    @addBrush "fullstack", FullStackBrush
    ###
    @addBrush "area", AreaBrush
    @addBrush "bargauge", BarGaugeBrush
    @addBrush "circlegauge", CircleGaugeBrush
    @addBrush "fillgauge", FillGaugeBrush
    @addBrush "fullgauge", FullGaugeBrush
    @addBrush "gauge", GagueBrush
    @addBrush "pie",  PieBrush
    @addBrush "scatter", ScatterBrush
    @addBrush "scatterpath", ScatterPathBrush
    @addBrush "stackarea", StackAreaBrush
    @addBrush "stackbar", StackBarBrush
    @addBrush "stackcolumn", StackColumnBrush
    @addBrush "stackgauge", StackGagueBrush
    @addBrush "stackline", StackLineBrush
    @addBrush "stackscatter", StackScatterBrush
    ###

  initGrid : () ->
    @addGrid("block", BlockGrid);
    @addGrid("range", RangeGrid);
    @addGrid("date", DateGrid);
    @addGrid("rule", RuleGrid);
    #@addGrid("radar", RadarGrid);

  initTheme : () ->
    @addTheme("jennifer", JenniferTheme)
    @addTheme("dark", DarkTheme)
    @addTheme("gradient", GradientTheme)
    @addTheme("pastel", PastelTheme)

  addBrush : (key, BrushClass) -> brushes[key] = BrushClass
  addWidget : (key, WidgetClass) -> widgets[key] = WidgetClass
  addGrid : (key, GridClass) -> grids[key] = GridClass
  addTheme : (key, ThemeClass) -> themeList[key] = ThemeClass

  initPadding : () ->

    if typeof _options.padding is 'undefined'
      _padding = left : 50, right : 50, top : 50, bottom : 50
    else
      if _options.padding is 'empty'
        _padding = left : 0, right : 0, top : 0, bottom : 0
      else
        _padding = extend({left : 50, right : 50, top : 50, bottom : 50}, _options.padding)

  drawBefore : () ->
    series = deepClone (_options.series || {})
    grid = deepClone (_options.grid || {})
    brush = deepClone (_options.brush || [])
    widget = deepClone (_options.widget || [])
    data = deepClone (_options.data || [])
    series_list = []

    for row in data
      for key, value of row
        obj = series[key] || {}

        if typeof value is "string" then continue

        value = +value

        series[key] = obj

        obj.data = obj.data || []
        obj.min = if typeof obj.min == 'undefined' then  0 else obj.min
        obj.max = if typeof obj.max == 'undefined' then  0 else  obj.max
        obj.data.push value

        if value < obj.min
          obj.min = value

        if value > obj.max
          obj.max = value;

    series_list = (key for key, value of series)

    console.log(brush)

    _brush = @createBrushData(brush, series_list)
    _widget = @createBrushData(widget, series_list)

    _series = series
    _grid = grid
    _data = data
    _hash = {}

  createBrushData : (draws, series_list) ->
    result = null;

    if draws
      if typeof draws == 'string'
        result = [ type: draws ]
      else if typeof draws is 'object' and  typeof  draws.length is "undefined"
        result = [draws];
      else
        result = draws

      if result.length > 0
        for b in result
          if !b.target
            b.target = series_list;
          else if typeof b.target is 'string'
            b.target = [b.target]

    result

  caculate : () ->
    _area =
      width: (_options.width || 400) - (_padding.left + _padding.right)
      height: (_options.height || 400) - (_padding.top + _padding.bottom)
      x: _padding.left
      y: _padding.top

    _area.x2 = _area.x + _area.width;
    _area.y2 = _area.y + _area.height;

  drawDefs : () ->
    defs = @svg.defs()
    # default clip path
    @clipId = @createId('clip-id')

    clip = defs.clipPath(id: @clipId);

    clip.rect
      x: 0,
      y: 0,
      width: @width(),
      height: @height()

    @defs = defs;

  drawObject : (type) ->
    draws = if type == "brush" then  _brush else  _widget

    if draws
      i = 0
      len = draws.length

      while i < len
        obj = draws[i]

        Obj = if type == "brush" then brushes[obj.type] else widgets[obj.type]
        drawObj = if type == "widget" then  @brush(i) else obj

        @setGridAxis obj, drawObj
        obj.index = i

        result = new Obj(@, obj).render()
        result.addClass type + " " + obj.type

        @root.append result

        i++

  setGridAxis : (draw, drawObj) ->
    delete draw.x
    delete draw.y
    delete draw.c

    if _scales.x || _scales.x1
      if !_scales.x and _scales.x1
        _scales.x = _scales.x1
      if !draw.x
        draw.x = if typeof drawObj.x1 isnt 'undefined' then _scales.x1[drawObj.x1 || 0] else _scales.x[drawObj.x || 0]

    if _scales.y || _scales.y1
      if !_scales.y and _scales.y1
        _scales.y = _scales.y1

      if !draw.y
        draw.y = if  typeof drawObj.y1 isnt 'undefined' then _scales.y1[drawObj.y1 || 0] else _scales.y[drawObj.y || 0]

    if _scales.c
      if !draw.c
        draw.c = _scales.c[drawObj.c || 0]

  drawWidget : () -> @drawObject "widget"
  drawBrush : () -> @drawObject "brush"

  drawGrid : () ->
    grid = @grid()

    if grid != null
      if grid.type then grid = c: grid

      for k, g of grid
        orient = 'custom'
        if k == 'x' then orient = 'bottom'
        else if k == 'x1' then orient = 'top'
        else if k == 'y' then orient = 'left'
        else if k == 'y1' then orient = 'right'

        if !_scales[k] then _scales[k] = []
        if  !(g instanceof  Array) then g = [g]

        keyIndex = 0
        len = g.length
        while keyIndex < len

          Grid = grids[g[keyIndex].type || "block"]

          newGrid = new Grid(orient, @, g[keyIndex]);
          root = newGrid.render()
          dist = g[keyIndex].dist || 0

          if k == 'y'
            root.translate @x() - dist, @y()
          else if k == 'y1'
            root.translate @x2() + dist, @y()
          else if k == 'x'
            root.translate @x(), @y2() + dist
          else if k == 'x1'
            root.translate @x(), @y() - dist

          @root.append root

          _scales[k][keyIndex] = newGrid
          keyIndex++

  createGradient : (obj, hashKey) ->
    if typeof hashKey isnt 'undefined' and _hash[hashKey]
      return @url(_hash[hashKey])

    id = @createId 'gradient'
    obj.id = id;

    if obj.type is 'linear'
      g = @defs.linearGradient(obj);
    else if obj.type is 'radial'
      g = @defs.radialGradient(obj)

    for stop in obj.stops || []
      g.stop(stop)

    if typeof hashKey isnt 'undefined'
      _hash[hashKey] = id

    @url(id)

  getColor : (color) ->
    if typeof color is "object" then return @createGradient(color)

    parsedColor = ColorUtil.parse(color)
    if parsedColor is color then return color

    @createGradient(parsedColor, color)

  area : (key) ->
    _area[key] || _area

  height : (value) ->
    if arguments.length == 0
      @area("height")
    else
      _area.height = value
      @
  width : (value) ->
    if arguments.length == 0
      @area("width")
    else
      _area.width = value
      @
  x : (value) ->
    if arguments.length == 0
      @area("x")
    else
      _area.x = value
      @
  y : (value) ->
    if arguments.length == 0
      @area("y")
    else
      _area.y = value
      @

  y2 : (value) ->
    if arguments.length == 0
      @area("y2")
    else
      _area.y2 = value
      @

  x2 : (value) ->
    if arguments.length == 0
      @area("x2")
    else
      _area.x2 = value
      @

  padding : (key) ->
    _padding[key] || _padding

  url : (key) ->
    "url(\#" + key + ")"

  color : (i, colors) ->
    if colors instanceof Array
      c = colors
    else
      c = _theme.colors

    color = if i > c.length - 1 then c[c.length-1] else c[i]

    if _hash[color] then return @url(_hash[color])

    @getColor(color)

  text : (attr, textOrCallback) ->
    el("text",  extend({
      "font-family": this.theme("fontFamily"),
      "font-size": this.theme("fontSize"),
      "fill": this.theme("fontColor")
    }, attr)).textNode(textOrCallback)

  setTheme : () ->
    if arguments.length is 1
      theme = arguments[0]

      if typeof theme is "object"
        _theme = extend(_theme, theme)
      else
        _theme = themeList[theme]
    else if arguments.length == 2
      _theme[arguments[0]] = arguments[1]

  theme : (key, value, value2) ->
    if arguments.length is 0
      return _theme
    else if arguments.length == 1
      if _theme[key]
        if key.indexOf("Color") > -1
          return @getColor(_theme[key]);
        else
          return _theme[key]
    else if arguments.length is 3
      val = if (key) then value else value2;
      if val.indexOf("Color") > -1 and _theme[val]
        return @getColor(_theme[val])
      else
        return _theme[val]

  series: (key) -> _series[key] || _series
  grid: (key) -> _grid[key] || _grid
  brush: (key) -> _brush[key] || _brush
  data: (index, field) ->
    if _data[index]
      _data[index][field] || _data[index]
    else
     _data

  createId : (key) ->
    [key || "chart-id", (+new Date), Math.round(Math.random() * 100) % 100].join("-")

  render : () ->

    @caculate()

    @drawBefore()
    @drawDefs()
    @drawGrid()

    @drawBrush()
    @drawWidget()

    @svg.css background: @theme("backgroundColor")
    @svg.render()

JenniferTheme =
  # common styles
  backgroundColor : "white",
  fontSize : "11px",
  fontColor : "#333333",
  fontFamily : "arial,Tahoma,verdana",
  colors : [
    "#7977C2",
    "#7BBAE7",
    "#FFC000",
    "#FF7800",
    "#87BB66",
    "#1DA8A0",
    "#929292",
    "#555D69",
    "#0298D5",
    "#FA5559",
    "#F5A397",
    "#06D9B6",
    "#C6A9D9",
    "#6E6AFC",
    "#E3E766",
    "#C57BC3",
    "#DF328B",
    "#96D7EB",
    "#839CB5",
    "#9228E4"
  ],

  # grid styles
  gridFontColor : "#333333",
  gridActiveFontColor : "#ff7800",
  gridBorderColor : "#ebebeb",
  gridBorderWidth : 1,
  gridBorderDashArray : "none",
  gridAxisBorderColor : "#ebebeb",
  gridAxisBorderWidth : 1,
  gridActiveBorderColor : "#ff7800",
  gridActiveBorderWidth: 1,

  # brush styles
  barBorderColor : "none",
  barBorderWidth : 0,
  barBorderOpacity : 0,
  gaugeBackgroundColor : "#ececec",
  gaugeArrowColor : "#666666",
  gaugeFontColor : "#666666",
  pieBorderColor : "white",
  pieBorderWidth : 1,
  donutBorderColor : "white",
  donutBorderWidth : 1,
  areaOpacity : 0.5,
  bubbleOpacity : 0.5,
  bubbleBorderWidth : 1,
  candlestickBorderColor : "black",
  candlestickBackgroundColor : "white",
  candlestickInvertBorderColor : "red",
  candlestickInvertBackgroundColor : "red",
  ohlcBorderColor : "black",
  ohlcInvertBorderColor : "red",
  ohlcBorderRadius : 5,
  lineBorderWidth : 2,
  pathOpacity : 0.5,
  pathBorderWidth : 1,
  scatterBorderColor : "white",
  scatterBorderWidth : 1,
  scatterHoverColor : "white",
  waterfallBackgroundColor : "#87BB66",
  waterfallInvertBackgroundColor : "#FF7800",
  waterfallEdgeBackgroundColor : "#7BBAE7",
  waterfallBorderColor : "#a9a9a9",
  waterfallBorderDashArray : "0.9",

  # widget styles
  titleFontColor : "#333",
  titleFontSize : "13px",
  legendFontColor : "#333",
  legendFontSize : "12px",
  tooltipFontColor : "#333",
  tooltipFontSize : "12px",
  tooltipBackgroundColor : "white",
  tooltipBorderColor : "#aaaaaa",
  tooltipOpacity : 0.7,
  scrollBackgroundColor : "#dcdcdc",
  scrollThumbBackgroundColor : "#b2b2b2",
  scrollThumbBorderColor : "#9f9fa4",
  zoomBackgroundColor : "red",
  zoomFocusColor : "gray",
  crossBorderColor : "#a9a9a9",
  crossBorderWidth : 1,
  crossBorderOpacity : 0.8,
  crossBalloonFontSize : "11px",
  crossBalloonFontColor : "white",
  crossBalloonBackgroundColor : "black",
  crossBalloonOpacity : 0.5
GradientTheme =
  # common styles
  backgroundColor : "white",
  fontSize : "11px",
  fontColor : "#666",
  fontFamily : "arial,Tahoma,verdana",
  colors :  [
    "linear(top) #9694e0,0.9 #7977C2",
    "linear(top) #a1d6fc,0.9 #7BBAE7",
    "linear(top) #ffd556,0.9 #ffc000",
    "linear(top) #ff9d46,0.9 #ff7800",
    "linear(top) #9cd37a,0.9 #87bb66",
    "linear(top) #3bb9b2,0.9 #1da8a0",
    "linear(top) #b3b3b3,0.9 #929292",
    "linear(top) #67717f,0.9 #555d69",
    "linear(top) #16b5f6,0.9 #0298d5",
    "linear(top) #ff686c,0.9 #fa5559",
    "linear(top) #fbbbb1,0.9 #f5a397",
    "linear(top) #3aedcf,0.9 #06d9b6",
    "linear(top) #d8c2e7,0.9 #c6a9d9",
    "linear(top) #8a87ff,0.9 #6e6afc",
    "linear(top) #eef18c,0.9 #e3e768",
    "linear(top) #ee52a2,0.9 #df328b",
    "linear(top) #b6e5f4,0.9 #96d7eb",
    "linear(top) #93aec8,0.9 #839cb5",
    "linear(top) #b76fef,0.9 #9228e4"
  ],

  # grid styles
  gridFontColor : "#666",
  gridActiveFontColor : "#ff7800",
  gridBorderColor : "#efefef",
  gridBorderWidth : 1,
  gridBorderDashArray : "none",
  gridAxisBorderColor : "#efefef",
  gridAxisBorderWidth : 1,
  gridActiveBorderColor : "#ff7800",
  gridActiveBorderWidth: 1,

  # brush styles
  barBorderColor : "none",
  barBorderWidth : 0,
  barBorderOpacity : 0,
  gaugeBackgroundColor : "#ececec",
  gaugeArrowColor : "#666666",
  gaugeFontColor : "#666666",
  pieBorderColor : "white",
  pieBorderWidth : 1,
  donutBorderColor : "white",
  donutBorderWidth : 1,
  areaOpacity : 0.4,
  bubbleOpacity : 0.5,
  bubbleBorderWidth : 1,
  candlestickBorderColor : "#14be9d",
  candlestickBackgroundColor : "linear(top) #27d7b5",
  candlestickInvertBorderColor : "#ff4848",
  candlestickInvertBackgroundColor : "linear(top) #ff6e6e",
  ohlcBorderColor : "#14be9d",
  ohlcInvertBorderColor : "#ff4848",
  ohlcBorderRadius : 5,
  lineBorderWidth : 2,
  pathOpacity : 0.5,
  pathBorderWidth : 1,
  scatterBorderColor : "white",
  scatterBorderWidth : 2,
  scatterHoverColor : "white",
  waterfallBackgroundColor : "linear(top) #9cd37a,0.9 #87bb66",
  waterfallInvertBackgroundColor : "linear(top) #ff9d46,0.9 #ff7800",
  waterfallEdgeBackgroundColor : "linear(top) #a1d6fc,0.9 #7BBAE7",
  waterfallBorderColor : "#a9a9a9",
  waterfallBorderDashArray : "0.9",

  # widget styles
  titleFontColor : "#333",
  titleFontSize : "13px",
  legendFontColor : "#666",
  legendFontSize : "12px",
  tooltipFontColor : "#fff",
  tooltipFontSize : "12px",
  tooltipBackgroundColor : "black",
  tooltipBorderColor : "none",
  tooltipOpacity : 1,
  scrollBackgroundColor : "#dcdcdc",
  scrollThumbBackgroundColor : "#b2b2b2",
  scrollThumbBorderColor : "#9f9fa4",
  zoomBackgroundColor : "red",
  zoomFocusColor : "gray",
  crossBorderColor : "#a9a9a9",
  crossBorderWidth : 1,
  crossBorderOpacity : 0.8,
  crossBalloonFontSize : "11px",
  crossBalloonFontColor : "white",
  crossBalloonBackgroundColor : "black",
  crossBalloonOpacity : 0.8
DarkTheme =
  # common styles
  backgroundColor : "#222222",
  fontSize : "12px",
  fontColor : "#c5c5c5",
  fontFamily : "arial,Tahoma,verdana",
  colors : [
    "#12f2e8",
    "#26f67c",
    "#e9f819",
    "#b78bf9",
    "#f94590",
    "#8bccf9",
    "#9228e4",

    "#06d9b6",
    "#fc6d65",
    "#f199ff",
    "#c8f21d",
    "#16a6e5",

    "#00ba60",
    "#91f2a1",
    "#fc9765",
    "#f21d4f"
  ],

  # grid styles
  gridFontColor : "#868686",
  gridActiveFontColor : "#ff762d",
  gridBorderColor : "#464646",
  gridBorderWidth : 1,
  gridBorderDashArray : "none",
  gridAxisBorderColor : "#464646",
  gridAxisBorderWidth : 1,
  gridActiveBorderColor : "#ff7800",
  gridActiveBorderWidth: 1,

  # brush styles
  barBorderColor : "none",
  barBorderWidth : 0,
  barBorderOpacity : 0,
  gaugeBackgroundColor : "#3e3e3e",
  gaugeArrowColor : "#a6a6a6",
  gaugeFontColor : "#c5c5c5",
  pieBorderColor : "#232323",
  pieBorderWidth : 1,
  donutBorderColor : "#232323",
  donutBorderWidth : 1,
  areaOpacity : 0.5,
  bubbleOpacity : 0.5,
  bubbleBorderWidth : 1,
  candlestickBorderColor : "#14be9d",
  candlestickBackgroundColor : "#14be9d",
  candlestickInvertBorderColor : "#ff4848",
  candlestickInvertBackgroundColor : "#ff4848",
  ohlcBorderColor : "#14be9d",
  ohlcInvertBorderColor : "#ff4848",
  ohlcBorderRadius : 5,
  lineBorderWidth : 2,
  pathOpacity : 0.2,
  pathBorderWidth : 1,
  scatterBorderColor : "none",
  scatterBorderWidth : 1,
  scatterHoverColor : "#222222",
  waterfallBackgroundColor : "#26f67c",
  waterfallInvertBackgroundColor : "#f94590",
  waterfallEdgeBackgroundColor : "#8bccf9",
  waterfallBorderColor : "#a9a9a9",
  waterfallBorderDashArray : "0.9",

  # widget styles
  titleFontColor : "#ffffff",
  titleFontSize : "14px",
  legendFontColor : "#ffffff",
  legendFontSize : "11px",
  tooltipFontColor : "#333333",
  tooltipFontSize : "12px",
  tooltipBackgroundColor : "white",
  tooltipBorderColor : "white",
  tooltipOpacity : 1,
  scrollBackgroundColor : "#3e3e3e",
  scrollThumbBackgroundColor : "#666666",
  scrollThumbBorderColor : "#686868",
  zoomBackgroundColor : "red",
  zoomFocusColor : "gray",
  crossBorderColor : "#a9a9a9",
  crossBorderWidth : 1,
  crossBorderOpacity : 0.8,
  crossBalloonFontSize : "11px",
  crossBalloonFontColor : "#333",
  crossBalloonBackgroundColor : "white",
  crossBalloonOpacity : 1
PastelTheme = 
  # common styles
  backgroundColor : "white",
  fontSize : "11px",
  fontColor : "#333333",
  fontFamily : "Caslon540BT-Regular,Times,New Roman,serif",
  colors : [
    "#73e9d2",
    "#fef92c",
    "#ff9248",
    "#b7eef6",
    "#08c4e0",
    "#ffb9ce",
    "#ffd4ba",
    "#14be9d",
    "#ebebeb",
    "#666666",
    "#cdbfe3",
    "#bee982",
    "#c22269"
  ],

  # grid styles
  gridFontColor : "#333333",
  gridActiveFontColor : "#ff7800",
  gridBorderColor : "#bfbfbf",
  gridBorderWidth : 1,
  gridBorderDashArray : "1, 3",
  gridAxisBorderColor : "#bfbfbf",
  gridAxisBorderWidth : 1,
  gridActiveBorderColor : "#ff7800",
  gridActiveBorderWidth : 1,
  
  # brush styles
  barBorderColor : "none",
  barBorderWidth : 0,
  barBorderOpacity : 0,
  gaugeBackgroundColor : "#f5f5f5",
  gaugeArrowColor : "gray",
  gaugeFontColor : "#666666",
  pieBorderColor : "white",
  pieBorderWidth : 1,
  donutBorderColor : "white",
  donutBorderWidth : 3,
  areaOpacity : 0.4,
  bubbleOpacity : 0.5,
  bubbleBorderWidth : 1,
  candlestickBorderColor : "#14be9d",
  candlestickBackgroundColor : "#14be9d",
  candlestickInvertBorderColor : "#ff4848",
  candlestickInvertBackgroundColor : "#ff4848",
  ohlcBorderColor : "#14be9d",
  ohlcInvertBorderColor : "#ff4848",
  ohlcBorderRadius : 5,
  lineBorderWidth : 2,
  pathOpacity : 0.5,
  pathBorderWidth : 1,
  scatterBorderColor : "white",
  scatterBorderWidth : 1,
  scatterHoverColor : "white",
  waterfallBackgroundColor : "#73e9d2", # 4
  waterfallInvertBackgroundColor : "#ffb9ce", # 3
  waterfallEdgeBackgroundColor : "#08c4e0", # 1
  waterfallBorderColor : "#a9a9a9",
  waterfallBorderDashArray : "0.9",
  
  # widget styles
  titleFontColor : "#333",
  titleFontSize : "18px",
  legendFontColor : "#333",
  legendFontSize : "11px",
  tooltipFontColor : "#fff",
  tooltipFontSize : "12px",
  tooltipBackgroundColor : "black",
  tooltipBorderColor : "black",
  tooltipOpacity : 0.7,
  scrollBackgroundColor :	"#f5f5f5",
  scrollThumbBackgroundColor : "#b2b2b2",
  scrollThumbBorderColor : "#9f9fa4",
  zoomBackgroundColor : "red",
  zoomFocusColor : "gray",
  crossBorderColor : "#a9a9a9",
  crossBorderWidth : 1,
  crossBorderOpacity : 0.8,
  crossBalloonFontSize : "11px",
  crossBalloonFontColor :	"white",
  crossBalloonBackgroundColor : "black",
  crossBalloonOpacity : 0.7
class Grid extends Draw

  constructor : (@orient, @chart, @options) ->
    @init()

  init : () ->
  drawBefore : () ->
  draw: () -> null

  get : (x) ->
    if @options.key
      x = @chart.data(x, @options.key)
    @scale.get(x)

  axisLine : (attr) ->
    el("line", extend({
      x1 : 0,
      y1 : 0,
      x2 : 0,
      y2 : 0,
      stroke : @chart.theme("gridAxisBorderColor"),
      "stroke-width" : @chart.theme("gridAxisBorderWidth"),
      "stroke-opacity" : 1
    }, attr))

  line : (attr) ->
    el("line", extend({
      x1 : 0,
      y1 : 0,
      x2 : 0,
      y2 : 0,
      stroke : @chart.theme("gridBorderColor"),
      "stroke-width" : @chart.theme("gridBorderWidth"),
      "stroke-dasharray" : @chart.theme("gridBorderDashArray"),
      "stroke-opacity" : 1
    }, attr))

  max: () -> @scale.max()
  min: () -> @scale.min()
  rangeBand: () -> @scale.rangeBand()
  rate: (value, max) -> get(max() * (value / max));
  invert: (y) -> @scale.invert(y)
  domain: () -> @scale.domain()
  range: () -> @scale.range()

  drawGrid : () ->
    root = el("g", "class" : ["grid", @options.type || "block"].join(" "))

    if @orient is "bottom" then @drawBottom(root)
    else if @orient is "top" then  @drawTop(root);
    else if @orient is "left" then @drawLeft(root);
    else if @orient is "right" then @drawRight(root);
    else if @orient is "custom" then @drawCustom(root);

    if @options.hide
      root.attr( display : "none" )

    root

  drawCustom  : (root) ->
  drawTop  : (root) ->
  drawRight : (root) ->
  drawBottom  : (root) ->
  drawleft  : (root) ->
class BlockGrid extends Grid

  points = []
  domain = []
  band = 0
  half_band = 0
  bar = 0

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  init : () ->
    @scale = new OrdinalScale()

  drawTop : (root) ->
    full_height = @chart.height()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(x2 : @chart.width() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d isnt ""
        axis = root.group().translate(points[i], 0)

        axis.append(@line(
          x1 : -half_band
          y1 : 0
          x2 : -half_band
          y2 : if hasLine then full_height else -bar
        ))

        axis.append(@chart.text({
          x: 0,
          y: -20
          "text-anchor": "middle"
          fill: @chart.theme("gridFontColor")
        }, d ))

      i++

    if !hasFull
        axis = root.group().translate(@chart.width(), 0)
        axis.append(@line(
          y2 : if hasLine then full_height else - bar
        ))

  drawBottom : (root) ->
    full_height = @chart.height()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(x2 : @chart.width() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d isnt ""
        axis = root.group().translate(points[i], 0)

        axis.append(@line(
          x1 : -half_band
          y1 : 0
          x2 : -half_band
          y2 : if hasLine then -full_height else bar
        ))

        axis.append(@chart.text({
          x: 0,
          y: 20
          "text-anchor": "middle"
          fill: @chart.theme("gridFontColor")
        }, d))

      i++

    if !hasFull
        axis = root.group().translate(@chart.width(), 0)
        axis.append(@line(
          y2 : if hasLine then -full_height else bar
        ))
  drawLeft : (root) ->
    full_width = @chart.width()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(y2 : @chart.height() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d isnt ""
        axis = root.group().translate(0, points[i] - half_band )

        axis.append(@line(
          x2 : if hasLine then full_width else -bar
        ))

        axis.append(@chart.text({
          x: -bar - 4 ,
          y: half_band + bar/2,
          "text-anchor": "end"
          fill: @chart.theme("gridFontColor")
        }, d))

      i++

    if !hasFull
      axis = root.group().translate(0, @chart.height())
      axis.append(@line(
        x2 : if hasLine then full_width else -bar
      ))

  drawRight : (root) ->
    full_width = @chart.width()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(y2 : @chart.height() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d isnt ""
        axis = root.group().translate(0, points[i] - half_band)

        axis.append(@line(
          x2 : if hasLine then -full_width else bar
        ))

        axis.append(@chart.text({
          x: bar + 4 ,
          y: half_band + bar/2,
          "text-anchor": "start"
          fill: @chart.theme("gridFontColor")
        }, d))

      i++

    if !hasFull
      axis = root.group().translate(0, @chart.height())
      axis.append(@line(
        x2 : if hasLine then -full_width else bar
      ))

  drawBefore : () ->
    @initDomain()

    width = @chart.width();
    height = @chart.height();
    max = if (@orient == "left" or @orient == "right") then height else width;

    @scale.domain(@options.domain);

    if (@options.full)
      @scale.rangeBands([0, max]);
    else
      @scale.rangePoints([0,max]);

    points = @scale.range();
    domain = @scale.domain();
    band = @scale.rangeBand();
    half_band = if @options.full then  0 else  band / 2
    bar = 6

  initDomain : () ->
    if @options.target and !@options.domain
      domain = ( d[@options.target] for d in @chart.data())

      if @options.reverse then domain.reverse()

      @options.domain = domain
      @options.step = @options.step || 10
      @options.max = @options.max || 100

  draw : () -> @drawGrid()
class DateGrid extends Grid
  ticks = []
  bar = 0
  values = []

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  init : () ->
    @scale = new TimeScale()

  drawTop : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine(
        x2 : @chart.width()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if @options.line then full_height else -bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : 0
        y : -bar - 4
        "text-anchor" : "middle"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawBottom : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine(
        x2 : @chart.width()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if @options.line then -full_height else bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : 0
        y : bar * 3
        "text-anchor" : "middle"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawLeft : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine(
        y2 : @chart.height()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if @options.line then full_width else -bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : -bar - 4
        y : bar
        "text-anchor" : "end"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawRight : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine(
        y2 : @chart.height()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if @options.line then -full_width else bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : bar + 4
        y : -bar
        "text-anchor" : "start"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawBefore : () ->
    @initDomain()

    max = @chart.height()

    if @orient == "top" or @orient == "bottom"
      max = @chart.width()

    range = [0, max]
    @scale.domain(@options.domain).range(range)
    step = @options.step

    if @options.realtime
      ticks = @scale.realTicks(step[0], step[1])
    else
      ticks = @scale.ticks(step[0], step[1])

    bar = 6
    values = (@scale.get(t) for t in ticks)

  initDomain : () ->
    if @options.target and !@options.domain
      if typeof @options.target is "string"
        @options.target = [@options.target]

      target = @options.target
      domain = []
      data = @chart.data()

      min = @options.min || undefined
      max = @options.max || undefined

      for key in target
        for row in data
          value = +row[key]

          if typeof min == "undefined"
            min = value
          else if (min > value)
            min = value

          if typeof max is "undefined"
            max = value
          else if max < value
            max = value

      @options.max = max
      @options.min = min
      @options.domain = [@options.min, @options.max]

      if @options.reverse
        @options.domain.reverse()

  draw : () -> @drawGrid()

class RangeGrid  extends Grid
  step = 0
  nice = false
  ticks = []
  bar = 0
  values = []

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  init : () ->
    @scale = new LinearScale()

  drawTop : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine( x2 : @chart.width()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if hasLine then full_height else -bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : 0
        y : -bar - 4
        "text-anchor" : "middle"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawBottom : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine( x2 : @chart.width()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if @options.line then -full_height else bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : 0
        y : bar * 3
        "text-anchor" : "middle"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawLeft : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine( y2 : @chart.height()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if @options.line then full_width else -bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : -bar-4
        y : bar
        "text-anchor" : "end"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawRight : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine( y2 : @chart.height()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if @options.line then -full_width else bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : bar+4
        y : bar-2.5
        "text-anchor" : "start"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawBefore : () ->
    @initDomain()

    width = @chart.width()
    height = @chart.height()
    @scale.domain(@options.domain)

    if (@orient == "left" || @orient == "right")
      @scale.range([height, 0])
    else
      @scale.range([0, width])

    step = @options.step || 10
    nice = @options.nice || false
    ticks = @scale.ticks(step, nice)
    bar = 6

    values = (@scale.get(t) for t in ticks)

  initDomain : () ->
    if @options.target and !@options.domain
      if typeof @options.target == 'string'
        @options.target = [@options.target]

      max = @options.max || 0
      min = @options.min || 0

      target = @options.target
      domain = []
      series = @chart.series()
      data = @chart.data()

      for key in target
        if typeof key is "function"
          for row in data
            value = +key(row)

            if max < value then max = value
            if min > value then min = value
        else
          _max = series[key].max
          _min = series[key].min

          if max < _max then max = _max
          if min > _min then min = _min


      @options.max = max
      @options.min = min
      @options.step = @options.step || 10

      unit = @options.unit || Math.ceil((max - min) / @options.step )
      start = 0

      while start < max
        start += unit

      end = 0
      while end > min
        end -= unit

      if unit == 0
        @options.domain = [0, 0]
      else
        @options.domain = [end, start]
        if @options.reverse
          @options.domain.reverse()
        @options.step = Math.abs(start/unit) + Math.abs(end/unit)

  draw : () -> @drawGrid()
class RuleGrid extends RangeGrid
  step = 0
  nice = false
  ticks = []
  bar = 0
  values = []

  hideZero = false
  center = false

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  drawTop : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then half_height else 0

    root.append(@axisLine(
      y1 : centerPosition
      y2 : centerPosition
      x2 : width
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = ticks[i] is 0

      axis = root.group().translate(values[i], centerPosition)

      axis.append(@line(
        y1 : if center then -bar else 0
        y2 : bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : 0
          y : bar*2 +4
          "text-anchor" : "middle"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++
  drawBottom : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then -half_height else 0

    root.append(@axisLine(
      y1 : centerPosition
      y2 : centerPosition
      x2 : width
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = ticks[i] is 0

      axis = root.group().translate(values[i], centerPosition)

      axis.append(@line(
        y1 : if center then -bar else 0
        y2 : if center then bar else -bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : 0
          y : -bar*2
          "text-anchor" : "middle"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++
  drawLeft : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then half_width else 0

    root.append(@axisLine(
      x1 : centerPosition
      x2 : centerPosition
      y2 : height
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = ticks[i] is 0

      axis = root.group().translate(centerPosition, values[i])

      axis.append(@line(
        x1 : if center then -bar else 0
        x2 : bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : 2*bar
          y : bar - 2
          "text-anchor" : "start"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++
  drawRight : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then -half_width else 0

    root.append(@axisLine(
      x1 : centerPosition
      x2 : centerPosition
      y2 : height
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = ticks[i] is 0

      axis = root.group().translate(centerPosition, values[i])

      axis.append(@line(
        x1 : if center then -bar else 0
        x2 : if center then bar else -bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : -bar - 4
          y : bar - 2
          "text-anchor" : "middle"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++

  drawBefore : () ->
    @initDomain()

    width = @chart.width()
    height = @chart.height()
    @scale.domain(@options.domain)

    if (@orient == "left" || @orient == "right")
      @scale.range([height, 0])
    else
      @scale.range([0, width])

    step = @options.step || 10
    nice = @options.nice || false
    ticks = @scale.ticks(step, nice)
    bar = 6

    values = (@scale.get(t) for t in ticks)

    hideZero = @options.hideZero || false
    center = @options.center || false


class Brush extends Draw
	constructor: (@chart, @brush) ->
		@init()

	init: () ->

	curvePoints: (K) ->
		p1 = []
		p2 = []
		n = K.length - 1

		a = []
		b = []
		c = []
		r = []

		#	/*left most segment*/
		a[0] = 0;
		b[0] = 2;
		c[0] = 1;
		r[0] = K[0] + 2 * K[1]

		#	/*internal segments*/
		for i in [1...(n-1)]
			a[i] = 1
			b[i] = 4
			c[i] = 1
			r[i] = 4 * K[i] + 2 * K[i + 1]

		#/*right segment*/
		a[n - 1] = 2
		b[n - 1] = 7
		c[n - 1] = 0
		r[n - 1] = 8 * K[n - 1] + K[n]

		#/*solves Ax=b with the Thomas algorithm (from Wikipedia)*/
		for i in [1...n]
			m = a[i] / b[i - 1]
			b[i] = b[i] - m * c[i - 1]
			r[i] = r[i] - m * r[i - 1]

		p1[n - 1] = r[n - 1] / b[n - 1]

		for i in [(n-2)..0]
			p1[i] = (r[i] - c[i] * p1[i + 1]) / b[i]

		#we have p1, now compute p2*/
		for i in [i...(n-1)]
			p2[i] = 2 * K[i + 1] - p1[i + 1]

		p2[n - 1] = 0.5 * (K[n] + p1[n - 1])
		p1: p1, p2: p2

	getScaleValue : (value, minValue, maxValue, minRadius, maxRadius) ->
		range = maxRadius - maxRadius
		per = (value - minValue) / (maxValue - minValue)
		range * per + minRadius

	getXY : () ->
		len = @chart.data().length;
		xy = []

		for i in [0...len]
			startX = @brush.x.get(i)
			data = @chart.data(i)

			for j in [0...@brush.target.length]
				key = @brush.target[j];
				value = data[key];
				series = @chart.series(key);

				if !xy[j]
					xy[j] = x: [], y: [], value: [], min: [], max: []

				xy[j].x.push (startX);
				xy[j].y.push(@brush.y.get(value));
				xy[j].value.push(value);
				xy[j].min.push(value is series.min);
				xy[j].max.push(value is series.max);
		xy

	getStackXY : () ->
		xy = @getXY()

		for i in [0...@chart.data().length]
			data = @chart.data(i)
			valueSum = 0

			for j in [0...@brush.target.length]
				key = @brush.target[j]
				value = data[key]

				if j > 0
					valueSum += data[@brush.target[j - 1]];

			xy[j].y[i] = @brush.y.get(value + valueSum);

		xy

class BarBrush extends Brush

  g = null
  outerPadding = 0
  innerPadding = 0
  zeroX = 0
  count = 0
  height = 0
  half_height = 0
  barHeight = 0

  borderColor = ""
  borderWidth = ""
  borderOpacity = ""

  constructor: (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  drawBefore : () ->
    g = el("g").translate(@chart.x(), @chart.y());

    outerPadding = @brush.outerPadding || 2;
    innerPadding = @brush.innerPadding || 1;

    zeroX = @brush.x.get(0);
    count = @chart.data().length;

    height = @brush.y.rangeBand();
    half_height = height - (outerPadding * 2);

    barHeight = (half_height - (@brush.target.length - 1) * innerPadding) / @brush.target.length;

    borderColor = @chart.theme("barBorderColor");
    borderWidth = @chart.theme("barBorderWidth");
    borderOpacity = @chart.theme("barBorderOpacity");

  draw: () ->
    startY = 0;
    for i in [0...count]
      group = g.group()
      startY = @brush.y.get(i) + (-half_height / 2)

      for j in [0...@brush.target.length]
        startX = @brush.x.get(@chart.data(i, @brush.target[j]))

        if startX >= zeroX
          group.rect({
            x : zeroX,
            y : startY,
            height : barHeight,
            width : Math.abs(zeroX - startX),
            fill : @chart.color(j, @brush.colors),
            stroke : borderColor,
            "stroke-width" : borderWidth,
            "stroke-opacity" : borderOpacity
          })
        else
          w = Math.abs(zeroX - startX);

          group.rect({
            y : startY,
            x : zeroX - w,
            height : barHeight,
            width : w,
            fill : @chart.color(j, @brush.colors),
            stroke : borderColor,
            "stroke-width" : borderWidth,
            "stroke-opacity" : borderOpacity
          });

        startY += barHeight + innerPadding;

    g


class BubbleBrush extends Brush


  constructor: (@chart, @brush) ->
    super @chart, @brush

  init : () ->

  createBubble : (pos, index) ->
    series = @chart.series(@brush.target[index])
    radius = @getScaleValue(pos.value, series.min, series.max, brush.min, brush.max)

    color = @chart.color(index, @brush.colors)
    opacity = @chart.theme("bubbleOpacity")
    borderWidth = @chart.theme("bubbleBorderWidth")

    el("circle", { cx: pos.x, cy: pos.y, r: radius, "fill": color, "fill-opacity": opacity, "stroke": color, "stroke-width": borderWidth })

  drawBubble: (points) ->
    g = el('g', 'clip-path' : @chart.url(@chart.clipId) ).translate(@chart.x(), @chart.y())

    for i in [0...points.length]
      for j in [0...points[i].x.length]
        g.append @createBubble({ x: points[i].x[j],  y: points[i].y[j],value: points[i].value[j] }, i)
    g

  draw : () ->
    @drawBubble(@getXY())



class CandleStickBrush extends Brush

  g = null
  count = 0
  width = 0
  barWidth = 0
  barPadding = 0

  constructor: (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  getTargets : () ->
    target = {}
    for value in @brush.target
      t = @chart.series(value)
      target[tgt.type] = t
    target

  drawBefore : () ->
    g = el("g").translate(@chart.x(), @chart.y())

    count = @chart.data().length
    width = @brush.x.rangeBand()
    barWidth = width * 0.7
    barPadding = barWidth / 2

  draw : () ->
    targets = @getTargets()

    for i in [0...count]
      startX = @brush.x.get(i);
      r = null
      l = null

      open = targets.open.data[i]
      close = targets.close.data[i]
      low =  targets.low.data[i]
      high = targets.high.data[i]

      if open > close
        y = @brush.y.get(open);

        g.line({
          x1: startX,
          y1: @brush.y.get(high),
          x2: startX,
          y2: @brush.y.get(low),
          stroke: @chart.theme("candlestickInvertBorderColor"),
          "stroke-width": 1
        });

        g.rect({
          x : startX - barPadding,
          y : y,
          width : barWidth,
          height : Math.abs(@brush.y.get(close) - y),
          fill : @chart.theme("candlestickInvertBackgroundColor"),
          stroke: @chart.theme("candlestickInvertBorderColor"),
          "stroke-width": 1
        });
      else
        y = @brush.y.get(close);

        g.line({
          x1: startX,
          y1: @brush.y.get(high),
          x2: startX,
          y2: @brush.y.get(low),
          stroke: @chart.theme("candlestickBorderColor"),
          "stroke-width":1
        });

        g.rect({
          x : startX - barPadding,
          y : y,
          width : barWidth,
          height : Math.abs(brush.y(open) - y),
          fill : chart.theme("candlestickBackgroundColor"),
          stroke: chart.theme("candlestickBorderColor"),
          "stroke-width": 1
        })

    g


class OhlcBrush extends Brush

  g = null
  count = 0

  constructor: (@chart, @brush) ->
    super @chart, @brush

  init : () ->

  getTargets : () ->
    target = {}
    for value in @brush.target
      t = @chart.series(value)
      target[tgt.type] = t
    target

  drawBefore : () ->
    g = el("g").translate(@chart.x(), @chart.y())
    count = @chart.data().length

  draw : () ->
    targets = @getTargets()

    for i in [0...count]
      startX = @brush.x.get(i);

      open = targets.open.data[i]
      close = targets.close.data[i]
      low =  targets.low.data[i]
      high = targets.high.data[i]
      color = if open > close then @chart.theme("ohlcInvertBorderColor") else @chart.theme("ohlcBorderColor")

      ## lowhigh
      g.line({
        x1: startX,
        y1: @brush.y.get(high),
        x2: startX,
        y2: @brush.y.get(low),
        stroke: color
        "stroke-width": 1
      });

      ## close
      g.line({
        x1: startX,
        y1: @brush.y.get(close),
        x2: startX + @chart.theme("ohlcBorderRadius"),
        y2: @brush.y.get(close),
        stroke: color
        "stroke-width": 1
      });

      ## open
      g.line({
        x1: startX,
        y1: @brush.y.get(open),
        x2: startX + @chart.theme("ohlcBorderRadius"),
        y2: @brush.y.get(open),
        stroke: color
        "stroke-width": 1
      });

    g
class ColumnBrush extends Brush

  g = null
  outerPadding = 0
  innerPadding = 0
  zeroY = 0
  count = 0

  width = 0
  half_width = 0
  columnWidth = 0

  borderColor = ""
  borderWidth = ""
  borderOpacity = ""

  constructor: (@chart, @brush) ->
    super @chart, @brush

  init : () ->

  drawBefore : () ->
    g = el("g").translate(chart.x(), chart.y());

    outerPadding = @brush.outerPadding || 2;
    innerPadding = @brush.innerPadding || 1;

    zeroY = @brush.y.get(0);
    count = @chart.data().length;

    width = @brush.x.rangeBand();
    half_width = (width - outerPadding * 2);
    columnWidth = (width - outerPadding * 2 - (@brush.target.length - 1) * innerPadding) / @brush.target.length;

    borderColor = @chart.theme("columnBorderColor");
    borderWidth = @chart.theme("columnBorderWidth");
    borderOpacity = @chart.theme("columnBorderOpacity");

  draw : () ->
    for i in [0...count]
      startX = @brush.x.get(i) - (half_width / 2)

      for j in [0...@brush.target.length]
        startY = @brush.y.get(@chart.data(i)[@brush.target[j]])

        if (startY <= zeroY)
          g.rect({
            x : startX,
            y : startY,
            width : columnWidth,
            height : Math.abs(zeroY - startY),
            fill : @chart.color(j, @brush.colors),
            stroke : borderColor,
            "stroke-width" : borderWidth,
            "stroke-opacity" : borderOpacity
          });
        else
          g.rect({
            x : startX,
            y : zeroY,
            width : columnWidth,
            height : Math.abs(zeroY - startY),
            fill : @chart.color(j, @brush.colors),
            stroke : borderColor,
            "stroke-width" : borderWidth,
            "stroke-opacity" : borderOpacity
          });

        startX += columnWidth + innerPadding;
    g
class DonutBrush extends Brush

  width = 0
  height = 0
  min = 0
  w = 0
  centerX = 0
  centerY = 0
  startY = 0
  startX = 0
  outerRadius = 0
  innerRadius = 0

  constructor : (@chart, @brush) ->
    super @chart, @brush

  init : () ->

  drawDonut: (centerX, centerY, innerRadius, outerRadius, startAngle, endAngle, attr, hasCircle) ->
    hasCircle = hasCircle || false;

    dist = Math.abs(outerRadius - innerRadius);

    g = el("g", { "class" : "donut" })
    path = g.path(attr)

    obj = MathUtil.rotate(0, -outerRadius, MathUtil.radian(startAngle));

    startX = obj.x;
    startY = obj.y;

    innerCircle = MathUtil.rotate(0, -innerRadius, MathUtil.radian(startAngle));

    startInnerX = innerCircle.x
    startInnerY = innerCircle.y
    path.MoveTo(startX, startY)

    obj = MathUtil.rotate(startX, startY, MathUtil.radian(endAngle));
    innerCircle = MathUtil.rotate(startInnerX, startInnerY, MathUtil.radian(endAngle));
    g.translate(centerX, centerY);

    bigAngle = if (endAngle > 180) then 1 else 0

    path.Arc(outerRadius, outerRadius, 0, bigAngle, 1, obj.x, obj.y);
    path.LineTo(innerCircle.x, innerCircle.y);
    path.Arc(innerRadius, innerRadius, 0, bigAngle, 0, startInnerX, startInnerY);
    path.ClosePath();

    if hasCircle
      centerCircle = MathUtil.rotate(0, -innerRadius - dist/2, MathUtil.radian(startAngle));

      cX = centerCircle.x;
      cY = centerCircle.y;

      centerCircleLine = MathUtil.rotate(cX, cY, MathUtil.radian(endAngle));

      g.circle({
        cx : centerCircleLine.x,
        cy : centerCircleLine.y,
        r : dist/2,
        fill  : attr.fill
      });

      g.circle({
        cx : centerCircleLine.x,
        cy : centerCircleLine.y,
        r : 3,
        fill  : "white"
      })

    g

  drawBefore : () ->
    width = @chart.width()
    height = @chart.height()
    min = width

    if height < min
      min = height;

    w = min / 2;
    centerX = width / 2;
    centerY = height / 2;
    startY = -w;
    startX = 0;
    outerRadius = Math.abs(startY);
    innerRadius = outerRadius - @brush.size;

  draw : () ->
    s = @chart.series(@brush.target[0])
    group = el("g", "class": "brush donut" ).translate(@chart.x(), @chart.y())

    all = 360;
    startAngle = 0;

    max = 0;
    for d in s.data
      max += d

    for i in [0...s.data.length]
      data = s.data[i]
      endAngle = all * (data / max)

      g = @drawDonut(centerX, centerY, innerRadius, outerRadius, startAngle, endAngle, {
        fill : @chart.color(i, @brush.colors),
        stroke : @chart.theme("donutBorderColor"),
        "stroke-width" : @chart.theme("donutBorderWidth")
      });

      group.append(g);
      startAngle += endAngle;

    group
class EqualizerBrush extends Brush
  g = null
  zeroY = 0
  count = 0
  width = 0
  barWidth = 0
  half_width = 0

  innerPadding = 0
  outerPadding = 0
  unit = 0
  gap = 0

  constructor: (@chart, @brush) ->
    super @chart, @brush

  drawBefore : () ->
    g = el("g").translate(@chart.x(), @chart.y());

    zeroY = @brush.y.get(0);
    count = @chart.data().length;

    innerPadding = @brush.innerPadding || 10
    outerPadding = @brush.outerPadding || 15
    unit = @brush.unit ||  5
    gap = @brush.gap || 5


    width = @brush.x.rangeBand();
    half_width = (width - outerPadding * 2) / 2;
    barWidth = (width - outerPadding * 2 - (target.length - 1) * innerPadding) / target.length;

  draw : () ->
    for i in [0...count]
      startX = @brush.x.get(i) - half_width

      for j in [0...@brush.target.length]
        barGroup = g.group();
        startY = @brush.y.get(@chart.data(i, @brush.target[j]))
        padding = 1.5
        eY = zeroY
        eIndex = 0

        if startY <= zeroY
          while (eY > startY)
            unitHeight = if (eY - unit < startY) then Math.abs(eY - startY) else unit;
            barGroup.rect({
              x : startX,
              y : eY - unitHeight,
              width : barWidth,
              height : unitHeight,
              fill : @chart.color(Math.floor(eIndex / gap), @brush.colors)
            });

            eY -= unitHeight + padding;
            eIndex++;
        else
          while (eY < startY)
            unitHeight = if (eY + unit > startY) then Math.abs(eY - startY) else unit;
            barGroup.rect({
              x : startX,
              y : eY,
              width : barWidth,
              height : unitHeight,
              fill : @chart.color(Math.floor(eIndex / gap), @brush.colors)
            });

            eY += unitHeight + padding;
            eIndex++;

        startX += barWidth + innerPadding;
    g
class FullStackBrush extends Brush
  g = null
  zeroY = 0
  count = 0
  width = 0
  barWidth = 0
  outerPadding = 0

  constructor : (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  drawBefore: () ->
    g = el('g').translate(@chart.x(), @chart.y());
    zeroY = @brush.y.get(0);
    count = @chart.data().length;

    outerPadding = @brush.outerPadding || 15

    width = @brush.x.rangeBand();
    barWidth = width - outerPadding * 2;

  draw : () ->
    chart_height = @chart.height();

    for i in [0...count]
      startX = @brush.x.get(i) - barWidth / 2
      sum = 0
      list = []

      list = for j in [0...@brush.target.length]
        height = @chart.data(i, @brush.target[j]);
        sum += height
        height

      startY = 0
      max = @brush.y.max()
      current = max

      for j in [list.length...0]
        height = chart_height - @brush.y.rate(list[j] , sum);

        g.rect({
          x : startX,
          y : startY,
          width : barWidth,
          height : height,
          fill : @chart.color(j, @brush.colors)
        });


        if @brush.text
          percent = Math.round((list[j]/sum)*max);
          g.text({
            x : startX + barWidth / 2,
            y : startY + height / 2 + 8,
            "text-anchor" : "middle"
          }, (if (current - percent < 0 ) then current else percent) + "%");

          current -= percent;

        startY += height;
    g




class LineBrush extends Brush

  symbol = "normal"

  constructor : (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  drawBefore : () ->
    symbol = @brush.symbol || "normal"

  createLine: (pos, index) ->
    x = pos.x
    y = pos.y

    p = new Path({
      stroke : @chart.color(index, @brush.colors),
      "stroke-width" : @chart.theme("lineBorderWidth"),
      fill : "transparent"
    }).MoveTo(x[0], y[0]);

    if symbol == "curve"
      px = @curvePoints(x)
      py = @curvePoints(y)

      for i in [0...x.length]
       p.CurveTo(px.p1[i], py.p1[i], px.p2[i], py.p2[i], x[i + 1], y[i + 1])
    else
      for i in [0...x.length]
        if symbol == "step"
          sx = x[i] + ((x[i + 1] - x[i]) / 2);
          p.LineTo(sx, y[i]);
          p.LineTo(sx, y[i + 1])

        p.LineTo(x[i + 1], y[i + 1]);

    p

  drawLine: (path) ->
    g = el('g').translate(@chart.x(), @chart.y())

    for k in [0...path.length]
      p = @createLine(path[k], k)
      g.append(p)

    g

  draw : () ->
    @drawLine(@getXY())

class PathBrush extends Brush
  constructor : (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  draw : () ->
    g = el("g", "class" : "brush path")

    data = @chart.data()
    count = data.length

    for ti in [0...@brush.target.length]
      color = @chart.color(ti, @brush.colors);

      path = g.path({
        fill : color,
        "fill-opacity" : @chart.theme("pathOpacity"),
        stroke : color,
        "stroke-width" : @chart.theme("pathBorderWidth")
      });

      for i in [0...count]
        obj = @brush.c(i, @chart.data(i, @brush.target[ti]));

        if (i == 0)
          path.MoveTo(obj.x, obj.y)
        else
          path.LineTo(obj.x, obj.y)

      path.ClosePath();

    g
if typeof module isnt "undefined" and typeof module.exports isnt "undefined"
  module.exports = ChartBuilder
else
  if typeof define is "function" and define.amd
    define([], () -> ChartBuilder)
  else
    window.ChartBuilder = ChartBuilder
