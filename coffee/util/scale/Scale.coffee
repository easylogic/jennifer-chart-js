class Scale
  constructor : (@_domain ,@_range) ->
    @init()

  init : () ->

  clamp : (clamp) ->
    if arguments.length == 0
      @_clamp
    else
      @_clamp = clamp
      @
    
  get : (x) -> 0
  max : () -> Math.max(@_domain...)
  min : () -> Math.min(@_domain...)
  rangeBand : (band) ->
    if arguments.length == 0
      @_rangeBand
    else
      @_rangeBand = band
      @
  rate : (value, max) ->
    @get (@max() * (value / max))
  invert : (y) -> 0
  domain : (values) ->
    if arguments.length is 0
      @_domain
    else
      @_domain = (value for value in values)
      @
  range : (values) ->
    if arguments.length is 0
      @_range
    else
      @_range = (value for value in values)
      @
  round : () -> @_isRound
  rangeRound : (values) ->
    @_isRound = true
    @range values