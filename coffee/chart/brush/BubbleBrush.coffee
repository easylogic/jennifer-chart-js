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


