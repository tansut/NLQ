define(["require", "./Common", "klt/core/Deferred"],
    function (require, Common, Deferred) {
        var geoModule = function (params, node) {
            var context = this.context = params.context;
            var domNode = this.domNode = node || document.createElement("div");

            var dashletNode = this.dashletNode = document.createElement("div");
            domNode.appendChild(dashletNode);

            this.mapNode = document.createElement("div")
            this.mapNode.className = "map";
            this.dashletNode.appendChild(this.mapNode);


            var libDefer = new Deferred();

            this._handleDomUpdate = function (newNode, insideOnly) {
                if (!insideOnly)
                    domNode = this.domNode = newNode;
                domNode.appendChild(dashletNode);
            }

            this._handleDomUpdating = function () {
                this.domNode.removeChild(this.dashletNode);
            }

            this.edge = function (a, b) {
                var dx = a[0] - b[0], dy = a[1] - b[1];
                return {
                    source: a,
                    target: b,
                    distance: Math.sqrt(dx * dx + dy * dy)
                };
            }


            var self = this;
            this.scrollNode = document.createElement("div");
            this.scrollNode.className = "scroller";
            this.scrollNode.appendChild(document.createElement("div"));

            this.scrollNode.onscroll = function () {
                if (self.pivotData) {
                    if (self.playing)
                        self.stopPivotPlay();
                    var n = parseInt(this.scrollLeft / ((this.scrollWidth - this.clientWidth) / (self.pivotData.length)));
                    if (n != self.pivotIndex && this.scrollLeft / ((this.scrollWidth - this.clientWidth)) != 1)
                        self.changeCurrentPivot(n);

                }
            }
            this.dashletNode.appendChild(this.scrollNode);
            this.refresh = function (redrawOnly, newHeight) {
                this.drawMap();
            }

            this.getColor = function (value) {


                var resolver = 1 - (value / self.maxValue);
                return value ? d3.rgb(Math.floor(180 * resolver + 70), 0, 0) : d3.rgb(200, 200, 200);
                //return value ? d3.rgb(255-Math.floor((value * 255) / self.maxValue), 0, 0) : d3.rgb(200, 200, 200);

            }

            this.drawMap = function (data, clearData) {
                if (clearData) {
                    this.stopPivotPlay();
                    this.cities = null;
                    this.data = null;
                    this.pivotData = null;
                    this.maxValue = null;
                    this.minValue = null;

                }
                if (data)
                    this.data = data;

                d3.select(self.mapNode).select("svg").remove();
                self.mapNode.innerHTML = "";
                d3.select(this.dashletNode).style("position", "relative");




                if (self.cities) {
                    self.buildSVG(self.cities);
                } else {
                    d3.json("/jdash/Resource/JavaScript/tr.js", function (cities) {
                        self.buildSVG(cities);
                        self.cities = cities;
                    });
                }
            }

            this.buildSVG = function (cities) {

                if (self.data)
                    cities = self.refineData(cities, self.data);
                var nodes = [],
                    links = [];

                var w = this.context.pane.getDashletSize().w, h = this.context.pane.getDashletSize().w / 2;
                var scaleNorm = w / 1280;
                if (scaleNorm > 1280) scaleNorm = 1;

                this.tooltip = d3.select(this.mapNode)
                .append("div")
                .style("position", "absolute")
                .style("", "absolute")
                .style("z-index", "10")
                .attr("class", "well")
                .style("visibility", "hidden");

                self.svg = d3.select(this.mapNode).append("svg:svg")
                     .attr("width", w)
                     .attr("height", h);
                self.dashletNode.style.width = w + "px";
                self.dashletNode.style.height = h + 36 + "px";

                var projection = d3.geo.mercator()
                .scale(22900 * scaleNorm)
                .translate([-1600 * scaleNorm, 3050 * scaleNorm]);
                var path = d3.geo.path().projection(projection);
                cities.features.forEach(function (d, i) {

                    var centroid = path.centroid(d);
                    centroid.x = centroid[0];
                    centroid.y = centroid[1];
                    centroid.feature = d;
                    nodes.push(centroid);
                });

                d3.geom.delaunay(nodes).forEach(function (d) {
                    links.push(self.edge(d[0], d[1]));
                    links.push(self.edge(d[1], d[2]));
                    links.push(self.edge(d[2], d[0]));
                });



                var node = self.svg.selectAll("g")
                    .data(nodes)
                  .enter().append("svg:g")
                    .attr("transform", function (d) { return "translate(" + -d.x + "," + -d.y + ")"; })
                  .append("svg:path")
                    .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; })
                    .attr("d", function (d) { return path(d.feature); })
                    .style("fill",
                        function (d) {
                            if (d.feature.Value) {
                                return self.getColor(d.feature.Value);
                            }
                            else
                                return self.getColor(false);
                        })
                    .text(function (d) {
                        return d.feature.properties.ad + " : " + (d.feature.formatedValue ? d.feature.formatedValue : "");
                    })
                    .on("mouseover", function () {
                        d3.select(this).style("fill", "gold");
                        return self.tooltip.style("visibility", "visible");
                    })
                    .on("mousemove", function (pos) {
                        self.tooltip.text(d3.select(this).text());
                        return self.tooltip.style("top", (event.offsetY - 10) + "px").style("left", (event.offsetX + ((event.offsetX < self.dashletNode.offsetWidth / 2) ? 10 : -(self.tooltip[0][0].offsetWidth + 10))) + "px");
                    })
                    .on("mouseout", function (d) {
                        d3.select(this).style("fill", self.getColor(d.feature.Value || false));

                        return self.tooltip.style("visibility", "hidden");
                    });

                if (self.data) {
                    d3.select(self.mapNode)
                    .append("div")
                    .style("position", "absolute")
                    .style("width", "100%")
                    .style("top", "5px")
                    .style("z-index", "10").append("center").text(self.data.map.Title);

                    if (self.pivotData) {
                        d3.select(self.mapNode)
                         .append("div")
                         .style("position", "absolute")
                         .style("bottom", "30px")
                         .style("right", "10px")
                            .style("color", "#ccc")
                            .style("font-size", "15pt")
                         .style("z-index", "10").append("b").text(self.pivotData[self.pivotIndex || 0]);

                        d3.select(self.mapNode)
                        .append("button")
                        .style("position", "absolute")
                        .style("bottom", "30px")
                        .style("left", "10px")
                        .on("click", function (d) {

                            if (self.playing) {
                                self.stopPivotPlay();
                                d3.select(this).html("&#9658; Oynat");
                            } else {

                                self.stopPivotPlay();
                                self.playInterval = setInterval(function () {
                                    self.changeCurrentPivot();
                                }, 750);
                                self.playing = true;
                            }
                        })
                        .style("z-index", "10").html(function (d, i) { return self.playing ? "Durdur" : "&#9658; Oynat"; });

                    }

                    d3.select(self.mapNode)
                     .append("div")
                     .style("position", "absolute")
                     .style("bottom", "43px")
                     .style("left", !self.pivotData ? "10px" : "90px")
                     .style("background-color", self.getColor(self.maxValue).toString())
                     .style("width", "10px")
                     .style("height", "10px");

                    d3.select(self.mapNode)
                     .append("div")
                     .style("position", "absolute")
                     .style("bottom", "30px")
                     .style("left", !self.pivotData ? "10px" : "90px")
                     .style("background-color", self.getColor(self.minValue).toString())
                     .style("width", "10px")
                     .style("height", "10px");

                    d3.select(self.mapNode)
                     .append("span")
                     .style("position", "absolute")
                     .style("bottom", "40px")
                     .style("left", !self.pivotData ? "25px" : "105px")
                     .html(self.maxValueFormatted);

                    d3.select(self.mapNode)
                        .append("span")
                        .style("position", "absolute")
                        .style("bottom", "25px")
                        .style("left", !self.pivotData ? "25px" : "105px")
                        .html(self.minValueFormatted);

                }


            }
            this.stopPivotPlay = function () {
                if (self.playInterval) clearInterval(self.playInterval);
                self.playing = false;
            }

            this.changeCurrentPivot = function (n) {
                if (n != null) self.pivotIndex = n;
                else {
                    if (self.pivotIndex) self.pivotIndex++;
                    else
                        self.pivotIndex = 1;
                }
                if (self.pivotIndex > self.pivotData.length - 1)
                    self.pivotIndex = 0;
                setTimeout(self.refresh(true), 50);
            }
            this.refineData = function (geoData, analyticData) {
                if (!analyticData || !geoData)
                    return geoData;


                if (analyticData.map.HasPivot)
                    self.buildpivotData(analyticData.data.Items);

                var measureIndex = 0;
                for (var i = 0; i < analyticData.data.Headers.length; i++) {
                    if (analyticData.data.Headers[i].HeaderType == 1) {
                        measureIndex = i;
                        break;
                    }
                }
                self.minValue = self.maxValue = null;
                for (var j = 0; j < geoData.features.length; j++) {
                    geoData.features[j].Value = null;
                    geoData.features[j].formatedValue = null;
                    for (var i = 0; i < analyticData.data.Items.length; i++) {

                        if (analyticData.data.Items[i][analyticData.data.Items[i].length - 2].Value == geoData.features[j].properties.plakano) {
                            if (self.pivotData) {
                                var pivotValue = self.pivotIndex ? self.pivotData[self.pivotIndex] : self.pivotData[0];
                                if (analyticData.data.Items[i][0].FormattedValue != pivotValue)
                                    continue;

                            }
                            geoData.features[j].Value = analyticData.data.Items[i][measureIndex].Value;
                            geoData.features[j].formatedValue = analyticData.data.Items[i][measureIndex].FormattedValue;
                            if (!self.maxValue || parseInt(self.maxValue) < parseInt(geoData.features[j].Value)) {
                                self.maxValue = geoData.features[j].Value;
                                self.maxValueFormatted = geoData.features[j].formatedValue;
                            } else if (!self.minValue || parseInt(self.maxValue) > parseInt(geoData.features[j].Value)) {
                                self.minValue = geoData.features[j].Value;
                                self.minValueFormatted = geoData.features[j].formatedValue;

                            }
                        }
                    }
                }

                return geoData;
            }
            this.buildpivotData = function (data) {

                if (self.pivotData) return;
                if (data[0].length != 3) return;
                this.scrollNode.style.display = "block";
                self.pivotData = [];
                for (var i = 0; i < data.length; i++) {
                    var pivotValue = data[i][0].FormattedValue;
                    var isExists = false;
                    for (var j = 0; j < self.pivotData.length; j++) {
                        if (self.pivotData[j] == pivotValue) {
                            isExists = true;
                            break;
                        }
                    }
                    if (!isExists)
                        self.pivotData.push(pivotValue)
                }
            }
            this.initD3 = function () {
                var d3Path = require.toUrl("../../Resource/JavaScript/d3.js");
                var d3GeoPath = require.toUrl("../../Resource/JavaScript/d3.geo.js");
                var d3GeomPath = require.toUrl("../../Resource/JavaScript/d3.geom.js");
                var d3Layout = require.toUrl("../../Resource/JavaScript/d3.layout.js");



                require([d3Path], function () {
                    require([d3GeoPath], function () {
                        require([d3GeomPath], function () {
                            require([d3Layout], function () {

                                self.drawMap();

                            });
                        })
                    });
                });
            }
            this.destroyRecursive = function () {
                this.stopPivotPlay();
            }


            this.startup = function () {
                if (this.data == null)
                    this.initD3();
                this.context.subscribe('jdash/dashlet/visualStateChanged', function (event) {
                    if (event.sender == this) {
                        setTimeout(self.refresh(true), 50);
                    }
                });

                this.context.subscribe('jdash/dashlet/visualStateChanging', function (event) {
                    if (event.sender == this) {
                        setTimeout(self.refresh(true), 50);
                    }
                });

                this.context.subscribe('klt/viewport/resized', function (event) {
                    setTimeout(self.refresh(true), 50);
                });

                this.context.subscribe("jdash/layout/dnd/dropped", function (event) {
                    if (self.context.pane == event.args.pane) {
                        setTimeout(self.refresh(true), 50);
                    }
                });

            }



        }

        return geoModule;
    });


