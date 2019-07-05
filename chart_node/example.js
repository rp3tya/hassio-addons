dates = [];
datas = [];
var chartJsOptions = {
	type: 'line',
	data: {
	  labels: dates,
	  datasets: [
	    {
	      label: "Weather",
	      data: datas
	    }
	  ]
	},
	options: {
		scales: {
			xAxes: [{
				display: true
			}],
		 yAxes: [{
			ticks: {
				beginAtZero: true,
				autoSkip: true
			}
			}]
		},
		title: {
			display: true,
			text: 'Temperatures'
		}
	}
};

const sqlite3 = require('sqlite3');
// open the database
let db = new sqlite3.Database('/config/home-assistant_v2.db');
// query
let sql = `SELECT state_id, created, strftime('%H:%M',created) as time 
		FROM states where entity_id="sun.sun" and created>"2019-07-05 14:00" 
		ORDER BY created`;
db.all(sql, [], (err, rows) => {
	if (err) {
		throw err;
	}
	// fetch data
	rows.forEach((row) => {
		dates.push(row.time);
		datas.push(row.state_id);
	});

	const ChartjsNode = require('chartjs-node');
	// 600x600 canvas size
	var chartNode = new ChartjsNode(600, 600);
	return chartNode.drawChart(chartJsOptions)
	.then(() => { // chart is created
		// get image as png buffer
		return chartNode.getImageBuffer('image/png');
	})
	.then(buffer => {
		// as a stream
		return chartNode.getImageStream('image/png');
	})
	.then(streamResult => {
		// write to a file
		return chartNode.writeImageToFile('image/png', '/config/appdaemon/custom_css/chart.png');
	})
	.then(() => {
		// chart is now written to the file path
	});

});
// close the database connection
db.close();
