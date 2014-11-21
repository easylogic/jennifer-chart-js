fs = require('fs');
ChartBuilder = require("../../src/jennifer-chart");

var svg = new ChartBuilder({
    theme : "dark",
    data : [
        { quarter : "1Q", sales : 50, profit : 35 },
        { quarter : "2Q", sales : -20, profit : -30 },
        { quarter : "3Q", sales : 10, profit : -5 },
        { quarter : "4Q", sales : 30, profit : 25 }
    ],
    grid : {
        x : {
            target : "quarter"
        },
        y : [{
            type : "range",
            target : ["sales", "profit"],
            step : 10
        }]
    },
    /*
    widget : [
        {type : "title" , text : "Sample Title"}
    ]
    , */
    brush : {
        type : "line",
        target : [ "sales", "profit"]
    }
}).render()

fs.writeFileSync("./line.svg", svg);

