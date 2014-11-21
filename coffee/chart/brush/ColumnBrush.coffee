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

    zeroY = @brush.y(0);
    count = @chart.data().length;

    width = @brush.x.rangeBand();
    half_width = (width - outerPadding * 2);
    columnWidth = (width - outerPadding * 2 - (@brush.target.length - 1) * innerPadding) / @brush.target.length;

    borderColor = @chart.theme("columnBorderColor");
    borderWidth = @chart.theme("columnBorderWidth");
    borderOpacity = @chart.theme("columnBorderOpacity");

  draw : () ->
    for i in [0...count]
      startX = @brush.x(i) - (half_width / 2)

      for j in [0...@brush.target.length]
        startY = @brush.y(@chart.data(i)[@brush.target[j]])

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