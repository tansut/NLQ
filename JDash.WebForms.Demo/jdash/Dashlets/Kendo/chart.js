define(["require", "klt/core/Deferred"],
function (require, Deferred) {
    return function (params, node) {
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
                //this.chart.setSize(size.w == 0 ? 300 : size.w, size.h == 0 ? 400 : newHeight, false);
                this.context.fn.domStyle.set(this.dashletNode, "display", "");
                this.createChart();
            } else this.createChart();
        }




        this.createChart = function () {
            var self = this;
            libDefer.then(function () {

                var options = self.chartOptions;
                var data = options.data;

                var size = self.context.pane.getDashletSize();

                var chartType = options.type || 'bar';
                console.log(chartType);

                $(dashletNode).kendoChart({
                    title: {
                        text: "Site Visitors Stats /thousands/"
                    },
                    legend: {
                        visible: false
                    },
                    seriesDefaults: {
                        type: chartType
                    },
                    series: [{
                        name: "Total Visits",
                        data: data.totalVisits
                    }, {
                        name: "Unique visitors",
                        data: data.uniqueVisitors
                    }],
                    valueAxis: {
                        max: 100,
                        line: {
                            visible: false
                        },
                        minorGridLines: {
                            visible: true
                        }
                    },
                    categoryAxis: {
                        categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                        majorGridLines: {
                            visible: false
                        }
                    },
                    tooltip: {
                        visible: true,
                        template: "#= series.name #: #= value #"
                    }
                });



            });
        },

        this.destroyRecursive = function () {
            //TODO: Cleanup Kendo Chart (Destroy)
        }



        this.startup = function () {
            var self = this;

            this.context.setBusy("Loading chart library");

            var path = require.toUrl("../../Resource/JavaScript/Kendo/js/kendo.dataviz.min.js");



            function buildChart() {
                libDefer.resolve();
                //self.createChart();
                self.context.clearBusy();
            }


            require([path], function () {
                buildChart();
            }, function () {
                self.context.clearBusy();
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

            this.publishEvent = function (event) {
                self.context.publish('jdash/layout/changed', event);
            }
        }
    }
});


