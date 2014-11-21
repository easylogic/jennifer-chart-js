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

    zeroX = @brush.x(0);
    count = @chart.data().length;

    height = @brush.y.rangeBand();
    half_height = height - (outerPadding * 2);
    barHeight = (half_height - (@brush.target.length - 1) * innerPadding) / @brush.target.length;

    borderColor = @chart.theme("barBorderColor");
    borderWidth = @chart.theme("barBorderWidth");
    borderOpacity = @chart.theme("barBorderOpacity");

  draw: () ->
    for i in [0...count]
      group = g.group()
      startY = @brush.y(i) - (half_height / 2)

      for j in [0...@brush.target.length]
        startX = @brush.x(@chart.data(i, @brush.target[j]))

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

