google.load('visualization', '1', {'packages': ['geochart']});
google.setOnLoadCallback(function() {
  window.isGoogleLoaded = true;
  $(document).trigger('googleLoaded');
});

function dataFrameToDataTable(data) {
  var columns = Object.keys(data);
  if (columns.length == 0)
    return [];
  var dt = [columns];
  for (var i = 0; i < data[columns[0]].length; i++) {
    var row = [];
    for (var j = 0; j < columns.length; j++) {
      row.push(data[columns[j]][i]);
    }
    dt.push(row);
  }
  return google.visualization.arrayToDataTable(dt);
}

function waitForGoogleLoad(func) {
  if (window.isGoogleLoaded) {
    setTimeout(func, 1);
  } else {
    $(document).one('googleLoaded', func);
  }
}

var GeochartOutputBinding = new Shiny.OutputBinding();
$.extend(GeochartOutputBinding, {
  find: function(scope) {
    return $(scope).find('.shiny-geochart-output');
  },
  renderValue: function(el, data) {
    waitForGoogleLoad(function() {
      data = dataFrameToDataTable(data);

      var $el = $(el);
      var chart = $el.data('geochart');
      if (!chart) {
        chart = new google.visualization.GeoChart(el);
        $el.data('geochart', chart);
        chart.options = JSON.parse($el.attr('data-options'));
      }

      chart.draw(data, chart.options);
    });
  }
});
Shiny.outputBindings.register(GeochartOutputBinding, 'geochart');