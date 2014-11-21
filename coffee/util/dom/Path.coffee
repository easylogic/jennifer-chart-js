class Path extends Transform
  paths : [],
  constructor : (attr) ->
    super "path", attr
    @paths = []

  moveTo: (x, y) ->
    @paths.push "m#{x},#{y}"
    @
  MoveTo: (x, y) ->
    @paths.push "M#{x},#{y}"
    @
  lineTo: (x, y) ->
    @paths.push "l#{x},#{y}"
    @
  LineTo: (x, y) ->
    @paths.push "L#{x},#{y}"
    @
  hLineTo: (x) ->
    @paths.push "h#{x}"
    @
  HLineTo: (x) ->
    @paths.push "h#{x}"
    @
  vLineTo: (y) ->
    @paths.push "v#{y}"
    @
  VLineTo: (y) ->
    @paths.push "V#{y}"
    @
  curveTo: ( x1,  y1,  x2,  y2,  x,  y) ->
    @paths.push "c" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x + "," + y
    @
  CurveTo: ( x1,  y1,  x2,  y2,  x,  y) ->
    @paths.push "C" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x + "," + y
    @
  sCurveTo: (  x2,  y2,  x,  y) ->
    @paths.push "s" + x2 + "," + y2 + " " + x + "," + y
    @
  SCurveTo: ( x2,  y2,  x,  y) ->
    @paths.push "s" + x2 + "," + y2 + " " + x + "," + y
    @
  qCurveTo: (  x1,  y1,  x,  y) ->
    @paths.push "q" + x1 + "," + y1 + " " + x + "," + y
    @
  QCurveTo: (  x1,  y1,  x,  y)  ->
    @paths.push "Q" + x1 + "," + y1 + " " + x + "," + y
    @
  tCurveTo: ( x1,  y1,  x,  y) ->
    @paths.push "t" + x1 + "," + y1 + " " + x + "," + y
    @
  TCurveTo: ( x1,  y1,  x,  y) ->
    @paths.push "T" + x1 + "," + y1 + " " + x + "," + y
    @
  arc: (  rx,  ry,  x_axis_rotation,  large_arc_flag,  sweep_flag,  x,  y) ->
    @paths.push "a" + rx + "," + ry + " " + x_axis_rotation + " " + large_arc_flag + "," + sweep_flag + " " + x + "," + y
    @
  Arc: (  rx,  ry,  x_axis_rotation,  large_arc_flag,  sweep_flag,  x,  y) ->
    @paths.push "A" + rx + "," + ry + " " + x_axis_rotation + " " + large_arc_flag + "," + sweep_flag + " " + x + "," + y
    @
  close: () ->
    @paths.push "z"
    @
  Close: () ->
    @paths.push "Z"
    @
  triangle : ( cx,  cy,  width,  height) ->
    @MoveTo(cx, cy).moveTo(0, -height/2).lineTo(width/2,height).lineTo(-width, 0).lineTo(width/2, -height)
  rect : ( cx,  cy,  width,  height) ->
    @MoveTo(cx, cy).moveTo(-width/2, -height/2).lineTo(width,0).lineTo(0, height).lineTo(-width, 0).lineTo(0, -height)
  rectangle : ( cx,  cy,  width,  height) ->
    @rect(cx, cy, width, height)
  cross : ( cx,  cy,  width,  height) ->
    @MoveTo(cx, cy).moveTo(-width/2, -height/2).lineTo(width, height).moveTo(0, -height).lineTo(-width, height);
  circle : ( cx,  cy,  r) ->
    @MoveTo(cx, cy).moveTo(-r, 0).arc(r, r, 0, 1, 1, r*2, 0).arc(r, r, 0, 1, 1, -(r*2), 0)

  render : () ->
    @put "d", @paths.join(" ")
    super()
