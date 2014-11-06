class Polyline extends Transform
  points : [],
  constructor : (attr) ->
    super "polyline", attr
    @points = []

  point : (x, y) ->
    @points.push [x,y].join(",")
    @
  render : () ->
    @put "points", @points.join("-")
    super()