
/*
TimeUtil Class
  add()
  format()
 */

(function() {
  var BlockGrid, ChartBuilder, ColorUtil, DarkTheme, DateGrid, DomUtil, Draw, GradientTheme, Grid, JenniferTheme, LinearScale, MathUtil, OrdinalScale, PastelTheme, Path, Polygon, Polyline, RangeGrid, RuleGrid, Scale, Svg, TimeUtil, Transform, el, extend,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  TimeUtil = (function() {
    function TimeUtil() {}

    TimeUtil.add = function(date) {
      var d, i, split, time;
      if (arguments.length <= 2) {
        return date;
      }
      if (arguments.length > 2) {
        d = new Date(+date);
        i = 1;
        while (i < arguments.length) {
          split = arguments[i];
          time = arguments[i + 1];
          switch (split) {
            case "years":
              d.setFullYear(d.getFullYear() + time);
              break;
            case "months":
              d.setMonth(d.getMonth() + time);
              break;
            case "days":
              d.setDate(d.getDate() + time);
              break;
            case "hours":
              d.setHours(d.getHours() + time);
              break;
            case "minutes":
              d.setMinutes(d.getMinutes() + time);
              break;
            case "seconds":
              d.setSeconds(d.getSeconds() + time);
              break;
            case "milliseconds":
              d.setMilliseconds(d.getMilliseconds() + time);
              break;
            case "weeks":
              d.setDate(d.getDate() + time * 7);
          }
          i += 2;
        }
        return d;
      }
    };

    TimeUtil.format = function(date, format, utc) {
      return "";
    };

    return TimeUtil;

  })();

  DomUtil = (function() {
    DomUtil.el = function(tagName, attr) {
      return new Transform(tagName, attr);
    };

    function DomUtil(tagName, attrs) {
      this.tagName = tagName != null ? tagName : "g";
      this.attrs = attrs != null ? attrs : {};
      this.children = [];
      this.styles = [];
      this.text = "";
      this.init();
    }

    DomUtil.prototype.init = function() {};

    DomUtil.prototype.put = function(key, value) {
      this.attrs[key] = value;
      return this;
    };

    DomUtil.prototype.get = function(key) {
      return this.attrs[key];
    };

    DomUtil.prototype.css = function(key, value) {
      if (typeof value === !void 0) {
        this.styles[key] = value;
        return this;
      } else {
        return this.styles[key];
      }
    };

    DomUtil.prototype.append = function(dom) {
      this.children.push(dom);
      return dom;
    };

    DomUtil.prototype.textNode = function(text) {
      this.text = text;
      return this;
    };

    DomUtil.prototype.collapseStyle = function() {
      var key, str, value;
      str = (function() {
        var _ref, _results;
        _ref = this.styles;
        _results = [];
        for (key in _ref) {
          value = _ref[key];
          _results.push("" + key + ":" + value);
        }
        return _results;
      }).call(this);
      return str.join(";");
    };

    DomUtil.prototype.collapseAttr = function() {
      var key, str, style, value;
      style = this.collapseStyle();
      if (this.attrs.style) {
        this.attrs.style += ";" + style;
      }
      str = (function() {
        var _ref, _results;
        _ref = this.attrs;
        _results = [];
        for (key in _ref) {
          value = _ref[key];
          _results.push("" + key + "=\"" + value + "\"");
        }
        return _results;
      }).call(this);
      return str.join(" ");
    };

    DomUtil.prototype.collapseChildren = function() {
      var dom, str;
      str = (function() {
        var _i, _len, _ref, _results;
        _ref = this.children;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dom = _ref[_i];
          _results.push("" + (dom.render()));
        }
        return _results;
      }).call(this);
      return str.join("\n");
    };

    DomUtil.prototype.render = function() {
      var ret;
      ret = ["<" + this.tagName + " " + (this.collapseAttr())];
      if (this.children.length === 0) {
        if (this.text === "") {
          ret.push(" />");
        } else {
          ret.push(">" + this.text + "</" + this.tagName + ">");
        }
      } else {
        ret.push(">\n" + (this.collapseChildren()) + this.text + "\n</" + this.tagName + ">");
      }
      return ret.join("");
    };

    DomUtil.prototype.toString = function() {
      return this.render();
    };

    DomUtil.prototype.defs = function(attr) {
      return this.append(el("defs", attr));
    };

    DomUtil.prototype.marker = function(attr) {
      return this.append(el("marker", attr));
    };

    DomUtil.prototype.symbol = function(attr) {
      return this.append(el("symbol", attr));
    };

    DomUtil.prototype.clipPath = function(attr) {
      return this.append(el("clip-path", attr));
    };

    DomUtil.prototype.g = function(attr) {
      return this.append(el("g", attr));
    };

    DomUtil.prototype.group = function(attr) {
      return this.g(attr);
    };

    DomUtil.prototype.rect = function(attr) {
      return this.append(el("rect", attr));
    };

    DomUtil.prototype.line = function(attr) {
      return this.append(el("line", attr));
    };

    DomUtil.prototype.circle = function(attr) {
      return this.append(el("circle", attr));
    };

    DomUtil.prototype.text = function(attr) {
      return this.append(el("text", attr));
    };

    DomUtil.prototype.tspan = function(attr) {
      return this.append(el("tspan", attr));
    };

    DomUtil.prototype.ellipse = function(attr) {
      return this.append(el("ellipse", attr));
    };

    DomUtil.prototype.image = function(attr) {
      return this.append(el("image", attr));
    };

    DomUtil.prototype.path = function(attr) {
      return this.append(new Path(attr));
    };

    DomUtil.prototype.polygon = function(attr) {
      return this.append(new Polygon(attr));
    };

    DomUtil.prototype.polyline = function(attr) {
      return this.append(new Polyline(attr));
    };

    DomUtil.prototype.radialGradient = function(attr) {
      return this.append(el("radialGradient", attr));
    };

    DomUtil.prototype.linearGradient = function(attr) {
      return this.append(el("linearGradient", attr));
    };

    DomUtil.prototype.mask = function(attr) {
      return this.append(el("mask", attr));
    };

    DomUtil.prototype.pattern = function(attr) {
      return this.append(el("pattern", attr));
    };

    DomUtil.prototype.stop = function(attr) {
      return this.append(el("stop", attr));
    };

    DomUtil.prototype.animate = function(attr) {
      return this.append(el("animate", attr));
    };

    DomUtil.prototype.animateColor = function(attr) {
      return this.append(el("animateColor", attr));
    };

    DomUtil.prototype.animateMotion = function(attr) {
      return this.append(el("animateMotion", attr));
    };

    DomUtil.prototype.animateTransform = function(attr) {
      return this.append(el("animateTransform", attr));
    };

    DomUtil.prototype.mpath = function(attr) {
      return this.append(el("mpath", attr));
    };

    DomUtil.prototype.set = function(attr) {
      return this.append(el("set", attr));
    };

    DomUtil.prototype.attr = function(o) {
      var key, value;
      if (o == null) {
        o = {};
      }
      for (key in o) {
        value = o[key];
        this.attrs[key] = value;
      }
      return this;
    };

    DomUtil.prototype.addClass = function(s) {
      var key, list, listEx, result, ret, str, value, _i, _j, _len, _len1;
      list = this.attrs['class'].split(" ");
      listEx = s.split("");
      result = {};
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        str = list[_i];
        result[str] = true;
      }
      for (_j = 0, _len1 = listEx.length; _j < _len1; _j++) {
        str = listEx[_j];
        result[str] = true;
      }
      ret = (function() {
        var _results;
        _results = [];
        for (key in result) {
          value = result[key];
          _results.push(key);
        }
        return _results;
      })();
      return this.put("class", ret.join(" "));
    };

    DomUtil.prototype.removeClass = function(s) {
      var key, list, listEx, result, ret, str, value, _i, _j, _len, _len1;
      list = this.attrs['class'].split(" ");
      listEx = s.split("");
      result = {};
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        str = list[_i];
        result[str] = true;
      }
      for (_j = 0, _len1 = listEx.length; _j < _len1; _j++) {
        str = listEx[_j];
        result[str] = false;
      }
      ret = ((function() {
        var _results;
        if (value) {
          _results = [];
          for (key in result) {
            value = result[key];
            _results.push(key);
          }
          return _results;
        }
      })());
      return this.put("class", ret.join(" "));
    };

    DomUtil.prototype.hasClass = function(s) {
      var list, str, _i, _len;
      list = this.attrs['class'].split(" ");
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        str = list[_i];
        if (str === s) {
          return true;
        }
      }
      return false;
    };

    return DomUtil;

  })();

  el = function() {
    return DomUtil.el.apply(null, arguments);
  };

  Transform = (function(_super) {
    __extends(Transform, _super);

    function Transform() {
      return Transform.__super__.constructor.apply(this, arguments);
    }

    Transform.prototype.orders = {};

    Transform.prototype.translate = function(x, y) {
      this.orders.translate = [x, y].join(" ");
      return this;
    };

    Transform.prototype.rotate = function(angle, x, y) {
      this.orders.rotate = [angle, x, y].join(" ");
      return this;
    };

    Transform.prototype.render = function() {
      var key, list, value;
      list = (function() {
        var _ref, _results;
        _ref = this.orders;
        _results = [];
        for (key in _ref) {
          value = _ref[key];
          _results.push("" + key + "(" + value + ")");
        }
        return _results;
      }).call(this);
      this.put("transform", list.join(" "));
      return Transform.__super__.render.call(this);
    };

    return Transform;

  })(DomUtil);

  Path = (function(_super) {
    __extends(Path, _super);

    Path.prototype.paths = [];

    function Path(attr) {
      Path.__super__.constructor.call(this, "path", attr);
    }

    Path.prototype.moveTo = function(x, y) {
      this.paths.push("m" + x + "," + y);
      return this;
    };

    Path.prototype.MoveTo = function(x, y) {
      this.paths.push("M" + x + "," + y);
      return this;
    };

    Path.prototype.lineTo = function(x, y) {
      this.paths.push("l" + x + "," + y);
      return this;
    };

    Path.prototype.LineTo = function(x, y) {
      this.paths.push("L" + x + "," + y);
      return this;
    };

    Path.prototype.hLineTo = function(x) {
      this.paths.push("h" + x);
      return this;
    };

    Path.prototype.HLineTo = function(x) {
      this.paths.push("h" + x);
      return this;
    };

    Path.prototype.vLineTo = function(x, y) {
      this.paths.push("v" + x);
      return this;
    };

    Path.prototype.VLineTo = function(x, y) {
      this.paths.push("V" + x);
      return this;
    };

    Path.prototype.curveTo = function(x1, y1, x2, y2, x, y) {
      this.paths.push("c" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x + "," + y);
      return this;
    };

    Path.prototype.CurveTo = function(x1, y1, x2, y2, x, y) {
      this.paths.push("C" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x + "," + y);
      return this;
    };

    Path.prototype.sCurveTo = function(x2, y2, x, y) {
      this.paths.push("s" + x2 + "," + y2 + " " + x + "," + y);
      return this;
    };

    Path.prototype.SCurveTo = function(x2, y2, x, y) {
      this.paths.push("s" + x2 + "," + y2 + " " + x + "," + y);
      return this;
    };

    Path.prototype.qCurveTo = function(x1, y1, x, y) {
      this.paths.push("q" + x1 + "," + y1 + " " + x + "," + y);
      return this;
    };

    Path.prototype.QCurveTo = function(x1, y1, x, y) {
      this.paths.push("Q" + x1 + "," + y1 + " " + x + "," + y);
      return this;
    };

    Path.prototype.tCurveTo = function(x1, y1, x, y) {
      this.paths.push("t" + x1 + "," + y1 + " " + x + "," + y);
      return this;
    };

    Path.prototype.TCurveTo = function(x1, y1, x, y) {
      this.paths.push("T" + x1 + "," + y1 + " " + x + "," + y);
      return this;
    };

    Path.prototype.arc = function(rx, ry, x_axis_rotation, large_arc_flag, sweep_flag, x, y) {
      this.paths.push("a" + rx + "," + ry + " " + x_axis_rotation + " " + large_arc_flag + "," + sweep_flag + " " + x + "," + y);
      return this;
    };

    Path.prototype.Arc = function(rx, ry, x_axis_rotation, large_arc_flag, sweep_flag, x, y) {
      this.paths.push("A" + rx + "," + ry + " " + x_axis_rotation + " " + large_arc_flag + "," + sweep_flag + " " + x + "," + y);
      return this;
    };

    Path.prototype.close = function() {
      this.paths.push("z");
      return this;
    };

    Path.prototype.Close = function() {
      this.paths.push("Z");
      return this;
    };

    Path.prototype.triangle = function(cx, cy, width, height) {
      return this.MoveTo(cx, cy).moveTo(0, -height / 2).lineTo(width / 2, height).lineTo(-width, 0).lineTo(width / 2, -height);
    };

    Path.prototype.rect = function(cx, cy, width, height) {
      return this.MoveTo(cx, cy).moveTo(-width / 2, -height / 2).lineTo(width, 0).lineTo(0, height).lineTo(-width, 0).lineTo(0, -height);
    };

    Path.prototype.rectangle = function(cx, cy, width, height) {
      return this.rect(cx, cy, width, height);
    };

    Path.prototype.cross = function(cx, cy, width, height) {
      return this.MoveTo(cx, cy).moveTo(-width / 2, -height / 2).lineTo(width, height).moveTo(0, -height).lineTo(-width, height);
    };

    Path.prototype.circle = function(cx, cy, r) {
      return this.MoveTo(cx, cy).moveTo(-r, 0).arc(r, r, 0, 1, 1, r * 2, 0).arc(r, r, 0, 1, 1, -(r * 2), 0);
    };

    Path.prototype.render = function() {
      this.put("d", this.paths.join(" "));
      return Path.__super__.render.call(this);
    };

    return Path;

  })(Transform);

  Svg = (function(_super) {
    __extends(Svg, _super);

    function Svg(attr) {
      Svg.__super__.constructor.call(this, "svg", attr);
    }

    Svg.prototype.init = function() {
      return this.put("xmlns", "http://www.w3.org/2000/svg");
    };

    Svg.prototype.toXml = function() {
      return "<?xml version='1.1' encoding='utf-8' ?>\r\n<!DOCTYPE svg>\r\n" + this.toString();
    };

    return Svg;

  })(DomUtil);

  Polygon = (function(_super) {
    __extends(Polygon, _super);

    Polygon.prototype.points = [];

    function Polygon(attr) {
      Polygon.__super__.constructor.call(this, "polygon", attr);
    }

    Polygon.prototype.point = function(x, y) {
      this.points.push([x, y].join(","));
      return this;
    };

    Polygon.prototype.toString = function() {
      this.put("points", this.points.join("-"));
      return Polygon.__super__.toString.call(this);
    };

    return Polygon;

  })(Transform);

  Polyline = (function(_super) {
    __extends(Polyline, _super);

    Polyline.prototype.points = [];

    function Polyline(attr) {
      Polyline.__super__.constructor.call(this, "polyline", attr);
    }

    Polyline.prototype.point = function(x, y) {
      this.points.push([x, y].join(","));
      return this;
    };

    Polyline.prototype.render = function() {
      this.put("points", this.points.join("-"));
      return Polyline.__super__.render.call(this);
    };

    return Polyline;

  })(Transform);

  MathUtil = (function() {
    function MathUtil() {}

    MathUtil.rotate = function(x, y, radian) {
      return {
        x: x * Math.cos(radian) - y * Math.sin(radian),
        y: x * Math.sin(radian) + y * Math.cos(radian)
      };
    };

    MathUtil.radian = function(degree) {
      return degree * Math.PI / 180;
    };

    MathUtil.degree = function(radian) {
      return radian * 180 / Math.PI;
    };

    MathUtil.interpolateNumber = function(a, b) {
      return function(t) {
        return a + (b - a) * t;
      };
    };

    MathUtil.interpolateRound = function(a, b) {
      var f;
      f = MathUtil.interpolateNumber(a, b);
      return function(t) {
        return Math.round(f(t));
      };
    };

    MathUtil.niceNum = function(range, round) {
      var exponent, fraction, niceFraction;
      exponent = Math.floor(Math.log(range) / Math.LN10);
      fraction = range / Math.pow(10, exponent);
      if (round) {
        if (fraction < 1.5) {
          niceFraction = 1;
        } else if (fraction < 3) {
          niceFraction = 2;
        } else if (fraction < 7) {
          niceFraction = 5;
        } else {
          niceFraction = 10;
        }
      } else {
        if (fraction <= 1) {
          niceFraction = 1;
        } else if (fraction <= 2) {
          niceFraction = 2;
        } else if (fraction <= 5) {
          niceFraction = 5;
        } else {
          niceFraction = 10;
        }
      }
      return niceFraction * Math.pow(10, exponent);
    };

    MathUtil.nice = function(min, max, ticks, isNice) {
      var _max, _min, _niceMax, _niceMin, _range, _tickSpacing, _ticks;
      isNice = isNice ? isNice : false;
      if (min > max) {
        _max = min;
        _min = max;
      } else {
        _min = min;
        _max = max;
      }
      _ticks = ticks;
      _tickSpacing = 0;
      _niceMin;
      _niceMax;
      _range = isNice ? this.niceNum(_max - _min, false) : _max - _min;
      _tickSpacing = isNice ? this.niceNum(_range / _ticks, true) : _range / _ticks;
      _niceMin = isNice ? Math.floor(_min / _tickSpacing) * _tickSpacing : _min;
      _niceMax = isNice ? Math.floor(_max / _tickSpacing) * _tickSpacing : _max;
      return {
        min: _niceMin,
        max: _niceMax,
        range: _range,
        spacing: _tickSpacing
      };
    };

    return MathUtil;

  })();

  ColorUtil = (function() {
    function ColorUtil() {}

    ColorUtil.regex = /(linear|radial)\((.*)\)(.*)/i;

    ColorUtil.trim = function(str) {
      return (str || "").replace(/^\s+|\s+$/g, '');
    };

    ColorUtil.parse = function(color) {
      return this.parseGradient(color);
    };

    ColorUtil.parseGradient = function(color) {
      var attr, key, matches, obj, stops, type, value, _i, _len;
      matches = color.match(this.regex);
      if (!matches) {
        return color;
      }
      type = this.trim(matches[1]);
      attr = this.parseAttr(type, this.trim(matches[2]));
      stops = this.parseStop(this.trim(matches[3]));
      obj = {
        type: type
      };
      for (value = _i = 0, _len = attr.length; _i < _len; value = ++_i) {
        key = attr[value];
        obj[key] = value;
      }
      obj.stops = stops;
      return obj;
    };

    ColorUtil.parseStop = function(stop) {
      var arr, count, dist, end, endOffset, i, index, offset, start, startOffset, stop_list, stops, value, _i, _j, _len, _len1;
      stop_list = stop.split(",");
      stops = [];
      for (_i = 0, _len = stop_list.length; _i < _len; _i++) {
        stop = stop_list[_i];
        arr = stop.split(" ");
        if (arr.length === 0) {
          continue;
        }
        if (arr.length === 1) {
          stops.push({
            "stop-color": arr[0]
          });
        } else if (arr.length === 2) {
          stops.push({
            "offset": arr[0],
            "stop-color": arr[1]
          });
        } else if (arr.length === 3) {
          stops.push({
            "offset": arr[0],
            "stop-color": arr[1],
            "stop-opacity": arr[2]
          });
        }
      }
      start = -1;
      end = -1;
      i = 0;
      for (_j = 0, _len1 = stops.length; _j < _len1; _j++) {
        stop = stops[_j];
        if (i === 0) {
          if (!stop.offset) {
            stop.offset = 0;
          }
        } else if (i === len - 1) {
          if (!stop.offset) {
            stop.offset = 1;
          }
        }
        if (start === -1 && typeof stop.offset === 'undefined') {
          start = i;
        } else if (end === -1 && typeof stop.offset === 'undefined') {
          end = i;
        }
        count = end - start;
        endOffset = stops[end].offset.indexOf("%") > -1 ? parseFloat(stops[end].offset) / 100 : stops[end].offset;
        startOffset = stops[start].offset.indexOf("%") > -1 ? parseFloat(stops[start].offset) / 100 : stops[start].offset;
        dist = endOffset - startOffset;
        value = dist / count;
        offset = startOffset + value;
        index = start + 1;
        while (index < end) {
          stops[index].offset = offset;
          offset += value;
          index++;
        }
        start = end;
        end = -1;
        i++;
      }
      return stops;
    };

    ColorUtil.parseAttr = function(type, str) {
      var arr, i;
      if (type === 'linear') {
        switch (str) {
          case "":
          case "left":
            return {
              x1: 0,
              y1: 0,
              x2: 1,
              y2: 0,
              direction: "left"
            };
          case "right":
            return {
              x1: 1,
              y1: 0,
              x2: 0,
              y2: 0,
              direction: str
            };
          case "top":
            return {
              x1: 0,
              y1: 0,
              x2: 0,
              y2: 1,
              direction: str
            };
          case "bottom":
            return {
              x1: 0,
              y1: 1,
              x2: 0,
              y2: 0,
              direction: str
            };
          case "top left":
            return {
              x1: 0,
              y1: 0,
              x2: 1,
              y2: 1,
              direction: str
            };
          case "top right":
            return {
              x1: 1,
              y1: 0,
              x2: 0,
              y2: 1,
              direction: str
            };
          case "bottom left":
            return {
              x1: 0,
              y1: 1,
              x2: 1,
              y2: 0,
              direction: str
            };
          case "bottom right":
            return {
              x1: 1,
              y1: 1,
              x2: 0,
              y2: 0,
              direction: str
            };
          default:
            arr = str.split(",");
            i = 0;
            while (i < arr.length) {
              if (arr[i].indexOf("%") === -1) {
                arr[i] = parseFloat(arr[i]);
              }
              i++;
            }
            return {
              x1: arr[0],
              y1: arr[1],
              x2: arr[2],
              y2: arr[3]
            };
        }
      } else {
        arr = str.split(",");
        i = 0;
        while (i < arr.length) {
          if (arr[i].indexOf("%") === -1) {
            arr[i] = parseFloat(arr[i]);
          }
          i++;
        }
        return {
          cx: arr[0],
          cy: arr[1],
          r: arr[2],
          fx: arr[3],
          fy: arr[4]
        };
      }
    };

    return ColorUtil;

  })();

  Scale = (function() {
    var _clamp, _domain, _isRound, _key, _range, _rangeBand;

    _rangeBand = 0;

    _isRound = false;

    _clamp = false;

    _domain = [];

    _range = [];

    _key = "";

    function Scale(domain, range) {
      _domain = domain;
      _range = range;
      this.init();
    }

    Scale.prototype.init = function() {};

    Scale.prototype.clamp = function(clamp) {
      if (arguments.length === 0) {
        return _clamp;
      } else {
        _clamp = clamp;
        return this;
      }
    };

    Scale.prototype.get = function(x) {
      return 0;
    };

    Scale.prototype.max = function() {
      return Math.max(_domain[0], _domain[_domain.length - 1]);
    };

    Scale.prototype.min = function() {
      return Math.min(_domain[0], _domain[_domain.length - 1]);
    };

    Scale.prototype.rangeBand = function(band) {
      if (arguments.length === 0) {
        return _rangeBand;
      } else {
        _rangeBand = band;
        return this;
      }
    };

    Scale.prototype.rate = function(value, max) {
      return this.get(this.max() * (value / max));
    };

    Scale.prototype.invert = function(y) {
      return 0;
    };

    Scale.prototype.domain = function(values) {
      var value;
      if (arguments.length === 0) {
        return _domain;
      } else {
        _domain = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = values.length; _i < _len; _i++) {
            value = values[_i];
            _results.push(value);
          }
          return _results;
        })();
        return this;
      }
    };

    Scale.prototype.range = function(values) {
      var value;
      if (arguments.length === 0) {
        return _range;
      } else {
        _range = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = values.length; _i < _len; _i++) {
            value = values[_i];
            _results.push(value);
          }
          return _results;
        })();
        return this;
      }
    };

    Scale.prototype.round = function() {
      return _isRound;
    };

    Scale.prototype.rangeRound = function(values) {
      _isRound = true;
      return this.range(values);
    };

    return Scale;

  })();

  LinearScale = (function(_super) {
    __extends(LinearScale, _super);

    function LinearScale(domain, range) {
      LinearScale.__super__.constructor.call(this, domain || [0, 1], range || [0, 1]);
    }

    LinearScale.prototype.get = function(x) {
      var distFirst, distLast, distRFirst, distRLast, first, first2, i, index, last, last2, len, max, maxR, min, minR, pos, rfirst, rfirst2, rlast, rlast2, scale, _domain, _range;
      index = -1;
      _domain = this.domain();
      _range = this.range();
      i = 0;
      len = _domain.length;
      while (i < len) {
        if (i === len - 1) {
          if (x === _domain[i]) {
            index = i;
            break;
          }
        } else {
          if (_domain[i] < _domain[i + 1]) {
            if (x >= _domain[i] && x < _domain[i + 1]) {
              index = i;
              break;
            }
          } else if (_domain[i] >= _domain[i + 1]) {
            if (x <= _domain[i] && _domain[i + 1] < x) {
              index = i;
              break;
            }
          }
        }
        i++;
      }
      if (!_range) {
        if (index === 0) {
          return 0;
        } else if (index === -1) {
          return 1;
        } else {
          min = _domain[index - 1];
          max = _domain[index];
          pos = (x - min) / (max - min);
          return pos;
        }
      } else {
        if (_domain.length - 1 === index) {
          return _range[index];
        } else if (index === -1) {
          max = this.max();
          min = this.min();
          if (max < x) {
            if (this.clamp()) {
              return max;
            }
            last = _domain[_domain.length(-1)];
            last2 = _domain[_domain.length(-2)];
            rlast = _range[_range.length(-1)];
            rlast2 = _range[_range.length(-2)];
            distLast = Math.abs(last - last2);
            distRLast = Math.abs(rlast - rlast2);
            return rlast + Math.abs(x - max) * distRLast / distLast;
          } else if (min > x) {
            if (this.clamp()) {
              return min;
            }
            first = _domain[0];
            first2 = _domain[1];
            rfirst = _range[0];
            rfirst2 = _range[1];
            distFirst = Math.abs(first - first2);
            distRFirst = Math.abs(rfirst - rfirst2);
            return rfirst - Math.abs(x - min) * distRFirst / distFirst;
          }
          return _range[_range.length - 1];
        } else {
          min = _domain[index];
          max = _domain[index + 1];
          minR = _range[index];
          maxR = _range[index + 1];
          pos = (x - min) / (max - min);
          scale = this.round() ? MathUtil.interpolateRound(minR, maxR) : MathUtil.interpolateNumber(minR, maxR);
          return scale(pos);
        }
      }
    };

    LinearScale.prototype.invert = function(y) {
      return new LinearScale(this.range(), this.domain()).get(y);
    };

    LinearScale.prototype.ticks = function(count, isNice, intNumber) {
      var arr, end, obj, start, value, _domain;
      intNumber = intNumber || 10000;
      _domain = this.domain();
      if (_domain[0] === 0 && _domain[1] === 0) {
        return [];
      }
      obj = MathUtil.nice(_domain[0], _domain[1], count || 10, isNice || false);
      arr = [];
      start = obj.min * intNumber;
      end = obj.max * intNumber;
      arr = (function() {
        var _results;
        _results = [];
        while (start <= end) {
          value = start / intNumber;
          start += obj.spacing * intNumber;
          _results.push(value);
        }
        return _results;
      })();
      if (arr[arr.length - 1] * intNumber !== end && start > end) {
        arr.push(end / intNumber);
      }
      return arr;
    };

    return LinearScale;

  })(Scale);

  OrdinalScale = (function(_super) {
    __extends(OrdinalScale, _super);

    function OrdinalScale(domain, range) {
      OrdinalScale.__super__.constructor.call(this, domain || [0, 1], range || [0, 1]);
    }

    OrdinalScale.prototype.get = function(x) {
      var i, index, len, _domain;
      _domain = this.domain();
      index = -1;
      i = 0;
      len = _domain.length;
      while (i < len) {
        if (_domain[i] === x) {
          index = i;
          break;
        }
        i++;
      }
      if (index > -1) {
        return _range[index];
      } else {
        if (_range[x]) {
          _domain[x] = x;
          return _range[x];
        }
      }
      return null;
    };

    OrdinalScale.prototype.rangePoints = function(interval, padding) {
      var i, len, range, step, unit, _domain;
      _domain = this.domain();
      padding = padding || 0;
      step = _domain.length;
      unit = (interval[1] - interval[0] - padding) / step;
      range = [];
      i = 0;
      len = _domain.length;
      while (i < len) {
        if (i === 0) {
          range[i] = interval[0] + padding / 2 + unit / 2;
        } else {
          range[i] = range[i - 1] + unit;
        }
        i++;
      }
      this.range(range);
      this.rangeBand(unit);
      return this;
    };

    OrdinalScale.prototype.rangeBands = function(interval, padding, outerPadding) {
      var band, count, i, range, step, _domain;
      _domain = this.domain();
      padding = padding || 0;
      outerPadding = outerPadding || 0;
      count = _domain.length;
      step = count - 1;
      band = (interval[1] - interval[0]) / step;
      range = [];
      i = 0;
      while (i < count) {
        if (i === 0) {
          range[i] = interval[0];
        } else {
          range[i] = band + range[i - 1];
        }
        i++;
      }
      this.rangeBand(band);
      this.range(range);
      return this;
    };

    return OrdinalScale;

  })(Scale);

  Draw = (function() {
    function Draw() {}

    Draw.prototype.drawBefore = function() {
      return console.log('aaa');
    };

    Draw.prototype.draw = function() {
      return {};
    };

    Draw.prototype.render = function() {
      this.drawBefore();
      return this.draw();
    };

    return Draw;

  })();

  extend = function(object, properties) {
    var key, val;
    for (key in properties) {
      val = properties[key];
      object[key] = val;
    }
    return object;
  };

  ChartBuilder = (function(_super) {
    var brushes, clipId, deepClone, defs, grids, root, svg, themeList, widgets, _area, _brush, _data, _grid, _hash, _options, _padding, _scales, _series, _theme, _widget, _widget_objects;

    __extends(ChartBuilder, _super);

    _area = {};

    _data = [];

    _grid = {};

    _brush = [];

    _widget = [];

    _series = [];

    _scales = [];

    _hash = {};

    _widget_objects = [];

    _padding = {};

    _options = {};

    _theme = {};

    svg = {};

    defs = {};

    clipId = "";

    root = {};

    themeList = {};

    grids = {};

    widgets = {};

    brushes = {};

    deepClone = function(obj) {
      var key, o, val, value;
      if (obj == null) {
        obj = {};
      }
      value = '';
      if (obj instanceof Array) {
        value = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = obj.length; _i < _len; _i++) {
            o = obj[_i];
            _results.push(deepClone(o));
          }
          return _results;
        })();
      } else if (obj instanceof Date) {
        value = obj;
      } else if (typeof obj === "object") {
        value = {};
        for (key in obj) {
          val = obj[key];
          value[key] = deepClone(val);
        }
      } else {
        value = obj;
      }
      return value;
    };

    function ChartBuilder(o) {
      _options = o;
      this.initPadding();
      this.initTheme();
      this.initGrid();
      this.initBrush();
      this.initWidget();
      this.initSvg();
      this.setTheme(o.theme || "jennifer");
      if (_options.style) {
        this.setTheme(_options.style);
      }
    }

    ChartBuilder.prototype.initSvg = function() {
      this.svg = new Svg({
        width: _options.width || 400,
        height: _options.height || 400
      });
      return this.root = this.svg.g().translate(0.5, 0.5);
    };

    ChartBuilder.prototype.initWidget = function() {

      /*
      addWidget "title", TitleWidget
      addWidget "legend", LegendWidget
       */
    };

    ChartBuilder.prototype.initBrush = function() {

      /*
      @addBrush "area", AreaBrush
      @addBrush "bar", BarBrush
      @addBrush "bargauge", BarGaugeBrush
      @addBrush "bubble", BubbleBrush
      @addBrush "candlestick", CandleStickBrush
      @addBrush "circlegauge", CircleGaugeBrush
      @addBrush "column", ColumnBrush
      @addBrush "donut", DonutBrush
      @addBrush "equalizer", EqualizerBrush
      @addBrush "fillgauge", FillGaugeBrush
      @addBrush "fullgauge", FullGaugeBrush
      @addBrush "fullstack", FullStackBrush
      @addBrush "gauge", GagueBrush
      @addBrush "line", LineBrush
      @addBrush "ohlc", OhlcBrush
      @addBrush "path", PathBrush
      @addBrush "pie",  PieBrush
      @addBrush "scatter", ScatterBrush
      @addBrush "scatterpath", ScatterPathBrush
      @addBrush "stackarea", StackAreaBrush
      @addBrush "stackbar", StackBarBrush
      @addBrush "stackcolumn", StackColumnBrush
      @addBrush "stackgauge", StackGagueBrush
      @addBrush "stackline", StackLineBrush
      @addBrush "stackscatter", StackScatterBrush
       */
    };

    ChartBuilder.prototype.initGrid = function() {
      this.addGrid("block", BlockGrid);
      this.addGrid("range", RangeGrid);
      this.addGrid("date", DateGrid);
      return this.addGrid("rule", RuleGrid);
    };

    ChartBuilder.prototype.initTheme = function() {
      this.addTheme("jennifer", JenniferTheme);
      this.addTheme("dark", DarkTheme);
      this.addTheme("gradient", GradientTheme);
      return this.addTheme("pastel", PastelTheme);
    };

    ChartBuilder.prototype.addBrush = function(key, BrushClass) {
      return brushes[key] = BrushClass;
    };

    ChartBuilder.prototype.addWidget = function(key, WidgetClass) {
      return widgets[key] = WidgetClass;
    };

    ChartBuilder.prototype.addGrid = function(key, GridClass) {
      return grids[key] = GridClass;
    };

    ChartBuilder.prototype.addTheme = function(key, ThemeClass) {
      return themeList[key] = ThemeClass;
    };

    ChartBuilder.prototype.initPadding = function() {
      if (typeof _options.padding === 'undefined') {
        return _padding = {
          left: 50,
          right: 50,
          top: 50,
          bottom: 50
        };
      } else {
        if (_options.padding === 'empty') {
          return _padding = {
            left: 0,
            right: 0,
            top: 0,
            bottom: 0
          };
        } else {
          return _padding = _options.padding;
        }
      }
    };

    ChartBuilder.prototype.drawBefore = function() {
      var brush, data, grid, key, obj, row, series, series_list, value, widget, _i, _len;
      series = deepClone(_options.series);
      grid = deepClone(_options.grid);
      brush = deepClone(_options.brush);
      widget = deepClone(_options.widget);
      data = deepClone(_options.data);
      series_list = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        row = data[_i];
        for (key in row) {
          value = row[key];
          obj = series[key] || {};
          if (typeof value === "string") {
            continue;
          }
          value = +value;
          series[key] = obj;
          obj.data = obj.data || [];
          obj.min = typeof obj.min === 'undefined' ? 0 : obj.min;
          obj.max = typeof obj.max === 'undefined' ? 0 : obj.max;
          obj.data.push(value);
          if (value < obj.min) {
            obj.min = value;
          }
          if (value > obj.max) {
            obj.max = value;
          }
        }
      }
      series_list = (function() {
        var _results;
        _results = [];
        for (key in series) {
          value = series[key];
          _results.push(key);
        }
        return _results;
      })();
      _brush = this.createBrushData(brush, series_list);
      _widget = this.createBrushData(widget, series_list);
      _series = series;
      _grid = grid;
      _data = data;
      return _hash = {};
    };

    ChartBuilder.prototype.createBrushData = function(draws, series_list) {
      var b, result, _i, _len;
      result = null;
      if (draws) {
        if (typeof draws === 'string') {
          result = [
            {
              type: draws
            }
          ];
        } else if (typeof draws === 'object' && !draws.length) {
          result = [draws];
        } else {
          result = draws;
        }
        for (_i = 0, _len = result.length; _i < _len; _i++) {
          b = result[_i];
          if (!b.target) {
            b.target = series_list;
          } else if (typeof b.target === 'string') {
            b.target = [b.target];
          }
        }
      }
      return result;
    };

    ChartBuilder.prototype.caculate = function() {
      _area = {
        width: (_options.width || 400) - (_padding.left + _padding.right),
        height: (_options.height || 400) - (_padding.top + _padding.bottom),
        x: _padding.left,
        y: _padding.top
      };
      _area.x2 = _area.x + _area.width;
      return _area.y2 = _area.y + _area.height;
    };

    ChartBuilder.prototype.drawDefs = function() {
      var clip;
      defs = this.svg.defs();
      this.clipId = this.createId('clip-id');
      clip = defs.clipPath({
        id: this.clipId
      });
      clip.rect({
        x: 0,
        y: 0,
        width: this.width(),
        height: this.height()
      });
      return this.defs = defs;
    };

    ChartBuilder.prototype.drawObject = function(type) {
      var Obj, drawObj, draws, i, len, obj, result, _results;
      draws = type === "brush" ? _brush : _widget;
      if (draws) {
        i = 0;
        len = draws.length;
        _results = [];
        while (i < len) {
          obj = draws[i];
          Obj = type === "brush" ? brushes[obj.type] : widgets[obj.type];
          drawObj = type === "widget" ? this.brush(i) : obj;
          this.setGridAxis(obj, drawObj);
          obj.index = i;
          result = new Obj(this, obj).render();
          result.root.addClass(type + " " + obj.type);
          this.root.append(result.root);
          _results.push(i++);
        }
        return _results;
      }
    };

    ChartBuilder.prototype.setGridAxis = function(draw, drawObj) {
      delete draw.x;
      delete draw.y;
      delete draw.c;
      if (_scales.x || _scales.x1) {
        if (!_scales.x && _scales.x1) {
          _scales.x = _scales.x1;
        }
        if (!draw.x) {
          draw.x = typeof drawObj.x1 !== 'undefined' ? _scales.x1[drawObj.x1 || 0] : _scales.x[drawObj.x || 0];
        }
      }
      if (_scales.y || _scales.y1) {
        if (!_scales.y && _scales.y1) {
          scales.y = _scales.y1;
        }
        if (!draw.y) {
          draw.y = typeof drawObj.y1 !== 'undefined' ? _scales.y1[drawObj.y1 || 0] : _scales.y[drawObj.y || 0];
        }
      }
      if (_scales.c) {
        if (!draw.c) {
          return draw.c = _scales.c[drawObj.c || 0];
        }
      }
    };

    ChartBuilder.prototype.drawWidget = function() {
      return this.drawObject("widget");
    };

    ChartBuilder.prototype.drawBrush = function() {
      return this.drawObject("brush");
    };

    ChartBuilder.prototype.drawGrid = function() {
      var Grid, dist, g, grid, k, keyIndex, len, obj, orient, _results;
      grid = this.grid();
      if (grid !== null) {
        if (grid.type) {
          grid = {
            c: grid
          };
        }
        _results = [];
        for (k in grid) {
          g = grid[k];
          orient = 'custom';
          if (k === 'x') {
            orient = 'bottom';
          } else if (k === 'x1') {
            orient = 'top';
          } else if (k === 'y') {
            orient = 'left';
          } else if (k === 'y1') {
            orient = 'right';
          }
          if (!_scales[k]) {
            _scales[k] = [];
          }
          if (!(g instanceof Array)) {
            g = [g];
          }
          keyIndex = 0;
          len = g.length;
          _results.push((function() {
            var _results1;
            _results1 = [];
            while (keyIndex < len) {
              Grid = grids[g[keyIndex].type || "block"];
              obj = new Grid(orient, this, g[keyIndex]).render();
              dist = g[keyIndex].dist || 0;
              if (k === 'y') {
                obj.root.translate(this.x() - dist, this.y());
              } else if (k === 'y1') {
                obj.root.translate(this.x2() + dist, this.y());
              } else if (k === 'x') {
                obj.root.translate(this.x(), this.y2() + dist);
              } else if (k === 'x1') {
                obj.root.translate(this.x(), this.y() - dist);
              }
              this.root.append(obj.root);
              _scales[k][keyIndex] = obj.scale;
              _results1.push(keyIndex++);
            }
            return _results1;
          }).call(this));
        }
        return _results;
      }
    };

    ChartBuilder.prototype.createGradient = function(obj, hashKey) {
      var g, id, stop, _i, _len, _ref;
      if (typeof hashKey !== 'undefined' && _hash[hashKey]) {
        return this.url(_hash[hashKey]);
      }
      id = this.createId('gradient');
      obj.id = id;
      if (obj.type === 'linear') {
        g = this.svg.linearGradient(obj);
      } else if (obj.type === 'radial') {
        g = this.svg.radialGradient(obj);
      }
      _ref = obj.stops || [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        stop = _ref[_i];
        g.stop(stop);
      }
      this.defs.append(g);
      if (typeof hashKey !== 'undefined') {
        _hash[hashKey] = id;
      }
      return this.url(id);
    };

    ChartBuilder.prototype.getColor = function(color) {
      var parsedColor;
      if (typeof color === "object") {
        return this.createGradient(color);
      }
      parsedColor = ColorUtil.parse(color);
      if (parsedColor === color) {
        return color;
      }
      return this.createGradient(parsedColor, color);
    };

    ChartBuilder.prototype.area = function(key) {
      return _area[key] || _area;
    };

    ChartBuilder.prototype.height = function(value) {
      if (arguments.length === 0) {
        return this.area("height");
      } else {
        _area.height = value;
        return this;
      }
    };

    ChartBuilder.prototype.width = function(value) {
      if (arguments.length === 0) {
        return this.area("width");
      } else {
        _area.width = value;
        return this;
      }
    };

    ChartBuilder.prototype.x = function(value) {
      if (arguments.length === 0) {
        return this.area("x");
      } else {
        _area.x = value;
        return this;
      }
    };

    ChartBuilder.prototype.y = function(value) {
      if (arguments.length === 0) {
        return this.area("y");
      } else {
        _area.y = value;
        return this;
      }
    };

    ChartBuilder.prototype.y2 = function(value) {
      if (arguments.length === 0) {
        return this.area("y2");
      } else {
        _area.y2 = value;
        return this;
      }
    };

    ChartBuilder.prototype.x2 = function(value) {
      if (arguments.length === 0) {
        return this.area("x2");
      } else {
        _area.x2 = value;
        return this;
      }
    };

    ChartBuilder.prototype.padding = function(key) {
      return _padding[key] || _padding;
    };

    ChartBuilder.prototype.url = function(key) {
      return "url(\#" + key + ")";
    };

    ChartBuilder.prototype.color = function(i, colors) {
      var c, color;
      if (colors instanceof Array) {
        c = colors;
      } else {
        c = _theme.colors;
      }
      color = i > c.length - 1 ? c[c.length - 1] : c[i];
      if (_hash[color]) {
        return this.url(_hash[color]);
      }
      return this.getColor(color);
    };

    ChartBuilder.prototype.text = function(attr, textOrCallback) {
      return el("text", extend({
        "font-family": this.theme("fontFamily"),
        "font-size": this.theme("fontSize"),
        "fill": this.theme("fontColor")
      }, attr)).textNode(textOrCallback);
    };

    ChartBuilder.prototype.setTheme = function() {
      var theme;
      if (arguments.length === 1) {
        theme = arguments[0];
        if (typeof theme === "object") {
          return _theme = extend(_theme, theme);
        } else {
          return _theme = themeList[theme];
        }
      } else if (arguments.length === 2) {
        return _theme[arguments[0]] = arguments[1];
      }
    };

    ChartBuilder.prototype.theme = function(key, value, value2) {
      var val;
      if (arguments.length === 0) {
        return _theme;
      } else if (arguments.length === 1) {
        if (_theme[key]) {
          if (key.indexOf("Color") > -1 && _theme[key]) {
            return this.getColor(this, _theme[key]);
          } else {
            return _theme[key];
          }
        }
      } else if (arguments.length === 3) {
        val = key ? value : value2;
        if (val.indexOf("Color") > -1 && _theme[val]) {
          return this.getColor(this, _theme[val]);
        } else {
          return _theme[val];
        }
      }
    };

    ChartBuilder.prototype.series = function(key) {
      return _series[key] || _series;
    };

    ChartBuilder.prototype.grid = function(key) {
      return _grid[key] || _grid;
    };

    ChartBuilder.prototype.brush = function(key) {
      return _brush[key] || _brush;
    };

    ChartBuilder.prototype.data = function(index, field) {
      if (_data[index]) {
        return _data[index][field] || _data[index];
      } else {
        return _data;
      }
    };

    ChartBuilder.prototype.createId = function(key) {
      return [key || "chart-id", +(new Date), Math.round(Math.random() * 100) % 100].join("-");
    };

    ChartBuilder.prototype.render = function() {
      this.caculate();
      this.drawBefore();
      console.log('start9');
      this.drawDefs();
      console.log('start0');
      this.drawGrid();
      console.log('start1');

      /*
      @drawBrush()
      console.log('start2')
      @drawWidget()
      console.log('start3')
      
      @svg.css background: @theme("backgroundColor")
       */
      return this.svg.render();
    };

    return ChartBuilder;

  })(Draw);

  JenniferTheme = {
    backgroundColor: "white",
    fontSize: "11px",
    fontColor: "#333333",
    fontFamily: "arial,Tahoma,verdana",
    colors: ["#7977C2", "#7BBAE7", "#FFC000", "#FF7800", "#87BB66", "#1DA8A0", "#929292", "#555D69", "#0298D5", "#FA5559", "#F5A397", "#06D9B6", "#C6A9D9", "#6E6AFC", "#E3E766", "#C57BC3", "#DF328B", "#96D7EB", "#839CB5", "#9228E4"],
    gridFontColor: "#333333",
    gridActiveFontColor: "#ff7800",
    gridBorderColor: "#ebebeb",
    gridBorderWidth: 1,
    gridBorderDashArray: "none",
    gridAxisBorderColor: "#ebebeb",
    gridAxisBorderWidth: 1,
    gridActiveBorderColor: "#ff7800",
    gridActiveBorderWidth: 1,
    gaugeBackgroundColor: "#ececec",
    gaugeArrowColor: "#666666",
    gaugeFontColor: "#666666",
    pieBorderColor: "white",
    pieBorderWidth: 1,
    donutBorderColor: "white",
    donutBorderWidth: 1,
    areaOpacity: 0.5,
    bubbleOpacity: 0.5,
    bubbleBorderWidth: 1,
    candlestickBorderColor: "black",
    candlestickBackgroundColor: "white",
    candlestickInvertBorderColor: "red",
    candlestickInvertBackgroundColor: "red",
    ohlcBorderColor: "black",
    ohlcInvertBorderColor: "red",
    ohlcBorderRadius: 5,
    lineBorderWidth: 2,
    pathOpacity: 0.5,
    pathBorderWidth: 1,
    scatterBorderColor: "white",
    scatterBorderWidth: 1,
    scatterHoverColor: "white",
    waterfallBackgroundColor: "#87BB66",
    waterfallInvertBackgroundColor: "#FF7800",
    waterfallEdgeBackgroundColor: "#7BBAE7",
    waterfallBorderColor: "#a9a9a9",
    waterfallBorderDashArray: "0.9",
    titleFontColor: "#333",
    titleFontSize: "13px",
    legendFontColor: "#333",
    legendFontSize: "12px",
    tooltipFontColor: "#333",
    tooltipFontSize: "12px",
    tooltipBackgroundColor: "white",
    tooltipBorderColor: "#aaaaaa",
    tooltipOpacity: 0.7,
    scrollBackgroundColor: "#dcdcdc",
    scrollThumbBackgroundColor: "#b2b2b2",
    scrollThumbBorderColor: "#9f9fa4",
    zoomBackgroundColor: "red",
    zoomFocusColor: "gray",
    crossBorderColor: "#a9a9a9",
    crossBorderWidth: 1,
    crossBorderOpacity: 0.8,
    crossBalloonFontSize: "11px",
    crossBalloonFontColor: "white",
    crossBalloonBackgroundColor: "black",
    crossBalloonOpacity: 0.5
  };

  GradientTheme = {
    backgroundColor: "white",
    fontSize: "11px",
    fontColor: "#666",
    fontFamily: "arial,Tahoma,verdana",
    colors: ["linear(top) #9694e0,0.9 #7977C2", "linear(top) #a1d6fc,0.9 #7BBAE7", "linear(top) #ffd556,0.9 #ffc000", "linear(top) #ff9d46,0.9 #ff7800", "linear(top) #9cd37a,0.9 #87bb66", "linear(top) #3bb9b2,0.9 #1da8a0", "linear(top) #b3b3b3,0.9 #929292", "linear(top) #67717f,0.9 #555d69", "linear(top) #16b5f6,0.9 #0298d5", "linear(top) #ff686c,0.9 #fa5559", "linear(top) #fbbbb1,0.9 #f5a397", "linear(top) #3aedcf,0.9 #06d9b6", "linear(top) #d8c2e7,0.9 #c6a9d9", "linear(top) #8a87ff,0.9 #6e6afc", "linear(top) #eef18c,0.9 #e3e768", "linear(top) #ee52a2,0.9 #df328b", "linear(top) #b6e5f4,0.9 #96d7eb", "linear(top) #93aec8,0.9 #839cb5", "linear(top) #b76fef,0.9 #9228e4"],
    gridFontColor: "#666",
    gridActiveFontColor: "#ff7800",
    gridBorderColor: "#efefef",
    gridBorderWidth: 1,
    gridBorderDashArray: "none",
    gridAxisBorderColor: "#efefef",
    gridAxisBorderWidth: 1,
    gridActiveBorderColor: "#ff7800",
    gridActiveBorderWidth: 1,
    gaugeBackgroundColor: "#ececec",
    gaugeArrowColor: "#666666",
    gaugeFontColor: "#666666",
    pieBorderColor: "white",
    pieBorderWidth: 1,
    donutBorderColor: "white",
    donutBorderWidth: 1,
    areaOpacity: 0.4,
    bubbleOpacity: 0.5,
    bubbleBorderWidth: 1,
    candlestickBorderColor: "#14be9d",
    candlestickBackgroundColor: "linear(top) #27d7b5",
    candlestickInvertBorderColor: "#ff4848",
    candlestickInvertBackgroundColor: "linear(top) #ff6e6e",
    ohlcBorderColor: "#14be9d",
    ohlcInvertBorderColor: "#ff4848",
    ohlcBorderRadius: 5,
    lineBorderWidth: 2,
    pathOpacity: 0.5,
    pathBorderWidth: 1,
    scatterBorderColor: "white",
    scatterBorderWidth: 2,
    scatterHoverColor: "white",
    waterfallBackgroundColor: "linear(top) #9cd37a,0.9 #87bb66",
    waterfallInvertBackgroundColor: "linear(top) #ff9d46,0.9 #ff7800",
    waterfallEdgeBackgroundColor: "linear(top) #a1d6fc,0.9 #7BBAE7",
    waterfallBorderColor: "#a9a9a9",
    waterfallBorderDashArray: "0.9",
    titleFontColor: "#333",
    titleFontSize: "13px",
    legendFontColor: "#666",
    legendFontSize: "12px",
    tooltipFontColor: "#fff",
    tooltipFontSize: "12px",
    tooltipBackgroundColor: "black",
    tooltipBorderColor: "none",
    tooltipOpacity: 1,
    scrollBackgroundColor: "#dcdcdc",
    scrollThumbBackgroundColor: "#b2b2b2",
    scrollThumbBorderColor: "#9f9fa4",
    zoomBackgroundColor: "red",
    zoomFocusColor: "gray",
    crossBorderColor: "#a9a9a9",
    crossBorderWidth: 1,
    crossBorderOpacity: 0.8,
    crossBalloonFontSize: "11px",
    crossBalloonFontColor: "white",
    crossBalloonBackgroundColor: "black",
    crossBalloonOpacity: 0.8
  };

  DarkTheme = {
    backgroundColor: "#222222",
    fontSize: "12px",
    fontColor: "#c5c5c5",
    fontFamily: "arial,Tahoma,verdana",
    colors: ["#12f2e8", "#26f67c", "#e9f819", "#b78bf9", "#f94590", "#8bccf9", "#9228e4", "#06d9b6", "#fc6d65", "#f199ff", "#c8f21d", "#16a6e5", "#00ba60", "#91f2a1", "#fc9765", "#f21d4f"],
    gridFontColor: "#868686",
    gridActiveFontColor: "#ff762d",
    gridBorderColor: "#464646",
    gridBorderWidth: 1,
    gridBorderDashArray: "none",
    gridAxisBorderColor: "#464646",
    gridAxisBorderWidth: 1,
    gridActiveBorderColor: "#ff7800",
    gridActiveBorderWidth: 1,
    gaugeBackgroundColor: "#3e3e3e",
    gaugeArrowColor: "#a6a6a6",
    gaugeFontColor: "#c5c5c5",
    pieBorderColor: "#232323",
    pieBorderWidth: 1,
    donutBorderColor: "#232323",
    donutBorderWidth: 1,
    areaOpacity: 0.5,
    bubbleOpacity: 0.5,
    bubbleBorderWidth: 1,
    candlestickBorderColor: "#14be9d",
    candlestickBackgroundColor: "#14be9d",
    candlestickInvertBorderColor: "#ff4848",
    candlestickInvertBackgroundColor: "#ff4848",
    ohlcBorderColor: "#14be9d",
    ohlcInvertBorderColor: "#ff4848",
    ohlcBorderRadius: 5,
    lineBorderWidth: 2,
    pathOpacity: 0.2,
    pathBorderWidth: 1,
    scatterBorderColor: "none",
    scatterBorderWidth: 1,
    scatterHoverColor: "#222222",
    waterfallBackgroundColor: "#26f67c",
    waterfallInvertBackgroundColor: "#f94590",
    waterfallEdgeBackgroundColor: "#8bccf9",
    waterfallBorderColor: "#a9a9a9",
    waterfallBorderDashArray: "0.9",
    titleFontColor: "#ffffff",
    titleFontSize: "14px",
    legendFontColor: "#ffffff",
    legendFontSize: "11px",
    tooltipFontColor: "#333333",
    tooltipFontSize: "12px",
    tooltipBackgroundColor: "white",
    tooltipBorderColor: "white",
    tooltipOpacity: 1,
    scrollBackgroundColor: "#3e3e3e",
    scrollThumbBackgroundColor: "#666666",
    scrollThumbBorderColor: "#686868",
    zoomBackgroundColor: "red",
    zoomFocusColor: "gray",
    crossBorderColor: "#a9a9a9",
    crossBorderWidth: 1,
    crossBorderOpacity: 0.8,
    crossBalloonFontSize: "11px",
    crossBalloonFontColor: "#333",
    crossBalloonBackgroundColor: "white",
    crossBalloonOpacity: 1
  };

  PastelTheme = {
    backgroundColor: "white",
    fontSize: "11px",
    fontColor: "#333333",
    fontFamily: "Caslon540BT-Regular,Times,New Roman,serif",
    colors: ["#73e9d2", "#fef92c", "#ff9248", "#b7eef6", "#08c4e0", "#ffb9ce", "#ffd4ba", "#14be9d", "#ebebeb", "#666666", "#cdbfe3", "#bee982", "#c22269"],
    gridFontColor: "#333333",
    gridActiveFontColor: "#ff7800",
    gridBorderColor: "#bfbfbf",
    gridBorderWidth: 1,
    gridBorderDashArray: "1, 3",
    gridAxisBorderColor: "#bfbfbf",
    gridAxisBorderWidth: 1,
    gridActiveBorderColor: "#ff7800",
    gridActiveBorderWidth: 1,
    gaugeBackgroundColor: "#f5f5f5",
    gaugeArrowColor: "gray",
    gaugeFontColor: "#666666",
    pieBorderColor: "white",
    pieBorderWidth: 1,
    donutBorderColor: "white",
    donutBorderWidth: 3,
    areaOpacity: 0.4,
    bubbleOpacity: 0.5,
    bubbleBorderWidth: 1,
    candlestickBorderColor: "#14be9d",
    candlestickBackgroundColor: "#14be9d",
    candlestickInvertBorderColor: "#ff4848",
    candlestickInvertBackgroundColor: "#ff4848",
    ohlcBorderColor: "#14be9d",
    ohlcInvertBorderColor: "#ff4848",
    ohlcBorderRadius: 5,
    lineBorderWidth: 2,
    pathOpacity: 0.5,
    pathBorderWidth: 1,
    scatterBorderColor: "white",
    scatterBorderWidth: 1,
    scatterHoverColor: "white",
    waterfallBackgroundColor: "#73e9d2",
    waterfallInvertBackgroundColor: "#ffb9ce",
    waterfallEdgeBackgroundColor: "#08c4e0",
    waterfallBorderColor: "#a9a9a9",
    waterfallBorderDashArray: "0.9",
    titleFontColor: "#333",
    titleFontSize: "18px",
    legendFontColor: "#333",
    legendFontSize: "11px",
    tooltipFontColor: "#fff",
    tooltipFontSize: "12px",
    tooltipBackgroundColor: "black",
    tooltipBorderColor: "black",
    tooltipOpacity: 0.7,
    scrollBackgroundColor: "#f5f5f5",
    scrollThumbBackgroundColor: "#b2b2b2",
    scrollThumbBorderColor: "#9f9fa4",
    zoomBackgroundColor: "red",
    zoomFocusColor: "gray",
    crossBorderColor: "#a9a9a9",
    crossBorderWidth: 1,
    crossBorderOpacity: 0.8,
    crossBalloonFontSize: "11px",
    crossBalloonFontColor: "white",
    crossBalloonBackgroundColor: "black",
    crossBalloonOpacity: 0.7
  };

  Grid = (function(_super) {
    __extends(Grid, _super);

    function Grid(orient, chart, options) {
      this.orient = orient;
      this.chart = chart;
      this.options = options;
      this.init();
    }

    Grid.prototype.init = function() {};

    Grid.prototype.drawBefore = function() {};

    Grid.prototype.draw = function() {
      return null;
    };

    Grid.prototype.get = function(x) {
      if (this.options.key) {
        x = this.chart.data(x, this.options.key);
      }
      return this.scale.get(x);
    };

    Grid.prototype.drawCustom = function() {};

    Grid.prototype.drawTop = function() {};

    Grid.prototype.drawRight = function() {};

    Grid.prototype.drawBottom = function() {};

    Grid.prototype.drawLeft = function() {};

    Grid.prototype.axisLine = function(attr) {
      return el("line", extend({
        x1: 0,
        y1: 0,
        x2: 0,
        y2: 0,
        stroke: this.chart.theme("gridAxisBorderColor"),
        "stroke-width": this.chart.theme("gridAxisBorderWidth"),
        "stroke-opacity": 1
      }, attr));
    };

    Grid.prototype.line = function(attr) {
      return el("line", extend({
        x1: 0,
        y1: 0,
        x2: 0,
        y2: 0,
        stroke: this.chart.theme("gridBorderColor"),
        "stroke-width": this.chart.theme("gridBorderWidth"),
        "stroke-dasharray": this.chart.theme("gridBorderDashArray"),
        "stroke-opacity": 1
      }, attr));
    };

    Grid.prototype.max = function() {
      return this.scale.max();
    };

    Grid.prototype.min = function() {
      return this.scale.min();
    };

    Grid.prototype.rangeBand = function() {
      return this.scale.rangeBand();
    };

    Grid.prototype.rate = function(value, max) {
      return get(max() * (value / max));
    };

    Grid.prototype.invert = function(y) {
      return this.scale.invert(y);
    };

    Grid.prototype.domain = function() {
      return this.scale.domain();
    };

    Grid.prototype.range = function() {
      return this.scale.range();
    };

    Grid.prototype.drawGrid = function() {
      var root;
      root = el("g", {
        "class": ["grid", this.options.type || "block"].join(" ")
      });
      if (this.orient === "bottom") {
        this.drawBottom(root);
      } else if (this.orient === "top") {
        this.drawTop(root);
      } else if (this.orient === "left") {
        this.drawLeft(root);
      } else if (this.orient === "right") {
        this.drawRight(root);
      } else if (this.orient === "custom") {
        this.drawCustom(root);
      }
      if (this.options.hide) {
        root.attr({
          display: "none"
        });
      }
      return {
        root: root,
        scale: this
      };
    };

    Grid.prototype.drawCustom = function(root) {};

    Grid.prototype.drawTop = function(root) {};

    Grid.prototype.drawRight = function(root) {};

    Grid.prototype.drawBottom = function(root) {};

    Grid.prototype.drawleft = function(root) {};

    return Grid;

  })(Draw);

  BlockGrid = (function(_super) {
    var band, bar, domain, half_band, points;

    __extends(BlockGrid, _super);

    points = [];

    domain = [];

    band = 0;

    half_band = 0;

    bar = 0;

    function BlockGrid(orient, chart, options) {
      this.orient = orient;
      this.chart = chart;
      this.options = options;
      BlockGrid.__super__.constructor.call(this, this.orient, this.chart, this.options);
    }

    BlockGrid.prototype.init = function() {
      return this.scale = new OrdinalScale();
    };

    BlockGrid.prototype.drawTop = function(root) {
      var axis, d, full_height, hasFull, hasLine, i, len;
      full_height = this.chart.height();
      hasLine = this.options.line || false;
      hasFull = this.options.full || false;
      if (!hasLine) {
        root.append(this.axisLine({
          x2: this.chart.width()
        }));
      }
      i = 0;
      len = points.length;
      while (i < len) {
        d = domain[i];
        if (d === "") {
          continue;
        }
        axis = root.group().translate(points[i], 0);
        axis.append(this.line({
          x1: -half_band,
          y1: 0,
          x2: -half_band,
          y2: hasLine ? full_height : -bar
        }));
        axis.append(this.chart.text({
          x: 0,
          y: -20,
          "text-anchor": "middle",
          fill: this.chart.theme("gridFontColor")
        }, d));
        i++;
      }
      if (!hasFull) {
        axis = root.group().translate(this.chart.width(), 0);
        return axis.append(this.line({
          y2: hasLine ? full_height : -bar
        }));
      }
    };

    BlockGrid.prototype.drawBottom = function(root) {
      var axis, d, full_height, hasFull, hasLine, i, len;
      full_height = this.chart.height();
      hasLine = this.options.line || false;
      hasFull = this.options.full || false;
      if (!hasLine) {
        root.append(this.axisLine({
          x2: this.chart.width()
        }));
      }
      i = 0;
      len = points.length;
      while (i < len) {
        d = domain[i];
        if (d === "") {
          continue;
        }
        axis = root.group().translate(points[i], 0);
        axis.append(this.line({
          x1: -half_band,
          y1: 0,
          x2: -half_band,
          y2: hasLine ? -full_height : bar
        }));
        axis.append(this.chart.text({
          x: 0,
          y: 20,
          "text-anchor": "middle",
          fill: this.chart.theme("gridFontColor")
        }, d));
        i++;
      }
      if (!hasFull) {
        axis = root.group().translate(this.chart.width(), 0);
        return axis.append(this.line({
          y2: hasLine ? -full_height : bar
        }));
      }
    };

    BlockGrid.prototype.drawLeft = function(root) {
      var axis, d, full_width, hasFull, hasLine, i, len;
      full_width = this.chart.width();
      hasLine = this.options.line || false;
      hasFull = this.options.full || false;
      if (!hasLine) {
        root.append(this.axisLine({
          y2: this.chart.height()
        }));
      }
      i = 0;
      len = points.length;
      while (i < len) {
        d = domain[i];
        if (d === "") {
          continue;
        }
        axis = root.group().translate(0, points[i]);
        axis.append(this.line({
          x2: hasLine ? full_width : -bar
        }));
        axis.append(this.chart.text({
          x: -bar - 4,
          y: half_band,
          "text-anchor": "end",
          fill: this.chart.theme("gridFontColor")
        }, d));
        i++;
      }
      if (!hasFull) {
        axis = root.group().translate(0, this.chart.height());
        return axis.append(this.line({
          y2: hasLine ? full_width : -bar
        }));
      }
    };

    BlockGrid.prototype.drawRight = function(root) {
      var axis, d, full_width, hasFull, hasLine, i, len;
      full_width = this.chart.width();
      hasLine = this.options.line || false;
      hasFull = this.options.full || false;
      if (!hasLine) {
        root.append(this.axisLine({
          y2: this.chart.height()
        }));
      }
      i = 0;
      len = points.length;
      while (i < len) {
        d = domain[i];
        if (d === "") {
          continue;
        }
        axis = root.group().translate(0, points[i] - half_band);
        axis.append(this.line({
          x2: hasLine ? -full_width : bar
        }));
        axis.append(this.chart.text({
          x: bar + 4,
          y: half_band,
          "text-anchor": "start",
          fill: this.chart.theme("gridFontColor")
        }, d));
        i++;
      }
      if (!hasFull) {
        axis = root.group().translate(0, this.chart.height());
        return axis.append(this.line({
          y2: hasLine ? -full_width : bar
        }));
      }
    };

    BlockGrid.prototype.drawBefore = function() {
      var height, max, width, _ref;
      this.initDomain();
      width = this.chart.width();
      height = this.chart.height();
      max = (_ref = this.orient === "left" || this.orient === "right") != null ? _ref : {
        height: width
      };
      this.scale.domain(this.options.domain);
      if (this.options.full) {
        this.scale.rangeBands([0, max], 0, 0);
      } else {
        this.scale.rangePoints([0, max], 0);
      }
      points = this.scale.range();
      domain = this.scale.domain();
      band = this.scale.rangeBand();
      half_band = this.options.full ? 0 : band / 2;
      return bar = 6;
    };

    BlockGrid.prototype.initDomain = function() {
      var d;
      if (this.options.target && !this.options.domain) {
        domain = (function() {
          var _i, _len, _ref, _results;
          _ref = this.chart.data();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            d = _ref[_i];
            _results.push(d[this.options.target]);
          }
          return _results;
        }).call(this);
        if (this.options.reverse) {
          domain.reverse();
        }
        this.options.domain = domain;
        this.options.step = this.options.step || 10;
        return this.options.max = this.options.max || 100;
      }
    };

    BlockGrid.prototype.draw = function() {
      return this.drawGrid();
    };

    return BlockGrid;

  })(Grid);

  DateGrid = (function(_super) {
    var bar, ticks, values;

    __extends(DateGrid, _super);

    ticks = [];

    bar = 0;

    values = [];

    function DateGrid(orient, chart, options) {
      this.orient = orient;
      this.chart = chart;
      this.options = options;
      DateGrid.__super__.constructor.call(this, this.orient, this.chart, this.options);
    }

    DateGrid.prototype.init = function() {
      return this.scale = new TimeScale();
    };

    DateGrid.prototype.drawTop = function(root) {
      var axis, full_height, i, len, textValue, _results;
      full_height = this.chart.height();
      if (!this.options.line) {
        root.append(this.axisLine({
          x2: this.chart.width()
        }));
      }
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        axis = root.group().translate(values[i], 0);
        axis.append(this.line({
          y2: this.options.line ? full_height : -bar
        }));
        textValue = this.options.format ? this.options.format(ticks[i]) : ticks[i] + "";
        axis.append(this.chart.text({
          x: 0,
          y: -bar - 4,
          "text-anchor": "middle",
          fill: this.chart.theme("gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    DateGrid.prototype.drawBottom = function(root) {
      var axis, full_height, i, len, textValue, _results;
      full_height = this.chart.height();
      if (!this.options.line) {
        root.append(this.axisLine({
          x2: this.chart.width()
        }));
      }
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        axis = root.group().translate(values[i], 0);
        axis.append(this.line({
          y2: this.options.line ? -full_height : bar
        }));
        textValue = this.options.format ? this.options.format(ticks[i]) : ticks[i] + "";
        axis.append(this.chart.text({
          x: 0,
          y: bar * 3,
          "text-anchor": "middle",
          fill: this.chart.theme("gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    DateGrid.prototype.drawLeft = function(root) {
      var axis, full_width, i, len, textValue, _results;
      full_width = this.chart.width();
      if (!this.options.line) {
        root.append(this.axisLine({
          y2: this.chart.height()
        }));
      }
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        axis = root.group().translate(0, values[i]);
        axis.append(this.line({
          x2: this.options.line ? full_width : -bar
        }));
        textValue = this.options.format ? this.options.format(ticks[i]) : ticks[i] + "";
        axis.append(this.chart.text({
          x: -bar - 4,
          y: bar,
          "text-anchor": "end",
          fill: this.chart.theme("gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    DateGrid.prototype.drawRight = function(root) {
      var axis, full_width, i, len, textValue, _results;
      full_width = this.chart.width();
      if (!this.options.line) {
        root.append(this.axisLine({
          y2: this.chart.height()
        }));
      }
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        axis = root.group().translate(0, values[i]);
        axis.append(this.line({
          x2: this.options.line ? -full_width : bar
        }));
        textValue = this.options.format ? this.options.format(ticks[i]) : ticks[i] + "";
        axis.append(this.chart.text({
          x: bar + 4,
          y: -bar,
          "text-anchor": "start",
          fill: this.chart.theme("gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    DateGrid.prototype.drawBefore = function() {
      var max, range, step, t;
      this.initDomain();
      max = this.chart.height();
      if (this.orient === "top" || this.orient === "bottom") {
        max = this.chart.width();
      }
      range = [0, max];
      this.scale.domain(this.options.domain).range(range);
      step = this.options.step;
      if (this.options.realtime) {
        ticks = this.scale.realTicks(step[0], step[1]);
      } else {
        ticks = this.scale.ticks(step[0], step[1]);
      }
      bar = 6;
      return values = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = ticks.length; _i < _len; _i++) {
          t = ticks[_i];
          _results.push(this.scale.get(t));
        }
        return _results;
      }).call(this);
    };

    DateGrid.prototype.initDomain = function() {
      var data, domain, key, max, min, row, target, value, _i, _j, _len, _len1;
      if (this.options.target && !this.options.domain) {
        if (typeof this.options.target === "string") {
          this.options.target = [this.options.target];
        }
        target = this.options.target;
        domain = [];
        data = this.chart.data();
        min = this.options.min || void 0;
        max = this.options.max || void 0;
        for (_i = 0, _len = target.length; _i < _len; _i++) {
          key = target[_i];
          for (_j = 0, _len1 = data.length; _j < _len1; _j++) {
            row = data[_j];
            value = +row[key];
            if (typeof min === "undefined") {
              min = value;
            } else if (min > value) {
              min = value;
            }
            if (typeof max === "undefined") {
              max = value;
            } else if (max < value) {
              max = value;
            }
          }
        }
        this.options.max = max;
        this.options.min = min;
        this.options.domain = [this.options.min, this.options.max];
        if (this.options.reverse) {
          return this.options.domain.reverse();
        }
      }
    };

    DateGrid.prototype.draw = function() {
      return this.drawGrid();
    };

    return DateGrid;

  })(Grid);

  RangeGrid = (function(_super) {
    var bar, nice, step, ticks, values;

    __extends(RangeGrid, _super);

    step = 0;

    nice = false;

    ticks = [];

    bar = 0;

    values = [];

    function RangeGrid(orient, chart, options) {
      this.orient = orient;
      this.chart = chart;
      this.options = options;
      RangeGrid.__super__.constructor.call(this, this.orient, this.chart, this.options);
    }

    RangeGrid.prototype.init = function() {
      return this.scale = new LinearScale();
    };

    RangeGrid.prototype.drawTop = function(root) {
      var axis, full_height, i, isZero, len, min, textValue, _results;
      full_height = this.chart.height();
      if (!this.options.line) {
        root.append(this.axisLine({
          x2: this.chart.width()
        }));
      }
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 && ticks[i] !== min ? true : false;
        axis = root.group().translate(values[i], 0);
        axis.append(this.line({
          y2: hasLine ? full_height : -bar,
          stroke: this.chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor"),
          "stroke-width": this.chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        axis.append(this.chart.text({
          x: 0,
          y: -bar - 4,
          "text-anchor": "middle",
          fill: this.chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    RangeGrid.prototype.drawBottom = function(root) {
      var axis, full_height, i, isZero, len, min, textValue, _results;
      full_height = this.chart.height();
      if (!this.options.line) {
        root.append(this.axisLine({
          x2: this.chart.width()
        }));
      }
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 && ticks[i] !== min ? true : false;
        axis = root.group().translate(values[i], 0);
        axis.append(this.line({
          y2: this.options.line ? -full_height : bar,
          stroke: this.chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor"),
          "stroke-width": this.chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        axis.append(this.chart.text({
          x: 0,
          y: bar * 3,
          "text-anchor": "middle",
          fill: this.chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    RangeGrid.prototype.drawLeft = function(root) {
      var axis, full_width, i, isZero, len, min, textValue, _results;
      full_width = this.chart.width();
      if (!this.options.line) {
        root.append(this.axisLine({
          y2: this.chart.height()
        }));
      }
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 && ticks[i] !== min ? true : false;
        axis = root.group().translate(0, values[i]);
        axis.append(this.line({
          x2: hasLine ? full_width : -bar,
          stroke: this.chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor"),
          "stroke-width": this.chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        axis.append(this.chart.text({
          x: -bar - 4,
          y: bar,
          "text-anchor": "end",
          fill: this.chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    RangeGrid.prototype.drawRight = function(root) {
      var axis, full_width, i, isZero, len, min, textValue, _results;
      full_width = this.chart.width();
      if (!this.options.line) {
        root.append(this.axisLine({
          y2: this.chart.height()
        }));
      }
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 && ticks[i] !== min ? true : false;
        axis = root.group().translate(0, values[i]);
        axis.append(this.line({
          x2: hasLine ? -full_width : bar,
          stroke: this.chart.theme(isZero, "gridActiveBorderColor", "gridAxisBorderColor"),
          "stroke-width": this.chart.theme(isZero, "gridActiveBorderWidth", "gridAxisBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        axis.append(this.chart.text({
          x: bar + 4,
          y: bar,
          "text-anchor": "start",
          fill: this.chart.theme(isZero, "gridActiveFontColor", "gridFontColor")
        }, textValue));
        _results.push(i++);
      }
      return _results;
    };

    RangeGrid.prototype.drawBefore = function() {
      var height, t, width;
      this.initDomain();
      width = this.chart.width();
      height = this.chart.height();
      this.scale.domain(this.options.domain);
      if (this.orient === "left" || this.orient === "right") {
        this.scale.range([height, 0]);
      } else {
        this.scale.range([0, width]);
      }
      step = this.options.step || 10;
      nice = this.options.nice || false;
      ticks = this.scale.ticks(step, nice);
      bar = 6;
      return values = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = ticks.length; _i < _len; _i++) {
          t = ticks[_i];
          _results.push(this.scale.get(t));
        }
        return _results;
      }).call(this);
    };

    RangeGrid.prototype.initDomain = function() {
      var data, domain, end, key, max, min, row, series, start, target, unit, value, _i, _j, _len, _len1, _max, _min;
      if (this.options.target && !this.options.domain) {
        if (typeof this.options.target === 'string') {
          this.options.target = [this.options.target];
        }
        max = this.options.max || 0;
        min = this.options.min || 0;
        target = this.options.target;
        domain = [];
        series = this.chart.series();
        data = this.chart.data();
        for (_i = 0, _len = target.length; _i < _len; _i++) {
          key = target[_i];
          if (typeof key === "function") {
            for (_j = 0, _len1 = data.length; _j < _len1; _j++) {
              row = data[_j];
              value = +key(row);
              if (max < value) {
                max = value;
              }
              if (min > value) {
                min = value;
              }
            }
          } else {
            _max = series[key].max;
            _min = series[key].min;
            if (max < _max) {
              max = _max;
            }
            if (min > _min) {
              min = _min;
            }
          }
        }
        this.options.max = max;
        this.options.min = min;
        this.options.step = this.options.step || 10;
        unit = this.options.unit || Math.ceil((max - min) / this.options.step);
        start = 0;
        while (start < max) {
          start += unit;
        }
        end = 0;
        while (end > min) {
          end -= unit;
        }
        if (unit === 0) {
          return this.options.domain = [0, 0];
        } else {
          this.options.domain = [end, start];
          if (this.options.reverse) {
            this.options.domain.reverse();
          }
          return this.options.step = Math.abs(start / unit) + Math.abs(end / unit);
        }
      }
    };

    RangeGrid.prototype.draw = function() {
      return this.drawGrid();
    };

    return RangeGrid;

  })(Grid);

  RuleGrid = (function(_super) {
    var bar, center, hideZero, nice, step, ticks, values;

    __extends(RuleGrid, _super);

    step = 0;

    nice = false;

    ticks = [];

    bar = 0;

    values = [];

    hideZero = false;

    center = false;

    function RuleGrid(orient, chart, options) {
      this.orient = orient;
      this.chart = chart;
      this.options = options;
      RuleGrid.__super__.constructor.call(this, this.orient, this.chart, this.options);
    }

    RuleGrid.prototype.drawTop = function(root) {
      var axis, centerPosition, half_height, half_width, height, i, isZero, len, min, textValue, width, _results;
      width = this.chart.width();
      height = this.chart.height();
      half_width = width / 2;
      half_height = height / 2;
      centerPosition = center ? half_height : 0;
      root.append(this.axisLine({
        y1: centerPosition,
        y2: centerPosition,
        x2: width
      }));
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 ? true : false;
        axis = root.group().translate(values[i], centerPosition);
        axis.append(this.line({
          y1: center ? -bar : 0,
          y2: bar,
          stroke: this.chart.theme("gridAxisBorderColor"),
          "stroke-width": this.chart.theme("gridBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        if (!isZero || (isZero && !hideZero)) {
          axis.append(this.chart.text({
            x: 0,
            y: bar * 2 + 4,
            "text-anchor": "middle",
            fill: this.chart.theme("gridFontColor")
          }, textValue));
        }
        _results.push(i++);
      }
      return _results;
    };

    RuleGrid.prototype.drawBottom = function(root) {
      var axis, centerPosition, half_height, half_width, height, i, isZero, len, min, textValue, width, _results;
      width = this.chart.width();
      height = this.chart.height();
      half_width = width / 2;
      half_height = height / 2;
      centerPosition = center ? -half_height : 0;
      root.append(this.axisLine({
        y1: centerPosition,
        y2: centerPosition,
        x2: width
      }));
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 ? true : false;
        axis = root.group().translate(values[i], centerPosition);
        axis.append(this.line({
          y1: center ? -bar : 0,
          y2: center ? bar : -bar,
          stroke: this.chart.theme("gridAxisBorderColor"),
          "stroke-width": this.chart.theme("gridBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        if (!isZero || (isZero && !hideZero)) {
          axis.append(this.chart.text({
            x: 0,
            y: -bar * 2,
            "text-anchor": "middle",
            fill: this.chart.theme("gridFontColor")
          }, textValue));
        }
        _results.push(i++);
      }
      return _results;
    };

    RuleGrid.prototype.drawLeft = function(root) {
      var axis, centerPosition, half_height, half_width, height, i, isZero, len, min, textValue, width, _results;
      width = this.chart.width();
      height = this.chart.height();
      half_width = width / 2;
      half_height = height / 2;
      centerPosition = center ? half_width : 0;
      root.append(this.axisLine({
        x1: centerPosition,
        x2: centerPosition,
        y2: height
      }));
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 ? true : false;
        axis = root.group().translate(centerPosition, values[i]);
        axis.append(this.line({
          x1: center ? -bar : 0,
          x2: bar,
          stroke: this.chart.theme("gridAxisBorderColor"),
          "stroke-width": this.chart.theme("gridBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        if (!isZero || (isZero && !hideZero)) {
          axis.append(this.chart.text({
            x: 2 * bar,
            y: bar - 2,
            "text-anchor": "start",
            fill: this.chart.theme("gridFontColor")
          }, textValue));
        }
        _results.push(i++);
      }
      return _results;
    };

    RuleGrid.prototype.drawRight = function(root) {
      var axis, centerPosition, half_height, half_width, height, i, isZero, len, min, textValue, width, _results;
      width = this.chart.width();
      height = this.chart.height();
      half_width = width / 2;
      half_height = height / 2;
      centerPosition = center ? -half_width : 0;
      root.append(this.axisLine({
        x1: centerPosition,
        x2: centerPosition,
        y2: height
      }));
      min = this.scale.min();
      i = 0;
      len = ticks.length;
      _results = [];
      while (i < len) {
        isZero = ticks[i] === 0 ? true : false;
        axis = root.group().translate(centerPosition, values[i]);
        axis.append(this.line({
          x1: center ? -bar : 0,
          x2: center ? bar : -bar,
          stroke: this.chart.theme("gridAxisBorderColor"),
          "stroke-width": this.chart.theme("gridBorderWidth")
        }));
        textValue = (this.options.format ? this.options.format(ticks[i]) : ticks[i] + "");
        if (!isZero || (isZero && !hideZero)) {
          axis.append(this.chart.text({
            x: -bar - 4,
            y: bar - 2,
            "text-anchor": "middle",
            fill: this.chart.theme("gridFontColor")
          }, textValue));
        }
        _results.push(i++);
      }
      return _results;
    };

    RuleGrid.prototype.drawBefore = function() {
      var height, t, width;
      this.initDomain();
      width = this.chart.width();
      height = this.chart.height();
      this.scale.domain(this.options.domain);
      if (this.orient === "left" || this.orient === "right") {
        this.scale.range([height, 0]);
      } else {
        this.scale.range([0, width]);
      }
      step = this.options.step || 10;
      nice = this.options.nice || false;
      ticks = this.scale.ticks(step, nice);
      bar = 6;
      values = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = ticks.length; _i < _len; _i++) {
          t = ticks[_i];
          _results.push(this.scale.get(t));
        }
        return _results;
      }).call(this);
      hideZero = this.options.hideZero || false;
      return center = this.options.center || false;
    };

    return RuleGrid;

  })(RangeGrid);

  module.exports = {
    ChartBuilder: ChartBuilder
  };

}).call(this);
