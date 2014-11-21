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