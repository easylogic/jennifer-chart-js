class MathUtil
  # 2d rotate
  @rotate : (x, y, radian) ->
    { x : x * Math.cos(radian) - y * Math.sin(radian), y : x * Math.sin(radian) + y * Math.cos(radian) }

  # degree to radian
  @radian : (degree) ->
    degree * Math.PI / 180

  # radian to degree
  @degree : (radian) ->
    radian * 180 / Math.PI

  #중간값 계산 하기
  @interpolateNumber : (a, b) ->
    (t) ->
      a + (b - a) * t

  # 중간값 round 해서 계산하기
  @interpolateRound : (a, b) ->
    f = MathUtil.interpolateNumber(a, b)
    (t) ->
      Math.round(f(t))

  @niceNum : (range, round) ->
    exponent = Math.floor(Math.log(range) / Math.LN10)
    fraction = range / Math.pow(10, exponent)

    if round
      if fraction < 1.5
        niceFraction = 1
      else if fraction < 3
        niceFraction = 2
      else if fraction < 7
        niceFraction = 5
      else
        niceFraction = 10
    else
      if fraction <= 1
        niceFraction = 1
      else if fraction <= 2
        niceFraction = 2
      else if fraction <= 5
        niceFraction = 5
      else
        niceFraction = 10

    niceFraction * Math.pow(10, exponent)

  @nice : (min, max, ticks, isNice) ->
    isNice = if isNice then isNice else false
    if min > max
      _max = min
      _min = max
    else
      _min = min
      _max = max

    _ticks = ticks;
    _tickSpacing = 0;
    _niceMin;
    _niceMax;

    _range = if isNice then @niceNum(_max - _min, false) else _max - _min
    _tickSpacing = if isNice then @niceNum(_range / _ticks, true) else _range / _ticks
    _niceMin = if isNice then Math.floor(_min / _tickSpacing) * _tickSpacing else _min
    _niceMax = if isNice then Math.floor(_max / _tickSpacing) * _tickSpacing else _max

    { min : _niceMin, max : _niceMax, range : _range, spacing : _tickSpacing }
