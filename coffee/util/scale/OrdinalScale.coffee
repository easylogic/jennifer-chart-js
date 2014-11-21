class OrdinalScale extends Scale
  constructor : (domain ,range) ->
    super domain || [0, 1], range || [0, 1]
  get : (x) ->
    _domain = @domain()
    index = -1
    i = 0
    len = _domain.length
    for i in [0...len]
      if _domain[i] == x
        index = i
        break

      i++;

    _range = @range()

    if index > -1
      _range[index]
    else
      if typeof _range[x] isnt 'undefined'
        _domain[x] = x
        _range[x]
      else
        null

  rangePoints : (interval, padding) ->
    _domain = @domain()
    padding = padding || 0;

    step = _domain.length;
    unit = (interval[1] - interval[0] - padding) / step;

    range = [];
    i = 0
    len = _domain.length;
    while i < len
      if i == 0
        range[i] = interval[0] + padding / 2 + unit / 2;
      else
        range[i] = range[i - 1] + unit;
      i++

    @range range
    @rangeBand unit
    @

  rangeBands : (interval, padding, outerPadding) ->
    _domain = @domain()
    padding = padding || 0;
    outerPadding = outerPadding || 0;

    count = _domain.length;
    step = count - 1;
    band = (interval[1] - interval[0]) / step;

    range = [];
    i = 0
    while i < count
      if i == 0
        range[i] = interval[0];
      else
        range[i] = band + range[i - 1];
      i++

    @rangeBand band
    @range range
    @