define(["require", "./Common", "klt/core/Deferred"],

function (require, common, Deferred) {
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

        this.setOptions = function (value) {
            this.chartOptions = value;
            this.createChart();
        }



        this.refresh = function (redrawOnly, newHeight) {
            if (redrawOnly) {
                var size = this.context.pane.getDashletSize();
                this.context.fn.domStyle.set(this.dashletNode, "display", "");
                // this.createChart();
            }
            $(dashletNode).data("kendoChart").refresh();
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

            var pieIncrement = (chart.ChartType == common.chartType.pie ? 1 : 0);

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
                if (serie.data.length - 1 < existingCategoryIndex)
                    serie.data.length = existingCategoryIndex + 1;
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
            var rotationval = -90;
            var valueroation = 0;
            if (common.highChartType[chart.ChartType] == "bar") {
                rotationval = 0;
                valueroation = -90;
            }
            var chartView = $(dashletNode).kendoChart({
                theme: "blueopal",
                title: {
                    text: chart.Header
                },
                legend: {
                    visible: true
                },
                seriesDefaults: {
                    type: common.highChartType[chart.ChartType]
                },
                series: series,
                valueAxis: {
                    labels: {
                        rotation: valueroation,
                        step: 1,
                        skip: 0
                    },
                    line: {
                        visible: false
                    },
                    minorGridLines: {
                        visible: false
                    }
                },
                categoryAxis: {
                    labels: {
                        rotation: rotationval,
                        step: 1,
                        skip: 0
                    },
                    categories: categories,
                    majorGridLines: {
                        visible: false
                    }

                }
            ,
                tooltip: {
                    visible: true,
                    template: "#= series.name #: #= value #"
                }
            });

            this.lastChartData = chartView;
            //try {
            //    var theme = eval("(" + chart.Theme + "Theme)");
            //    this.chartTheme = theme;
            //} catch (e) {
            //    console.log("Error setting chart theme");
            //    if (chartModule.defaultOptions)
            //        this.chartTheme = chartModule.defaultOptions;
            //}
            if (chart.Height && chart.Height != '')
                this.chartHeight = chart.Height;
            else delete this.chartHeight;
            this.createChart(chartView);

        },


                this.createChart = function (chartData) {
                    var self = this;
                    libDefer.then(function () {
                        //  alert($(dashletNode).data("kendoSkin"));
                        if (!chartModule.defaultOptions)
                            chartModule.defaultOptions = kendo.options();// changeTheme('blueopal');

                        if (self.chart) {
                            self.chart.destroy();
                            delete self.chart;
                        }

                        var size = self.context.pane.getDashletSize();

                        if (!chartData) {
                            chartData = self.lastChartData || self.defaultChartData();
                        }

                        //  var chart = chartData.chart || {};

                        //chartData.chart = self.context.fn.lang.mixin(chart, {
                        //    renderTo: self.dashletNode,
                        //    height: size.h == 0 ? (self.chartHeight ? self.chartHeight : 200) : size.h,
                        //    width: size.w == 0 ? 200 : size.w,
                        //    reflow: false
                        //});
                        if (self.chartTheme)
                            $(dashletNode).bind("kendo:skinChange");

                        self.chart = $(dashletNode).kendoChart(chartData);

                    });
                },

        //this.destroyRecursive = function () {
        //    //TODO: Cleanup Kendo Chart (Destroy)
        //    if (this.chart) {
        //       // var d = [];
        //       // this.chart.dataSource.data(d);
        //        this.chart.destroy();
        //        this.chart.remove();

        //    }
        //}



        this.startup = function () {



            var self = this;

            this.context.setBusy("Loading chart library");

            var path = require.toUrl("../../Resource/JavaScript/Kendo/2013.3.1119_js/kendo.dataviz.min.js");
            var jqpath = require.toUrl("../../Resource/JavaScript/jquery.js");
            //var kendocommonpath = require.toUrl("../../Resource/JavaScript/Kendo/css/kendo.common.min.css");
            //var kendothemepath = require.toUrl("../../Resource/JavaScript/Kendo/css/kendo.common.blueopal.min.css");
            //var kendodatavizpath = require.toUrl("../../Resource/JavaScript/Kendo/css/kendo.dataviz.min.css");
            //var kendodatavizthemepath = require.toUrl("../../Resource/JavaScript/Kendo/css/kendo.dataviz.blueopal.min.css");


            function buildChart() {
                if (!self.constructor.defaultOptions)
                    self.constructor.defaultOptions = changeTheme('blueopal');

                libDefer.resolve();
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

            //  var self = this;

            //  this.context.setBusy("Loading chart library");





            //function buildChart() {
            //    libDefer.resolve();
            //    //self.createChart();
            //    self.context.clearBusy();
            //}


            //require([path], function () {
            //    buildChart();
            //}, function () {
            //    self.context.clearBusy();
            //});






            this.context.subscribe('jdash/dashlet/visualStateChanged', function (event) {
                if (event.sender == this) {
                    var newHeight = event.args.height;
                    //  var chartDataRefresh=self.lastChartData;

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

            this.publishEvent = function (event) {
                self.context.publish('jdash/layout/changed', event);
            }
        }
    }

    return chartModule;
    // loads new stylesheet
    function changeTheme(skinName, animate) {
        var doc = document,
            kendoLinks = $("link[href*='kendo.']", doc.getElementsByTagName("head")[0]),
            commonLink = kendoLinks.filter("[href*='kendo.common']"),
            skinLink = kendoLinks.filter(":not([href*='kendo.common'])"),
            href = location.href,
            skinRegex = /kendo\.\w+(\.min)?\.css/i,
            extension = skinLink.attr("rel") === "stylesheet" ? ".css" : ".less",
            url = commonLink.attr("href").replace(skinRegex, "kendo." + skinName + "$1" + extension),
            exampleElement = $("#example");

        function preloadStylesheet(file, callback) {
            var element = $("<link rel='stylesheet' media='print' href='" + file + "'").appendTo("head");

            setTimeout(function () {
                callback();
                element.remove();
            }, 100);
        }

        function replaceTheme() {
            var oldSkinName = $(doc).data("kendoSkin"),
                newLink;

            // if ($.browser.msie) {
            //    newLink = doc.createStyleSheet(url);
            //  } else {
            newLink = skinLink.eq(0).clone().attr("href", url);
            // }

            newLink.insertBefore(skinLink[0]);
            skinLink.remove();

            $(doc.documentElement).removeClass("k-" + oldSkinName).addClass("k-" + skinName);
        }

        if (animate) {
            preloadStylesheet(url, replaceTheme);
        } else {
            replaceTheme();
        }
    };
});


