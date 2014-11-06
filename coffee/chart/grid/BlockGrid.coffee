class BlockGrid extends Grid

  points = []
  domain = []
  band = 0
  half_band = 0
  bar = 0

  constructor : (@orient, @chart, @options) ->
    super @orient, @chart, @options

  init : () ->
    @scale = new OrdinalScale()

  drawTop : (root) ->
    full_height = @chart.height()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(x2 : @chart.width() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d is "" then continue

      axis = root.group().translate(points[i], 0)

      axis.append(@line(
        x1 : -half_band
        y1 : 0
        x2 : -half_band
        y2 : if hasLine then full_height else -bar
      ))

      axis.append(@chart.text({
        x: 0,
        y: -20
        "text-anchor": "middle"
        fill: @chart.theme("gridFontColor")
      }, d ))

      i++

    if !hasFull
        axis = root.group().translate(@chart.width(), 0)
        axis.append(@line(
          y2 : if hasLine then full_height else - bar
        ))

  drawBottom : (root) ->
    full_height = @chart.height()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(x2 : @chart.width() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d is "" then continue

      axis = root.group().translate(points[i], 0)

      axis.append(@line(
        x1 : -half_band
        y1 : 0
        x2 : -half_band
        y2 : if hasLine then -full_height else bar
      ))

      axis.append(@chart.text({
        x: 0,
        y: 20
        "text-anchor": "middle"
        fill: @chart.theme("gridFontColor")
      }, d))

      i++

    if !hasFull
        axis = root.group().translate(@chart.width(), 0)
        axis.append(@line(
          y2 : if hasLine then -full_height else bar
        ))
  drawLeft : (root) ->
    full_width = @chart.width()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(y2 : @chart.height() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d is "" then continue

      axis = root.group().translate(0, points[i])

      axis.append(@line(
        x2 : if hasLine then full_width else -bar
      ))

      axis.append(@chart.text({
        x: -bar - 4 ,
        y: half_band,
        "text-anchor": "end"
        fill: @chart.theme("gridFontColor")
      }, d))

      i++

    if !hasFull
      axis = root.group().translate(0, @chart.height())
      axis.append(@line(
        y2 : if hasLine then full_width else -bar
      ))

  drawRight : (root) ->
    full_width = @chart.width()

    hasLine = @options.line || false
    hasFull = @options.full || false

    if !hasLine then root.append @axisLine(y2 : @chart.height() )

    i = 0
    len = points.length
    while i < len
      d = domain[i]

      if d is "" then continue

      axis = root.group().translate(0, points[i] - half_band)

      axis.append(@line(
        x2 : if hasLine then -full_width else bar
      ))

      axis.append(@chart.text({
        x: bar + 4 ,
        y: half_band,
        "text-anchor": "start"
        fill: @chart.theme("gridFontColor")
      }, d))

      i++

    if !hasFull
      axis = root.group().translate(0, @chart.height())
      axis.append(@line(
        y2 : if hasLine then -full_width else bar
      ))

  drawBefore : () ->
    @initDomain()

    width = @chart.width();
    height = @chart.height();
    max = (@orient == "left" || @orient == "right") ? height : width;

    @scale.domain(@options.domain);

    if (@options.full)
      @scale.rangeBands([0, max], 0, 0);
    else
      @scale.rangePoints([0,max], 0);


    points = @scale.range();
    domain = @scale.domain();
    band = @scale.rangeBand();
    half_band = if @options.full then  0 else  band / 2
    bar = 6

  initDomain : () ->
    if @options.target and !@options.domain
      domain = ( d[@options.target] for d in @chart.data())

      if @options.reverse then domain.reverse()

      @options.domain = domain
      @options.step = @options.step || 10
      @options.max = @options.max || 100

  draw : () -> @drawGrid()