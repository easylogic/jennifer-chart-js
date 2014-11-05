
/*
Time Class
 */

(function() {
  var DomUtil, Path, Polygon, Polyline, Svg, Time, TimeUtil, Transform,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Time = (function() {
    function Time() {}

    Time.years = "years";

    Time.months = "months";

    Time.days = "days";

    Time.hours = "hours";

    Time.minutes = "minutes";

    Time.seconds = "seconds";

    Time.milliseconds = "milliseconds";

    Time.weeks = "weeks";

    return Time;

  })();


  /*
  TimeUtil Class
    add()
    format()
   */

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

}).call(this);
