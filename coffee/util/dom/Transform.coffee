class Transform extends DomUtil
  orders : {}
  translate : (x, y) ->
    @orders.translate = [x, y].join(" ")
    @
  rotate : (angle, x, y) ->
    @orders.rotate = [angle, x, y].join(" ")
    @
  render: () ->
    list = ("#{key}(#{value})" for key, value of @orders)

    @put "transform", list.join(" ")

    super()