ChartBuilder = require("../src/jennifer-chart").ChartBuilder;

var svg = new ChartBuilder({
    data : [
        { quarter : "1Q", sales : 50, profit : 35 },
        { quarter : "2Q", sales : -20, profit : -30 },
        { quarter : "3Q", sales : 10, profit : -5 },
        { quarter : "4Q", sales : 30, profit : 25 }
    ],
    grid : {
        y : {
            target : "quarter",
            line : true
        },
        x : {
            type : "range",
            target : ["sales", "profit"],
            step : 10,
            line : true
        }
    }/*,
    brush : {
        type : "bar",
        target : [ "sales", "profit"]
    }*/
}).render()

console.log(svg)

