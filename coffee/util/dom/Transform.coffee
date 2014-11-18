class Transform extends DomUtil
  constructor: (@tagName, @attr) ->
    super @tagName, @attr
    @orders = {}

  translate : (x, y) ->
    @orders.translate = [x, y].join(" ")
    @
  rotate : (angle, x, y) ->
    @orders.rotate = [angle, x, y].join(" ")
    @
  render: () ->
    list = ("#{key}(#{value})" for key, value of @orders)

    if list.length
      @put "transform", list.join(" ")

    super()