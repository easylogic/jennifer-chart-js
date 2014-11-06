class DateGrid extends Grid
  ticks = []
  bar = 0
  values = []

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  init : () ->
    @scale = new TimeScale()

  drawTop : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine(
        x2 : @chart.width()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if @options.line then full_height else -bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : 0
        y : -bar - 4
        "text-anchor" : "middle"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawBottom : (root) ->
    full_height = @chart.height()

    if !@options.line
      root.append(@axisLine(
        x2 : @chart.width()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(values[i], 0)

      axis.append(@line(
        y2 : if @options.line then -full_height else bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : 0
        y : bar * 3
        "text-anchor" : "middle"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawLeft : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine(
        y2 : @chart.height()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if @options.line then full_width else -bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : -bar - 4
        y : bar
        "text-anchor" : "end"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawRight : (root) ->
    full_width = @chart.width()

    if !@options.line
      root.append(@axisLine(
        y2 : @chart.height()
      ))

    i = 0
    len = ticks.length
    while i < len
      axis = root.group().translate(0, values[i])

      axis.append(@line(
        x2 : if @options.line then -full_width else bar
      ))

      textValue = if @options.format then @options.format(ticks[i]) else ticks[i] + ""

      axis.append(@chart.text({
        x : bar + 4
        y : -bar
        "text-anchor" : "start"
        fill : @chart.theme("gridFontColor")
      }, textValue))
      i++
  drawBefore : () ->
    @initDomain()

    max = @chart.height()

    if @orient == "top" or @orient == "bottom"
      max = @chart.width()

    range = [0, max]
    @scale.domain(@options.domain).range(range)
    step = @options.step

    if @options.realtime
      ticks = @scale.realTicks(step[0], step[1])
    else
      ticks = @scale.ticks(step[0], step[1])

    bar = 6
    values = (@scale.get(t) for t in ticks)

  initDomain : () ->
    if @options.target and !@options.domain
      if typeof @options.target is "string"
        @options.target = [@options.target]

      target = @options.target
      domain = []
      data = @chart.data()

      min = @options.min || undefined
      max = @options.max || undefined

      for key in target
        for row in data
          value = +row[key]

          if typeof min == "undefined"
            min = value
          else if (min > value)
            min = value

          if typeof max is "undefined"
            max = value
          else if max < value
            max = value

      @options.max = max
      @options.min = min
      @options.domain = [@options.min, @options.max]

      if @options.reverse
        @options.domain.reverse()

  draw : () -> @drawGrid()
