class ColorUtil 
  @regex  : /(linear|radial)\((.*)\)(.*)/i
  @trim : (str) ->
    (str || "").replace(/^\s+|\s+$/g, '')
  @parse : (color) ->
    @parseGradient(color)
  @parseGradient : (color) ->
    matches = color.match(@regex)
    if !matches then return color
			
    type = @trim(matches[1])
    attr = @parseAttr(type, @trim(matches[2]))
    stops = @parseStop(@trim(matches[3]))

    obj = { type : type }
			
    for key, value in attr
      obj[key] = value

    obj.stops = stops
    obj
  @parseStop : (stop) ->
    stop_list = stop.split(",")
			
    stops = []

    for stop in stop_list
      arr = stop.split(" ")

      if arr.length is 0
        continue

      if arr.length is 1
        stops.push "stop-color" : arr[0]
      else if arr.length is 2
        stops.push "offset" : arr[0], "stop-color" : arr[1]
      else if arr.length is 3
        stops.push "offset" : arr[0], "stop-color" : arr[1], "stop-opacity" : arr[2]

    start = -1;
    end = -1;
    i = 0
    for stop in stops
      if i is 0
        if !stop.offset
          stop.offset = 0
      else if i is len - 1
        if !stop.offset
          stop.offset = 1

      if start == -1 and typeof stop.offset is 'undefined'
        start = i
      else if end == -1 and typeof stop.offset is 'undefined'
        end = i

      count = end - start;

      endOffset = if stops[end].offset.indexOf("%") > -1 then parseFloat(stops[end].offset)/100  else  stops[end].offset
      startOffset = if stops[start].offset.indexOf("%") > -1 then parseFloat(stops[start].offset)/100 else  stops[start].offset

      dist = endOffset - startOffset
      value = dist/ count

      offset = startOffset + value
      index = start + 1
      while index < end
        stops[index].offset = offset
        offset += value
        index++

      start = end
      end = -1
      i++

    stops

  @parseAttr : (type, str) ->
    if type is 'linear'
      switch str
        when "", "left" then return { x1 : 0, y1 : 0, x2 : 1, y2 : 0, direction : "left" }
        when "right" then return { x1 : 1, y1 : 0, x2 : 0, y2 : 0, direction : str }
        when "top" then return { x1 : 0, y1 : 0, x2 : 0, y2 : 1, direction : str }
        when "bottom" then return { x1 : 0, y1 : 1, x2 : 0, y2 : 0, direction : str }
        when "top left" then return { x1 : 0, y1 : 0, x2 : 1, y2 : 1, direction : str }
        when "top right" then return { x1 : 1, y1 : 0, x2 : 0, y2 : 1, direction : str }
        when "bottom left" then return { x1 : 0, y1 : 1, x2 : 1, y2 : 0, direction : str }
        when "bottom right" then return { x1 : 1, y1 : 1, x2 : 0, y2 : 0, direction : str }
        else
          arr = str.split(",")
          i = 0
          while i < arr.length
            if arr[i].indexOf("%") is -1
              arr[i] = parseFloat(arr[i])
            i++
          return { x1 : arr[0], y1 : arr[1],x2 : arr[2], y2 : arr[3] }
    else
      arr = str.split(",")
      i = 0
      while i < arr.length
        if arr[i].indexOf("%") is -1
          arr[i] = parseFloat(arr[i])
        i++
      return { cx : arr[0], cy : arr[1],r : arr[2], fx : arr[3], fy : arr[4] }
