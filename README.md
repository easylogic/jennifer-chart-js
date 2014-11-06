jennifer-chart-js
=================

Implements Jennifer Chart for Javascript

How to install
==============

How to use
==========

## nodejs
```javascript
var ChartBuilder = require("jennifer-chart");

var svg = new ChartBuilder({
    options...
}).render()

console.log(svg)

```

## browser
```html
<script src="jennifer-chart.js"></script>
<div id="chart"></div>
<script>
var svg = new ChartBuilder({
    options...
}).render()

document.getElementById("chart").innerHTML = svg;
</script>

```