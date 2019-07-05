var chartJsOptions = {
    type: 'bar',
    data: {
      labels: ["Africa", "Asia", "Europe", "Latin America", "North America"],
      datasets: [
        {
          label: "Population (millions)",
          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
          data: [2478,5267,734,784,433]
        }
      ]
    },
    options: {
      legend: { display: false },
      title: {
        display: true,
        text: 'Predicted world population (millions) in 2050'
      }
    }
};

const ChartjsNode = require('chartjs-node');
// 600x600 canvas size
var chartNode = new ChartjsNode(600, 600);
return chartNode.drawChart(chartJsOptions)
.then(() => {
    // chart is created
 
    // get image as png buffer
    return chartNode.getImageBuffer('image/png');
})
.then(buffer => {
    Array.isArray(buffer) // => true
    // as a stream
    return chartNode.getImageStream('image/png');
})
.then(streamResult => {
    // using the length property you can do things like
    // directly upload the image to s3 by using the
    // stream and length properties
    streamResult.stream // => Stream object
    streamResult.length // => Integer length of stream
    // write to a file
    return chartNode.writeImageToFile('image/png', '/config/www/testimage.png');
})
.then(() => {
    // chart is now written to the file path
    // ./testimage.png
});


