
/*
TimeUtil Class
  add()
  format()
 */

(function() {
  var ColorUtil, DomUtil, MathUtil, Path, Polygon, Polyline, Scale, Svg, TimeUtil, Transform,
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
    var _max, _min, _niceMax, _niceMin, _range, _tickSpacing, _ticks;

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
      return isNice = isNice ? isNice : false;
    };

    if (min > max) {
      _max = min;
      _min = max;
    } else {
      _min = min;
      _max = max;
      _ticks = ticks;
      _tickSpacing = 0;
      _niceMin;
      _niceMax;
      _range = isNice ? MathUtil.niceNum(_max - _min, false) : _max - _min;
      _tickSpacing = isNice ? MathUtil.niceNum(_range / _ticks, true) : _range / _ticks;
      _niceMin = isNice ? Math.floor(_min / _tickSpacing) * _tickSpacing : _min;
      _niceMax = isNice ? Math.floor(_max / _tickSpacing) * _tickSpacing : _max;
      ({
        min: _niceMin,
        max: _niceMax,
        range: _range,
        spacing: _tickSpacing
      });
    }

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

    Scale.prototype.rangeBand = function() {
      return _rangeBand;
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

}).call(this);
