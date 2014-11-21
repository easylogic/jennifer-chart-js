class DonutBrush extends Brush

  width = 0
  height = 0
  min = 0
  w = 0
  centerX = 0
  centerY = 0
  startY = 0
  startX = 0
  outerRadius = 0
  innerRadius = 0

  constructor : (@chart, @brush) ->
    super @chart, @brush

  init : () ->

  drawDonut: (centerX, centerY, innerRadius, outerRadius, startAngle, endAngle, attr, hasCircle) ->
    hasCircle = hasCircle || false;

    dist = Math.abs(outerRadius - innerRadius);

    g = el("g", { "class" : "donut" })
    path = g.path(attr)

    obj = MathUtil.rotate(0, -outerRadius, MathUtil.radian(startAngle));

    startX = obj.x;
    startY = obj.y;

    innerCircle = MathUtil.rotate(0, -innerRadius, MathUtil.radian(startAngle));

    startInnerX = innerCircle.x
    startInnerY = innerCircle.y
    path.MoveTo(startX, startY)

    obj = MathUtil.rotate(startX, startY, MathUtil.radian(endAngle));
    innerCircle = MathUtil.rotate(startInnerX, startInnerY, MathUtil.radian(endAngle));
    g.translate(centerX, centerY);

    bigAngle = if (endAngle > 180) then 1 else 0

    path.Arc(outerRadius, outerRadius, 0, bigAngle, 1, obj.x, obj.y);
    path.LineTo(innerCircle.x, innerCircle.y);
    path.Arc(innerRadius, innerRadius, 0, bigAngle, 0, startInnerX, startInnerY);
    path.ClosePath();

    if hasCircle
      centerCircle = MathUtil.rotate(0, -innerRadius - dist/2, MathUtil.radian(startAngle));

      cX = centerCircle.x;
      cY = centerCircle.y;

      centerCircleLine = MathUtil.rotate(cX, cY, MathUtil.radian(endAngle));

      g.circle({
        cx : centerCircleLine.x,
        cy : centerCircleLine.y,
        r : dist/2,
        fill  : attr.fill
      });

      g.circle({
        cx : centerCircleLine.x,
        cy : centerCircleLine.y,
        r : 3,
        fill  : "white"
      })

    g

  drawBefore : () ->
    width = @chart.width()
    height = @chart.height()
    min = width

    if height < min
      min = height;

    w = min / 2;
    centerX = width / 2;
    centerY = height / 2;
    startY = -w;
    startX = 0;
    outerRadius = Math.abs(startY);
    innerRadius = outerRadius - @brush.size;

  draw : () ->
    s = @chart.series(@brush.target[0])
    group = el("g", "class": "brush donut" ).translate(@chart.x(), @chart.y())

    all = 360;
    startAngle = 0;

    max = 0;
    for d in s.data
      max += d

    for i in [0...s.data.length]
      data = s.data[i]
      endAngle = all * (data / max)

      g = @drawDonut(centerX, centerY, innerRadius, outerRadius, startAngle, endAngle, {
        fill : @chart.color(i, @brush.colors),
        stroke : @chart.theme("donutBorderColor"),
        "stroke-width" : @chart.theme("donutBorderWidth")
      });

      group.append(g);
      startAngle += endAngle;

    group