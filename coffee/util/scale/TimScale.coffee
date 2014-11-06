class TimeScale extends LinearScale

  constructor : (domain ,range) ->
    super domain , range

  domain : (values) ->
    if arguments.length == 0
      super()
    else
      domain = (+value for value in values)
      super(domain)
  ticks : (type, step) ->
    start = @min()
    end = @max()

    times = while start < end
      value = new Date(+start)
      start = TimeUtil.add(start, type, step)
      value

    times.push new Date(+start)

    first = @get(times[0])
    second = @get(times[1])

    @rangeBand(second - first)
    times
  realTicks : (type, step) ->
    start = @min()
    end = @max()

    times = []
    date = new Date(+start)
    realStart = null;

    switch type
      when Time.years then realStart = new Date(date.getFullYear(), 0, 1)
      when Time.months then realStart = new Date(date.getFullYear(), date.getMonth(), 1)
      when Time.days then realStart = new Date(date.getFullYear(), date.getMonth(), date.getDate())
      when Time.weeks then realStart = new Date(date.getFullYear(), date.getMonth(), date.getDate())
      when Time.hours then realStart = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), 0, 0, 0)
      when Time.minutes then realStart = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), 0, 0)
      when Time.seconds then realStart = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds(), 0)
      when Time.milliseconds then realStart = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds())

    realStart = TimeUtil.add(realStart, type, step)

    times = while +realStart < +end
      value = new Date(+realStart)
      realStart = TimeUtil.add(realStart, type, step)
      value

    first = @get(times[1])
    second = @get(times[2])

    @rangeBand(second - first)
    times
  invert : (y) ->
    new Date(super(y))