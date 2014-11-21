module.exports = function(grunt) {
  grunt.initConfig({
    pkg : grunt.file.readJSON("package.json"),
    watch : {
      scripts : {
        files : ['coffee/**'],
        tasks : ['default'],
        options : {
          spawn : false
        }
      }
    },
    coffee : {
      compile : {
        files : {
          './src/jennifer-chart.js' : "./coffee/jennifer-chart.coffee"
        }
      }
    },

    docco: {
        debug: {
            src: ['coffee/jennifer-chart.coffee'],
              options: {
                  output: 'docs/'
              }
          }
    },

    concat : {
      dist: {
        src: [
          // util

          "coffee/util/TimeUtil.coffee",
          "coffee/util/DomUtil.coffee",
          "coffee/util/dom/Transform.coffee",
          "coffee/util/dom/Path.coffee",
          "coffee/util/dom/Svg.coffee",
          "coffee/util/dom/Polygon.coffee",
          "coffee/util/dom/Polyline.coffee" ,
           "coffee/util/MathUtil.coffee",
           "coffee/util/ColorUtil.coffee",
           "coffee/util/scale/Scale.coffee",
           "coffee/util/scale/LinearScale.coffee",
           "coffee/util/scale/OrdinalScale.coffee",
           "coffee/util/scale/TimeScale.coffee",

           // chart (core)
           "coffee/chart/draw.coffee",
           "coffee/chart/ChartBuilder.coffee",

           // chart.theme
           "coffee/chart/theme/jennifer.coffee",
           "coffee/chart/theme/gradient.coffee", // jennifer gradient style
           "coffee/chart/theme/dark.coffee",
           "coffee/chart/theme/pastel.coffee",

           // chart.grid
           "coffee/chart/grid/Grid.coffee",
           "coffee/chart/grid/BlockGrid.coffee",
           "coffee/chart/grid/DateGrid.coffee",
           "coffee/chart/grid/RadarGrid.coffee",
           "coffee/chart/grid/RangeGrid.coffee",
           "coffee/chart/grid/RuleGrid.coffee",

           // chart.brush
           "coffee/chart/brush/Brush.coffee",
           "coffee/chart/brush/BarBrush.coffee",
           "coffee/chart/brush/BubbleBrush.coffee",
           "coffee/chart/brush/CandleStickBrush.coffee",
           "coffee/chart/brush/OhlcBrush.coffee",
           "coffee/chart/brush/ColumnBrush.coffee",
           "coffee/chart/brush/DonutBrush.coffee",
           "coffee/chart/brush/EqualizerBrush.coffee",
           "coffee/chart/brush/FullStackBrush.coffee",
           "coffee/chart/brush/LineBrush.coffee",
           "coffee/chart/brush/PathBrush.coffee",/*,,,,
           "coffee/chart/brush/pie.coffee",
           "coffee/chart/brush/scatter.coffee",
           "coffee/chart/brush/scatterpath.coffee",
           "coffee/chart/brush/stackbar.coffee",
           "coffee/chart/brush/stackcolumn.coffee",
           "coffee/chart/brush/bargauge.coffee",
           "coffee/chart/brush/circlegauge.coffee",
           "coffee/chart/brush/fillgauge.coffee",
           "coffee/chart/brush/area.coffee", // extends line
           "coffee/chart/brush/stackline.coffee", // extends line
           "coffee/chart/brush/stackarea.coffee", // extends area
           "coffee/chart/brush/stackscatter.coffee", // extends scatter
           "coffee/chart/brush/gauge.coffee", // extends donut
           "coffee/chart/brush/fullgauge.coffee", // extends donut
           "coffee/chart/brush/stackgauge.coffee", // extends donut
             */

           // chart.widget
           "coffee/chart/widget/Widget.coffee",
           "coffee/chart/widget/TitleWidget.coffee",
           "coffee/chart/widget/LegendWidget.coffee",

            "coffee/Module.coffee"
        ],
        dest: "coffee/jennifer-chart.coffee"
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-docco');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask("default", ["concat", "coffee", "docco"]);
  grunt.registerTask("compile", ["concat", "coffee"]);
};
