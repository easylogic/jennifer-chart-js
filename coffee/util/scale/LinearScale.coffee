class LinearScale extends Scale
  constructor : (domain ,range) ->
    super domain || [0, 1], range || [0, 1]

  get : (x) ->
    index = -1
    _domain = @domain()
    _range = @range()

    i = 0
    len = _domain.length
    while(i < len)
      if i is len - 1
        if x is _domain[i]
          index = i
          break
      else
        if _domain[i] < _domain[i + 1]
          if x >= _domain[i] and x < _domain[i + 1]
            index = i
            break
        else if _domain[i] >= _domain[i + 1]
          if x <= _domain[i] and _domain[i + 1] < x
            index = i
            break
      i++

    if !_range
      if index is 0
        return 0
      else if index == -1
        return 1
      else
        min = _domain[index - 1]
        max = _domain[index]

        pos = (x - min) / (max - min)
        return pos
    else
      if _domain.length - 1 is index
        return _range[index]
      else if index == -1
        max = @max()
        min = @min()

        if max < x
          if @clamp() then return max

          last = _domain[_domain.length -1]
          last2 = _domain[_domain.length -2]

          rlast = _range[_range.length -1]
          rlast2 = _range[_range.length -2]

          distLast = Math.abs(last - last2)
          distRLast = Math.abs(rlast - rlast2)

          return rlast + Math.abs(x - max) * distRLast / distLast
        else if min > x
          if @clamp() then return min

          first = _domain[0];
          first2 = _domain[1];

          rfirst = _range[0];
          rfirst2 = _range[1];

          distFirst = Math.abs(first - first2);
          distRFirst = Math.abs(rfirst - rfirst2);

          return rfirst - Math.abs(x - min) * distRFirst / distFirst;

        return _range[_range.length - 1]
      else
        min = _domain[index];
        max = _domain[index+1];

        minR = _range[index];
        maxR = _range[index + 1];

        pos = (x - min) / (max - min);

        scale = if @round() then  MathUtil.interpolateRound(minR, maxR)  else  MathUtil.interpolateNumber(minR, maxR)
        scale(pos)

  invert : (y) ->
    new LinearScale(@range(), @domain()).get(y)

  ticks : (count, isNice, intNumber)  ->
    intNumber = intNumber || 10000

    _domain = @domain()

    if _domain[0] == 0 and _domain[1] == 0
       return []

    obj = MathUtil.nice(_domain[0], _domain[1], count || 10, isNice || false)
    arr = []

    start = obj.min * intNumber
    end = obj.max * intNumber

    arr = while start <= end
        value = start / intNumber
        start += obj.spacing * intNumber
        value

    if arr[arr.length - 1] * intNumber isnt end and start > end
      arr.push end / intNumber

    arr