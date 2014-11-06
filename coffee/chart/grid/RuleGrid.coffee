class RuleGrid extends RangeGrid
  step = 0
  nice = false
  ticks = []
  bar = 0
  values = []

  hideZero = false
  center = false

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  drawTop : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then half_height else 0

    root.append(@axisLine(
      y1 : centerPosition
      y2 : centerPosition
      x2 : width
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 then true else false

      axis = root.group().translate(values[i], centerPosition)

      axis.append(@line(
        y1 : if center then -bar else 0
        y2 : bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : 0
          y : bar*2 +4
          "text-anchor" : "middle"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++
  drawBottom : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then -half_height else 0

    root.append(@axisLine(
      y1 : centerPosition
      y2 : centerPosition
      x2 : width
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 then true else false

      axis = root.group().translate(values[i], centerPosition)

      axis.append(@line(
        y1 : if center then -bar else 0
        y2 : if center then bar else -bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : 0
          y : -bar*2
          "text-anchor" : "middle"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++
  drawLeft : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then half_width else 0

    root.append(@axisLine(
      x1 : centerPosition
      x2 : centerPosition
      y2 : height
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 then true else false

      axis = root.group().translate(centerPosition, values[i])

      axis.append(@line(
        x1 : if center then -bar else 0
        x2 : bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : 2*bar
          y : bar - 2
          "text-anchor" : "start"
          fill : @chart.theme("gridFontColor")
        }, textValue))

      i++
  drawRight : (root) ->
    width = @chart.width()
    height = @chart.height()

    half_width = width/ 2
    half_height = height/2

    centerPosition = if center then -half_width else 0

    root.append(@axisLine(
      x1 : centerPosition
      x2 : centerPosition
      y2 : height
    ))

    min = @scale.min()

    i = 0
    len = ticks.length
    while i < len
      isZero = if ticks[i] == 0 then true else false

      axis = root.group().translate(centerPosition, values[i])

      axis.append(@line(
        x1 : if center then -bar else 0
        x2 : if center then bar else -bar
        stroke : @chart.theme("gridAxisBorderColor")
        "stroke-width" : @chart.theme("gridBorderWidth")
      ))

      textValue = (if @options.format then @options.format(ticks[i]) else ticks[i] + "")

      if !isZero or (isZero and !hideZero)
        axis.append(@chart.text({
          x : -bar - 4
          y : bar - 2
          "text-anchor" : "middle"
          fill : @chart.theme("gridFontColor")
        }, textValue))

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

    hideZero = @options.hideZero || false
    center = @options.center || false

