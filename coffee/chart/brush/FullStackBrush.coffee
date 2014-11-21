class FullStackBrush extends Brush
  g = null
  zeroY = 0
  count = 0
  width = 0
  barWidth = 0
  outerPadding = 0

  constructor : (@chart, @brush) ->
    super @chart, @brush

  init: () ->

  drawBefore: () ->
    g = el('g').translate(@chart.x(), @chart.y());
    zeroY = @brush.y.get(0);
    count = @chart.data().length;

    outerPadding = @brush.outerPadding || 15

    width = @brush.x.rangeBand();
    barWidth = width - outerPadding * 2;

  draw : () ->
    chart_height = @chart.height();

    for i in [0...count]
      startX = @brush.x.get(i) - barWidth / 2
      sum = 0
      list = []

      list = for j in [0...@brush.target.length]
        height = @chart.data(i, @brush.target[j]);
        sum += height
        height

      startY = 0
      max = @brush.y.max()
      current = max

      for j in [list.length...0]
        height = chart_height - @brush.y.rate(list[j] , sum);

        g.rect({
          x : startX,
          y : startY,
          width : barWidth,
          height : height,
          fill : @chart.color(j, @brush.colors)
        });


        if @brush.text
          percent = Math.round((list[j]/sum)*max);
          g.text({
            x : startX + barWidth / 2,
            y : startY + height / 2 + 8,
            "text-anchor" : "middle"
          }, (if (current - percent < 0 ) then current else percent) + "%");

          current -= percent;

        startY += height;
    g



