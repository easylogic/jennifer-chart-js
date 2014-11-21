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
      startX = @brush.x(i);

      open = targets.open.data[i]
      close = targets.close.data[i]
      low =  targets.low.data[i]
      high = targets.high.data[i]
      color = if open > close then @chart.theme("ohlcInvertBorderColor") else @chart.theme("ohlcBorderColor")

      ## lowhigh
      g.line({
        x1: startX,
        y1: @brush.y(high),
        x2: startX,
        y2: @brush.y(low),
        stroke: color
        "stroke-width": 1
      });

      ## close
      g.line({
        x1: startX,
        y1: @brush.y(close),
        x2: startX + @chart.theme("ohlcBorderRadius"),
        y2: @brush.y(close),
        stroke: color
        "stroke-width": 1
      });

      ## open
      g.line({
        x1: startX,
        y1: @brush.y(open),
        x2: startX + @chart.theme("ohlcBorderRadius"),
        y2: @brush.y(open),
        stroke: color
        "stroke-width": 1
      });

    g