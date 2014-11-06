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

  drawCustom : () ->
  drawTop : () ->
  drawRight : () ->
  drawBottom : () ->
  drawLeft : () ->

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

    {root : root, scale : @ }

  drawCustom  : (root) ->
  drawTop  : (root) ->
  drawRight : (root) ->
  drawBottom  : (root) ->
  drawleft  : (root) ->