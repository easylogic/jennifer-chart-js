class Polygon extends Transform
  points : [],
  constructor : (attr) ->
    super "polygon", attr

  point : (x, y) ->
    @points.push [x,y].join(",")
    @
  toString : () ->
    @put "points", @points.join("-")
    super()
