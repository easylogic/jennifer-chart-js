###
TimeUtil Class
  add()
  format()
###
class TimeUtil
  @add : (date) ->
    if arguments.length <= 2
      return date

    if arguments.length > 2
      d = new Date(+date)

      i = 1
      while(i < arguments.length)
        split = arguments[i]
        time = arguments[i+1]

        switch split
          when "years" then d.setFullYear(d.getFullYear() + time)
          when "months" then d.setMonth(d.getMonth() + time)
          when "days" then d.setDate(d.getDate() + time)
          when "hours" then d.setHours(d.getHours() + time)
          when "minutes" then d.setMinutes(d.getMinutes() + time)
          when "seconds" then d.setSeconds(d.getSeconds() + time)
          when "milliseconds" then d.setMilliseconds(d.getMilliseconds() + time)
          when "weeks" then d.setDate(d.getDate() + time * 7)

        i += 2

      return d
  @format : (date, format, utc) ->
    # TODO: implements date format
    ""