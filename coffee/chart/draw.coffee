class Draw
  drawBefore : () ->
    console.log('aaa')

  draw : () ->
    {}
  render : () ->
    @drawBefore()
    @draw()