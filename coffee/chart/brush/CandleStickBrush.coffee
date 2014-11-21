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

