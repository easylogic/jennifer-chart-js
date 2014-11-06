class RangeGrid  extends Grid
  step = 0
  nice = false
  ticks = []
  bar = 0
  values = []

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  init : () ->
    @scale = new LinearScale()

  drawTop : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine( x2 : @chart.width()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if hasLine then full_height else -bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : 0
        y : -bar - 4
        "text-anchor" : "middle"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawBottom : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine( x2 : @chart.width()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if @options.line then -full_height else bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : 0
        y : bar * 3
        "text-anchor" : "middle"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawLeft : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine( y2 : @chart.height()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if hasLine then full_width else -bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : -bar-4
        y : bar
        "text-anchor" : "end"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawRight : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine( y2 : @chart.height()  ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 and ticks[i] isnt min then true else false

      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if hasLine then -full_width else bar
        stroke : @chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor")
        "stroke-width" : @chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      axis.append(@chart.text( {
        x : bar+4
        y : bar
        "text-anchor" : "start"
        fill : @chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
      }, textValue ))

      i++
  drawBefore : () ->
    @initDomain()

    width = @chart.width()
    height = @chart.height()
    @scale.domain(@options.domain)

    if (@orient == "left" || @orient == "right")
      @scale.range([height, 0])
    else
      @scale.range([0, width])

    step = @options.step || 10
    nice = @options.nice || false
    ticks = @scale.ticks(step, nice)
    bar = 6

    values = (@scale.get(t) for t in ticks)

  initDomain : () ->
    if @options.target and !@options.domain
      if typeof @options.target == 'string'
        @options.target = [@options.target]

      max = @options.max || 0
      min = @options.min || 0

      target = @options.target
      domain = []
      series = @chart.series()
      data = @chart.data()

      for key in target
        if typeof key is "function"
          for row in data
            value = +key(row)

            if max < value then max = value
            if min > value then min = value
        else
          _max = series[key].max
          _min = series[key].min

          if max < _max then max = _max
          if min > _min then min = _min


      @options.max = max
      @options.min = min
      @options.step = @options.step || 10

      unit = @options.unit || Math.ceil((max - min) / @options.step )
      start = 0

      while start < max
        start += unit

      end = 0
      while end > min
        end -= unit

      if unit == 0
        @options.domain = [0, 0]
      else
        @options.domain = [end, start]
        if @options.reverse
          @options.domain.reverse()
        @options.step = Math.abs(start/unit) + Math.abs(end/unit)

  draw : () -> @drawGrid()