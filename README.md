jennifer-chart-js
=================

Implements Jennifer Chart for Javascript

How to build
=============

## use grunt
```javascript
git clone https://github.com/easylogic/jennifer-chart-js.git
cd jennifer-chart
npm install
grunt
```

## watch (to compile coffeescript on realtime)
```javascript
grunt watch
```

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