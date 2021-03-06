class EqualizerBrush extends Brush
  g = null
  zeroY = 0
  count = 0
  width = 0
  barWidth = 0
  half_width = 0

  innerPadding = 0
  outerPadding = 0
  unit = 0
  gap = 0

  constructor: (@chart, @brush) ->
    super @chart, @brush

  drawBefore : () ->
    g = el("g").translate(@chart.x(), @chart.y());

    zeroY = @brush.y.get(0);
    count = @chart.data().length;

    innerPadding = @brush.innerPadding || 10
    outerPadding = @brush.outerPadding || 15
    unit = @brush.unit ||  5
    gap = @brush.gap || 5


    width = @brush.x.rangeBand();
    half_width = (width - outerPadding * 2) / 2;
    barWidth = (width - outerPadding * 2 - (target.length - 1) * innerPadding) / target.length;

  draw : () ->
    for i in [0...count]
      startX = @brush.x.get(i) - half_width

      for j in [0...@brush.target.length]
        barGroup = g.group();
        startY = @brush.y.get(@chart.data(i, @brush.target[j]))
        padding = 1.5
        eY = zeroY
        eIndex = 0

        if startY <= zeroY
          while (eY > startY)
            unitHeight = if (eY - unit < startY) then Math.abs(eY - startY) else unit;
            barGroup.rect({
              x : startX,
              y : eY - unitHeight,
              width : barWidth,
              height : unitHeight,
              fill : @chart.color(Math.floor(eIndex / gap), @brush.colors)
            });

            eY -= unitHeight + padding;
            eIndex++;
        else
          while (eY < startY)
            unitHeight = if (eY + unit > startY) then Math.abs(eY - startY) else unit;
            barGroup.rect({
              x : startX,
              y : eY,
              width : barWidth,
              height : unitHeight,
              fill : @chart.color(Math.floor(eIndex / gap), @brush.colors)
            });

            eY += unitHeight + padding;
            eIndex++;

        startX += barWidth + innerPadding;
    g