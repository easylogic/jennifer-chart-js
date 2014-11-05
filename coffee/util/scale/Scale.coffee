class Scale
  _rangeBand = 0
  _isRound = false
  _clamp = false
  _domain = []
  _range = []
  _key = ""

  constructor : (domain ,range) ->
    _domain = domain
    _range = range
    @init()

  init : () ->

  clamp : (clamp) ->
    if arguments.length == 0
      _clamp
    else
      _clamp = clamp
      @
    
  get : (x) -> 0
  max : () -> Math.max(_domain[0], _domain[_domain.length-1])
  min : () -> Math.min(_domain[0], _domain[_domain.length-1])
  rangeBand : () -> _rangeBand
  rate : (value, max) ->
    @get (@max() * (value / max))
  invert : (y) -> 0
  domain : (values) ->
    if arguments.length is 0
      _domain
    else
      _domain = (value for value in values)
      @
  range : (values) ->
    if arguments.length is 0
      _range
    else
      _range = (value for value in values)
      @
  round : () -> _isRound
  rangeRound : (values) ->
    _isRound = true
    @range values