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