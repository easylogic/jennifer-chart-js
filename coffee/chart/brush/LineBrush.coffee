class LineBrush extends Brush

  symbol

  constructor : (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  drawBefore : () ->
    symbol = @brush.symbol || "normal"

  createLine: (pos, index) ->
    x = pos.x
    y = pos.y

    p = el("path", {
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
