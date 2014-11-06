if typeof module isnt "undefined" and typeof module.exports isnt "undefined"
  module.exports = ChartBuilder
else
  if typeof define is "function" and define.amd
    define([], () -> ChartBuilder)
  else
    window.ChartBuilder = ChartBuilder
