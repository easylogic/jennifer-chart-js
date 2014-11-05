class Svg extends DomUtil
  constructor : (attr) ->
    super("svg", attr)

  init : () ->
    @put "xmlns", "http://www.w3.org/2000/svg"

  toXml : () ->
    "<?xml version='1.1' encoding='utf-8' ?>\r\n<!DOCTYPE svg>\r\n" + @toString()