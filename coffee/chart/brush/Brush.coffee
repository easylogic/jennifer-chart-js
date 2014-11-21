class Brush
	constructor: (@chart, @brush) ->
		@init()

	init: () ->

	curvePoints: (K) ->
		p1 = []
		p2 = []
		n = K.length - 1

		a = []
		b = []
		c = []
		r = []

		#	/*left most segment*/
		a[0] = 0;
		b[0] = 2;
		c[0] = 1;
		r[0] = K[0] + 2 * K[1]

		#	/*internal segments*/
		for i in [1...(n-1)]
			a[i] = 1
			b[i] = 4
			c[i] = 1
			r[i] = 4 * K[i] + 2 * K[i + 1]

		#/*right segment*/
		a[n - 1] = 2
		b[n - 1] = 7
		c[n - 1] = 0
		r[n - 1] = 8 * K[n - 1] + K[n]

		#/*solves Ax=b with the Thomas algorithm (from Wikipedia)*/
		for i in [1...n]
			m = a[i] / b[i - 1]
			b[i] = b[i] - m * c[i - 1]
			r[i] = r[i] - m * r[i - 1]

		p1[n - 1] = r[n - 1] / b[n - 1]

		for i in [(n-2)..0]
			p1[i] = (r[i] - c[i] * p1[i + 1]) / b[i]

		#we have p1, now compute p2*/
		for i in [i...(n-1)]
			p2[i] = 2 * K[i + 1] - p1[i + 1]

		p2[n - 1] = 0.5 * (K[n] + p1[n - 1])
		p1: p1, p2: p2

	getScaleValue : (value, minValue, maxValue, minRadius, maxRadius) ->
		range = maxRadius - maxRadius
		per = (value - minValue) / (maxValue - minValue)
		range * per + minRadius

	getXY : () ->
		len = @chart.data().length;
		xy = []

		for i in [0...len]
			startX = @brush.x(i)
			data = @chart.data(i)

			for j in [0...@brush.target.length]
				key = @brush.target[j];
				value = data[key];
				series = @chart.series(key);

				if !xy[j]
					xy[j] = x: [], y: [], value: [], min: [], max: []

				xy[j].x.push (startX);
				xy[j].y.push(@brush.y(value));
				xy[j].value.push(value);
				xy[j].min.push(value is series.min);
				xy[j].max.push(value is series.max);
		xy

	getStackXY : () ->
		xy = @getXY()

		for i in [0...@chart.data().length]
			data = @chart.data(i)
			valueSum = 0

			for j in [0...@brush.target.length]
				key = @brush.target[j]
				value = data[key]

				if j > 0
					valueSum += data[@brush.target[j - 1]];

			xy[j].y[i] = @brush.y(value + valueSum);

		xy
