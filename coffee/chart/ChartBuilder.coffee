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
    @addWidget "title", TitleWidget
    @addWidget "legend", LegendWidget

  initBrush : () ->
    ###
    @addBrush "area", AreaBrush
    @addBrush "bar", BarBrush
    @addBrush "bargauge", BarGaugeBrush
    @addBrush "bubble", BubbleBrush
    @addBrush "candlestick", CandleStickBrush
    @addBrush "circlegauge", CircleGaugeBrush
    @addBrush "column", ColumnBrush
    @addBrush "donut", DonutBrush
    @addBrush "equalizer", EqualizerBrush
    @addBrush "fillgauge", FillGaugeBrush
    @addBrush "fullgauge", FullGaugeBrush
    @addBrush "fullstack", FullStackBrush
    @addBrush "gauge", GagueBrush
    @addBrush "line", LineBrush
    @addBrush "ohlc", OhlcBrush
    @addBrush "path", PathBrush
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

    console.log _brush

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
        #result.addClass type + " " + obj.type

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
        scales.y = _scales.y1

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

          console.log(@x2())

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
