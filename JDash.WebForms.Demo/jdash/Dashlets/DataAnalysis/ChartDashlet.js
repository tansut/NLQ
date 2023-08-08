define(["require", "./Common", "klt/core/Deferred", "../../Resource/JavaScript/hcThemes/gray",
"../../Resource/JavaScript/hcThemes/green", "../../Resource/JavaScript/hcThemes/blue", "../../Resource/JavaScript/hcThemes/default"],
    function (require, Common, Deferred, grayTheme, greenTheme, blueTheme, defaultTheme) {
    var chartModule = function (params, node) {
        var context = this.context = params.context;
        var domNode = this.domNode = node || document.createElement("div");

        var dashletNode = this.dashletNode = document.createElement("div");
        domNode.appendChild(dashletNode);

        var libDefer = new Deferred();

        this._handleDomUpdate = function (newNode, insideOnly) {
            if (!insideOnly)
                domNode = this.domNode = newNode;
            domNode.appendChild(dashletNode);
        }

        this._handleDomUpdating = function () {
            this.domNode.removeChild(this.dashletNode);
        }


        this.defaultChartData = function () {
            return {
                chart: {

                },

                title: {

                    text: 'Sample Chart'

                },

                plotOptions: {

                    pie: {

                        allowPointSelect: true,

                        cursor: 'pointer',

                        dataLabels: {

                            enabled: true,

                            color: '#000000',

                            connectorColor: '#000000',

                            formatter: function () {

                                return '<b>' + this.point.name + '</b>: ' + this.percentage + ' %';

                            }

                        }

                    }

                },
                credits: {
                    enabled: false
                },

                series: [{

                    type: 'pie',

                    name: 'Browser share',

                    data: [

                        ['Firefox', 45.0],

                        ['IE', 26.8],

                        {

                            name: 'Chrome',

                            y: 12.8,

                            sliced: true,

                            selected: true

                        },

                        ['Safari', 8.5],

                        ['Opera', 6.2],

                        ['Others', 0.7]

                    ]

                }]
            }
        },


        this.refresh = function (redrawOnly, newHeight) {
            if (redrawOnly && this.chart) {
                var size = this.context.pane.getDashletSize();
                this.chart.setSize(size.w == 0 ? 300 : size.w, size.h == 0 ? 400 : newHeight, false);
                this.context.fn.domStyle.set(this.dashletNode, "display", "");
                this.createChart();
            } else this.createChart();
        }

        this.setChartData = function (options) {
            var chart = options.chart;
            var res = options.data;

            var series = [], categories = [];

            function find(arr, property, value) {
                var idx = findIndex(arr, property, value);
                if (idx < 0)
                    return null;
                else return arr[idx];
            }

            function findIndex(arr, property, value) {
                for (var i = 0; i < arr.length; i++) {
                    var obj = arr[i];
                    var item = property == null ? obj : obj[property];
                    if (item === value)
                        return i;

                }
                return -1;
            }

            function initSerieData() {
                var initData = [];
                return initData;
            }

            var pieIncrement = (chart.ChartType == Common.chartType.pie ? 1 : 0);

            for (var j = 0; j < res.Items.length; j++) {
                var items = res.Items[j];
                var itemCategory = "", itemData = null;
                var serie = null;
                if (chart.HasPivotDimension && pieIncrement <= 0) {
                    serie = find(series, 'name', items[0].FormattedValue);
                    if (serie == null) {
                        serie = { name: items[0].FormattedValue, data: initSerieData() };
                        series.push(serie);
                    }

                    if (res.Headers.length == 4) {
                        itemCategory = items[1].FormattedValue + " - " + items[2].FormattedValue;
                        itemData = items[3].Value;
                    } else {
                        itemCategory = items[1].FormattedValue;
                        itemData = items[2].Value;
                    }
                } else {
                    if (j == 0) {
                        serie = { name: res.Headers[res.Headers.length - 1].Caption, data: initSerieData(), showInLegend: false };
                        series.push(serie);
                    } else serie = series[0];

                    if (res.Headers.length == 3) {
                        itemCategory = items[0].FormattedValue + " - " + items[1].FormattedValue;
                        itemData = items[2].Value;
                    } else {
                        itemCategory = items[0].FormattedValue;
                        itemData = items[1].Value;
                    }
                }
                var existingCategoryIndex = findIndex(categories, null, itemCategory);

                if (existingCategoryIndex < 0) {
                    categories.push(itemCategory);
                    existingCategoryIndex = categories.length - 1;

                }
                if (serie.data.length - 1  < existingCategoryIndex)
                    serie.data.length = existingCategoryIndex + 1 ;
                serie.data[existingCategoryIndex] = itemData;
            }


            for (var i = 0; i < series.length; i++) {
                series[i].data.length = categories.length;
                for (var j = 0; j < series[i].data.length; j++) {
                    series[i].data[j] = series[i].data[j] || null;
                }
            }

            if (pieIncrement > 0) {
                var pieSerie = series[0];
                pieSerie["type"] = "pie";
                var data = pieSerie.data;
                pieSerie.data = [];
                for (var i = 0; i < categories.length; i++) {
                    var arr = [categories[i]];
                    arr.push(data[i]);
                    pieSerie.data.push(arr);
                }
            }

            var chartView = {
                chart: {
                    type: Common.highChartType[chart.ChartType]
                },
                xAxis: {
                    categories: categories,
                    title: {
                        text: null
                    }
                },

                credits: {
                    enabled: false
                },

                yAxis: {
                    title: {
                        text: res.Headers[res.Headers.length - 1].Caption
                    }
                },

                title: {
                    text: chart.Header
                },
                subtitle: {
                    text: chart.Footer
                },
                
                series: series
            }

            this.lastChartData = chartView;
            try {
                var theme = eval("(" + chart.Theme + "Theme)");
                this.chartTheme = theme;
            } catch (e){
                console.log("Error setting chart theme");
                if (chartModule.defaultOptions)
                    this.chartTheme = chartModule.defaultOptions;
            }
            if (chart.Height && chart.Height != '')
                this.chartHeight = chart.Height;
            else delete this.chartHeight;
            this.createChart(chartView);

        },



        this.createChart = function (chartData) {
            var self = this;
            libDefer.then(function () {

                if (!chartModule.defaultOptions)
                    chartModule.defaultOptions = Highcharts.getOptions();

                if (self.chart) {
                    self.chart.destroy();
                    delete self.chart;
                }

                var size = self.context.pane.getDashletSize();

                if (!chartData) {
                    chartData = self.lastChartData || self.defaultChartData();
                }

                var chart = chartData.chart || {};

                chartData.chart = self.context.fn.lang.mixin(chart, {
                    renderTo: self.dashletNode,
                    height: size.h == 0 ? (self.chartHeight ? self.chartHeight: 400)  : size.h,
                    width: size.w == 0 ? 300 : size.w,
                    reflow: false
                });
                if (self.chartTheme)
                    Highcharts.setOptions(self.chartTheme);
                self.chart = new Highcharts.Chart(chartData);

            });
        },

        this.destroyRecursive = function () {
            if (this.chart) {
                this.chart.destroy();
                delete this.chart;
            }
        }



        this.getNow = function () {
            var now = new Date();

            return {
                hours: now.getHours() + now.getMinutes() / 60,
                minutes: now.getMinutes() * 12 / 60 + now.getSeconds() * 12 / 3600,
                seconds: now.getSeconds() * 12 / 60
            };
        };

        this.startup = function () {
            var self = this;

            this.context.setBusy("Loading chart library");

            var path = require.toUrl("../../Resource/JavaScript/highcharts.js");
            var jqpath = require.toUrl("../../Resource/JavaScript/jquery.js");



            function buildChart() {
                if (!self.constructor.defaultOptions)
                    self.constructor.defaultOptions = Highcharts.getOptions();

                libDefer.resolve();
                //self.createChart();
                self.context.clearBusy();
            }

            if (typeof jQuery != "undefined") {
                require([path], function () {
                    buildChart();

                }, function () {
                    self.context.clearBusy();
                });
            } else

                require([jqpath], function () {
                    require([path], function () {
                        buildChart();

                    }, function () {
                        self.context.clearBusy();
                    });

                });




            this.context.subscribe('jdash/dashlet/visualStateChanged', function (event) {
                if (event.sender == this) {
                    var newHeight = event.args.height;
                    setTimeout(self.refresh(true, newHeight), 50);
                }
            });

            this.context.subscribe('jdash/dashlet/visualStateChanging', function (event) {
                if (event.sender == this) {
                    var size = self.context.pane.getDashletSize();
                    event.args.height = size.h;
                    self.context.fn.domStyle.set(self.dashletNode, "display", "none");
                }
            });

            this.context.subscribe('klt/viewport/resized', function (event) {
                var size = self.context.pane.getDashletSize();
                self.refresh(true, size.h);
            });

            this.context.subscribe("jdash/layout/dnd/dropped", function (event) {
                if (self.context.pane == event.args.pane) {
                    var size = self.context.pane.getDashletSize();
                    self.refresh(true, size.h);
                }
            });

        }
    }

    return chartModule;
});


