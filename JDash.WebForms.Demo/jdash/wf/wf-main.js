define(["require",
        "dojo/i18n!jdash/nls/language",
        "dojo/_base/declare",
        "jdash/ui/DashboardView",
        "jdash/ui/Button",
        "dojo/dom",
        "dojo/query",
        "dojo/NodeList-traverse",
        "jdash/ui/registry",
        "jdash/model/DashletModel",
        "jdash/model/DashboardModel",
        "jdash/model/DashletModuleModel",
        "dojo/_base/lang",
        "dojo/_base/array",
        "dojo/dom-attr",
        "dojo/Deferred",
        "dojo/json",
        "klt/core/when",
        "dojo/dom-class",
        "dojo/dom-construct",
        "jdash/ui/ThemeManager",
         "jdash/layout/LayoutManager",
         "jdash/ui/DashletStylesList",
         "jdash/ui/ThemeStylesList",
         "jdash/ui/TitleEditor",
         "dojo/_base/fx",
         "dojo/dom-style",
         "jdash/ui/DashletPane",
         "jdash/ui/DashletEditView",
         "jdash/ui/DashletPropertyEditor",
         "jdash/core/DashletContext",
         "dojo/promise/all",
         "dojo/Stateful",
        "klt/domReady!"],
function (require, language, declare, DashboardView, Button, dom, query, traverse, registry, DashletModel, DashboardModel, DashletModuleModel, lang, array, attr, Deferred,
    json, when, domClass, domConstruct, ThemeManager, LayoutManager, DashletStylesList, ThemeStylesList, DashletTitleEditor, fx, domStyle, DashletPane, DashletEditView, DashletPropertyEditor, DashletContext, all, Stateful) {

    var msAjax = {

        init: function () {

            var self = this;

            var pbQueue = new Array();
            var argsQueue = new Array();

            Sys.WebForms.PageLoadingEventArgs = function Sys$WebForms$PageLoadingEventArgs(panelsUpdating, panelsDeleting, dataItems) {
                var e = Function._validateParams(arguments, [
                    { name: "panelsUpdating", type: Array },
                    { name: "panelsDeleting", type: Array },
                    { name: "dataItems", type: Object, mayBeNull: true }
                ]);

                Sys.WebForms.PageLoadingEventArgs.initializeBase(this);
                this._panelsUpdating = panelsUpdating;
                this._panelsDeleting = panelsDeleting;
                this._dataItems = dataItems || new Object();
            }
            function Sys$WebForms$PageLoadingEventArgs$get_dataItems() {
                if (arguments.length !== 0) throw Error.parameterCount();
                return this._dataItems;
            }
            function Sys$WebForms$PageLoadingEventArgs$get_panelsDeleting() {
                if (arguments.length !== 0) throw Error.parameterCount();
                return this._panelsDeleting;
            }
            function Sys$WebForms$PageLoadingEventArgs$get_panelsUpdating() {
                if (arguments.length !== 0) throw Error.parameterCount();
                return this._panelsUpdating;
            }
            Sys.WebForms.PageLoadingEventArgs.prototype = {
                get_dataItems: Sys$WebForms$PageLoadingEventArgs$get_dataItems,
                get_panelsDeleting: Sys$WebForms$PageLoadingEventArgs$get_panelsDeleting,
                get_panelsUpdating: Sys$WebForms$PageLoadingEventArgs$get_panelsUpdating
            }

            function ApplicationInit(sender, args) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (!prm.get_isInAsyncPostBack()) {
                    prm.add_initializeRequest(InitializeRequestHandler);
                    prm.add_pageLoading(PageLoadingHandler);
                    prm.add_beginRequest(BeginRequestHandler);
                    prm.add_pageLoaded(PageLoadedHandler);
                    prm.add_endRequest(EndRequestHandler);
                }
            }

            function InitializeRequestHandler(sender, args) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
            }


            function BeginRequestHandler(sender, args) {
                Sys.WebForms.PageRequestManager.getInstance()._scrollPosition = null;
                var prm = Sys.WebForms.PageRequestManager.getInstance();
            }

            function EndRequestHandler(sender, args) {
            }

            function PageLoadingHandler(sender, args) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                var updatedPanels = args.get_panelsUpdating();
                var deletedPanels = args.get_panelsDeleting();
                var dashboardsUpdated = [];
                array.forEach(updatedPanels, function (up) {
                    if (domClass.contains(up, "wfDashboardContainer")) {
                        domStyle.set(up.parentNode, "opacity", "0");
                        var dashlets = query(".wfDashletContainer", up);
                        var editors = query(".wfDashletEditorContainer", up);
                        dashlets.forEach(function (dashlet) {
                            domStyle.set(dashlet, "display", "none");
                            domConstruct.place(dashlet, up);
                        })
                        editors.forEach(function (editor) {
                            domStyle.set(editor, "display", "none");
                            domConstruct.place(editor, up);
                        })
                        var parent = up.parentNode;
                        var dashboard = util.getCmpByNode(up.id);
                        if (dashboard) {
                            domConstruct.place(dashboard.domNode, parent);
                            dashboardsUpdated.push(up);
                        }

                    }
                });


                array.forEach(deletedPanels, function (up) {
                    if (!up)
                        return;
                    array.forEach(dashboardsUpdated, function (dup) {
                        var did = attr.get(up, "data-jdash-dashletId");
                        if (did && up.parentNode === dup)
                            up.__dontDestroy = true;
                    });

                    var did = attr.get(up, "data-jdash-dashletId");
                    if (did && typeof up.__dontDestroy == "undefined") {
                        //domConstruct.destroy(up);
                    } else delete up.__dontDestroy;
                    if (domClass.contains(up, "wfDashletContainer")) {
                        var dashboard = util.getCmp(attr.get(up, "data-jdash-ownerDashboard"));
                        if (dashboard) {
                            var context = dashboard.getContext(did);
                            try {
                                context._wfDashletDestroying(true);
                            } catch (e) {
                                console.log("Error in deleting update panel of dashlet " + did + ".Err: " + e.message);
                            }
                        }
                    }

                });

            }

            function PageLoadedHandler(sender, args) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                var updatedPanels = args.get_panelsUpdated();
                var createdPanels = args.get_panelsCreated();

                var dashboardsUpdated = [];

                array.forEach(updatedPanels, function (up) {
                    if (domClass.contains(up, "wfDashboardContainer")) {
                        setTimeout(function () {
                            domStyle.set(up.parentNode, "opacity", "1");
                        });
                        var dashboard = util.getCmpByNode(up.id);
                        if (dashboard) {
                            domConstruct.place(dashboard.domNode, up);
                            dashboardsUpdated.push(up);
                        }


                    }
                });
                array.forEach(updatedPanels, function (up) {
                    if (!up)
                        return;
                    array.forEach(dashboardsUpdated, function (dup) {
                        var did = attr.get(up, "data-jdash-dashletId");
                        if (did && up.parentNode === dup)
                            up.__dontUpdate = true;
                    });

                    var did = attr.get(up, "data-jdash-dashletId");
                    if (did && typeof up.__dontUpdate == "undefined") {
                        if (domClass.contains(up, "wfDashletContainer")) {

                            var dashboard = util.getCmp(attr.get(up, "data-jdash-ownerDashboard"));
                            if (dashboard) {
                                var context = dashboard.getContext(did);
                                try {
                                    context._wfReloadDashlet(true);
                                } catch (e) {
                                    console.log("Error in partial update of dashlet " + did + ".Err: " + e.message);
                                }
                            }
                        }

                    } else delete up.__dontUpdate;
                });
            }



            var app = Sys.Application;
            app.add_init(ApplicationInit);
        }



    }

    var util = {

        callObject: function (scope, method, params) {
            var f = lang.getObject(method, false, scope);
            var parts = method.split('.');
            if (parts.length > 1) {
                for (var i = 0; i < parts.length - 1; i++) {
                    scope = scope[parts[i]];
                }
            }
            try {
                f.apply(scope, params);
            } catch (e) {
                throw e;
            }
        },

        makeVisible: function (node, duration) {
            domStyle.set(node, "display", "");
            if (node && domStyle.get(node, "opacity") == "0") {
                fx.fadeIn({
                    node: node,
                    duration: 250
                }).play();
            }
        },

        destroyInnerWidgets: function (node) {
            var widgets = registry.findWidgets(node);
            array.forEach(widgets, function (widget) {
                if (lang.isFunction(widget.destroyRecursive))
                    widget.destroyRecursive();
            });
        },

        getCommand: function (name, args) {
            return {
                Name: name,
                Parameters: args || {}
            }
        },

        getPostbackResult: function (key) {
            this.__postbackResult = this.__postbackResult || {};
            var res = this.__postbackResult[key];
            delete this.__postbackResult[key];
            return res;
        },

        setPostbackResult: function (key, value) {
            this.__postbackResult = this.__postbackResult || {};
            this.__postbackResult[key] = value;
        },


        postback: function (eventName, eventArgs, result, scope, maskCtrl) {

            var defer = new Deferred();
            var self = this;

            function clearPostBack(sender, args) {
                dom.byId('__EVENTTARGET').value = dom.byId('__EVENTARGUMENT').value = '';
                Sys.WebForms.PageRequestManager.getInstance().remove_endRequest(clearPostBack);
                var err = args.get_error();
                if (err != undefined) {
                    defer.reject(err);
                } else {
                    var res = null;
                    if (lang.isFunction(result))
                        res = result.apply(scope || self);
                    else res = result;
                    defer.resolve(res);
                }
            }


            function myPostBack(eventTargetClientId, eventArgument) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(clearPostBack);
                __doPostBack(eventTargetClientId, eventArgument);
            }

            if (maskCtrl && maskCtrl.setOverlayDefer)
                maskCtrl.setOverlayDefer(defer);

            myPostBack(eventName.replace(/_/g, '$'), eventArgs);

            return defer;
        },

        createCmpSync: function (clazz, properties, nodeid, callback, scope, useNode) {
            var instance = new clazz(properties, useNode ? nodeid : null);

            if (!useNode)
                instance.placeAt(nodeid);
            if (callback)
                callback.apply(scope, [instance]);
            instance.startup();
            return instance;
        },

        createCmp: function (modules, properties, nodeid, callback, scope) {
            var self = this;
            require(modules, function (module, dom) {
                self.createCmpSync(module, properties, nodeid, callback, scope);
            })
        },

        getCmp: function (id) {
            var widget = registry.byId(id);
            if (!widget)
                console.log("WARN: Cannot find Widget using id:" + id);
            return widget;
        },

        getCmpByNode: function (nodeid) {
            var widget = registry.byId(nodeid + "Widget");
            if (!widget)
                console.log("WARN: Cannot find Widget using domId:" + nodeid);
            return widget;
        },

        destroyCmp: function (id) {
            var widget = registry.byId(id);
            if (widget) {
                widget.destroyRecursive();
                console.log(id + " destroyed");
            } else console.log("WARN: Cannot find Widget using id:" + id);
        }

    }

    var wfProvider = function (dashboard, dashlets, modules, dashletNodes, dashletEditorNodes, dashboardView, updatePanelNode) {

        this.dashboard = dashboard;
        this.dashlets = dashlets;
        this.dashboardView = dashboardView;
        this.dashletNodes = dashletNodes;
        this.editorNodes = dashletEditorNodes;
        this.modules = modules;
        this.updatePanelNode = updatePanelNode;


        this.getServerPostId = function () {
            return this.dashboardView._wfServerpostid;
        }

        this.changeDashboardLayout = function (layout, updatedPositions) {
            var command = util.getCommand("changeDashboardLayout", { layout: layout, updatedPositions: updatedPositions });
            var defer = util.postback(this.getServerPostId(), json.stringify(command));
            return new Deferred();
        }

        this.createDashlet = function (model, newPositions) {

            var returnDefer = new Deferred();
            if (typeof this._returnFromUpdate === "undefined") {
                var command = util.getCommand("createDashlet", { model: model.serialized(), newPositions: newPositions });
                var defer = util.postback(this.getServerPostId(), json.stringify(command), null, null, this.dashboardView);
                defer.then(function () {
                    returnDefer.reject();
                }, function () {
                    returnDefer.reject();
                });
            } else returnDefer.resolve(model);

            return returnDefer;
        }

        this.saveDashboard = function (model) {
            //var command = util.getCommand("saveDashboard", { model: model });
            //var defer = util.postback(this.getServerPostId(), json.stringify(command));
        },

        this.getDashletModule = function (moduleId) {
            for (var i in this.moduleObjects) {
                var module = this.moduleObjects[i];
                if (module.id === moduleId)
                    return module;
            }
            throw new Error("Cannot find moduleId " + moduleId);
        }

        this.getDashlet = function (moduleId) {
            for (var i in this.dashletObjects) {
                var module = this.dashletObjects[i];
                if (module.id === moduleId)
                    return module;
            }
            throw new Error("Cannot find dashletid " + moduleId);
        }



        this.getDashletModel = function (id) {
            for (var i in this.dashlets) {
                var dashlet = this.dashlets[i];
                if (dashlet.id === id)
                    return dashlet;
            }
        }


        this.deleteDashlet = function (id) {
            var command = util.getCommand("deleteDashlet", { id: id, __relatedDashletId: id });
            var defer = util.postback(this.getServerPostId(), json.stringify(command));
            //var defer = util.postback(this.getServerPostId(), json.stringify(command), null, null, this.dashboardView);
            return defer;
        },

        this.updateDashletPositions = function (positions) {
            var command = util.getCommand("updateDashletPositions", { positions: positions });
            //return util.postback(this.getServerPostId(), json.stringify(command));
            return util.postback(this.getServerPostId(), json.stringify(command), null, null, this.dashboardView);
        },

        this._createSingleModel = function (items, modelClass) {
            items._serialized = true;
            var result = modelClass(items);
            delete items._serialized;
            return result;
        },

        this._createModels = function (items, modelClass) {
            var res = [];
            for (var i in items) {
                var item = items[i];
                res.push(this._createSingleModel(item, modelClass))
            }
            return res;
        },

        this.saveDashlet = function (model) {
            //var command = util.getCommand("saveDashlet", { model: model, __relatedDashletId: model.id });
            //return util.postback(this.getServerPostId(), json.stringify(command));
        },

         this.dashletConstructor = function () {

             var result = {

                 createDefer: function (context) {
                     var config = context._createDashletConfig();
                     var domNode = context.model.remoteNodes.dashlet;

                     if (context.model.module.path != "[WfDefault]") {
                         var defer = new Deferred();
                         require([context.model.module.path], function (module) {
                             var instance = new module(config, domNode);
                             defer.resolve(instance);
                         }, function (err) {
                             defer.reject(err);
                         })
                         return defer;
                     } else return new this.dashletConstructor(config, domNode);
                 },

                 dashletConstructor: function (params, node) {

                     var self = this;

                     this.destroyRecursive = function () {
                         array.forEach(self.__widgets, function (widget) {
                             if (lang.isFunction(widget.destroyRecursive))
                                 widget.destroyRecursive();
                         });
                     }

                     this.startup = function () {
                         setTimeout(function () {
                             self.__widgets = registry.findWidgets(self.domNode);
                         });
                     }


                     var context = this.context = params.context;
                     var domNode = this.domNode = params.context.model.remoteNodes.dashlet;
                 }
             }



             return result;
         },

        this.createEditorConstructor = function (wfProvider, info) {
            var result = {

                createDefer: function (params) {

                    function retConstructor() {
                        return this.editorConstructor;
                    }

                    var context = params.context.dashletContext;
                    var model = context.model;
                    var defer = new Deferred();

                    if (typeof model.remoteNodes.editor != "undefined" &&
                        !domClass.contains(model.remoteNodes.editor, "wfEditorControlLoaded")) {
                        var command = util.getCommand("openDashletEditor", { id: model.id, __relatedDashletId: model.id });
                        defer = util.postback(wfProvider.getServerPostId(), json.stringify(command), retConstructor, this);
                        return defer;
                    } else {
                        return this.editorConstructor;
                    }
                },


                editorConstructor: function (params, node) {

                    var self = this;

                    this.destroyRecursive = function () {
                        array.forEach(self.__widgets, function (widget) {
                            if (lang.isFunction(widget.destroyRecursive))
                                widget.destroyRecursive();
                        });
                    }

                    this.startup = function () {
                        setTimeout(function () {
                            self.__widgets = registry.findWidgets(self.domNode);
                        });
                    }


                    var context = this.context = params.context;
                    var model = context.dashletContext.model;

                    var domNode = this.domNode = context.dashletContext.model.remoteNodes.editor;
                    var updatePanelNode = context.dashletContext.dashboard.updatePanelNode;

                    setTimeout(function () {
                        util.makeVisible(domNode);
                    }, 50);

                    function manageClose(cmdName, args, context, detailed) {
                        if (context._wfReloading)
                            return;
                        var model = context.model;
                        var modelData = detailed ? {
                            title: model.title, paneConfig: {
                                "disableTheming": model.paneConfig.disableTheming,
                                "themeStyleId": model.paneConfig.themeStyleId,
                                "cssClass": model.paneConfig.get("cssClass")
                            }
                        } : null;
                        if (model._wfDiscardEvents && model._wfDiscardEvents.indexOf(cmdName) >= 0) {
                            var command = util.getCommand(cmdName, { action: args.args.action, id: model.id, __relatedDashletId: model.id, modelData: modelData });
                            var defer = util.postback(wfProvider.getServerPostId(), json.stringify(command));
                            domStyle.set(args.sender.editView.loadedView.domNode, "display", "none");

                        } else {
                            var command = util.getCommand(cmdName, { action: args.args.action, id: model.id, __relatedDashletId: model.id, modelData: modelData });
                            var defer = util.postback(wfProvider.getServerPostId(), json.stringify(command));
                            context.setBusy(defer);
                            args.nextDefer = defer;
                        }
                    }

                    this.context.subscribe("jdash/dashlet/editor/canceling", function (args) {
                        if (args.sender == this)
                            manageClose("cancelDashletEditor", args, this.dashletContext);
                    });

                    this.context.subscribe("jdash/dashlet/editor/validating", function (args) {
                        if (args.sender == this)
                            manageClose("validateDashletEditor", args, this.dashletContext, true);
                    });


                    this.context.subscribe("jdash/dashlet/editor/destroying", function (args) {
                        if (this.dashletContext._wfReloading)
                            return;
                        var model = this.dashletContext.model;
                        if (args.sender == this && args.args && args.args.reason) {
                            var editorContext = this;
                            domConstruct.place(domNode, updatePanelNode);
                            editorContext.initialNode = null;

                            if (domClass.contains(domNode, "wfEditorControlLoaded")) {
                                domClass.remove(domNode, "wfEditorControlLoaded");
                            }

                        } else if (args.sender == this) {
                        }
                    });
                }
            }

            return result;
        }


        this.getDashletsOfDashboard = function (dashboardId, withModules) {
            return this.dashletObjects;
        }

        this.getDashboard = function (id) {

            return this._createSingleModel(this.dashboard, DashboardModel);
        }

        this.init = function () {
            var self = this;
            var result = [];
            this.moduleObjects = [];
            this.dashletObjects = [];

            array.forEach(self.modules, function (module) {
                self.moduleObjects.push(self._createSingleModel(module, DashletModuleModel));
            });

            array.forEach(self.dashlets, function (dashlet) {
                var res = self._createSingleModel(dashlet, DashletModel);
                res.module = self.getDashletModule(res.moduleId);
                self.dashletObjects.push(res);
            });

            array.forEach(self.dashletNodes, function (node) {
                var nodeDashletId = attr.get(node, "data-jdash-dashletId");
                var dashletModel = self.getDashlet(nodeDashletId);
                dashletModel.remoteNodes = dashletModel.remoteNodes || {};

                var dashletNode = dom.byId(node.id);
                dashletModel.remoteNodes.dashlet = dashletNode;

                var module = dashletModel.module;

                module.dashletConstructor = new self.dashletConstructor(self, { model: dashletModel });

                var config = module.config;
                if (config.wfConfig.ec != null) {
                    module.editorConstructor = new self.createEditorConstructor(self, { model: dashletModel });
                    module.config.editor = module.config.editor || {};
                }

                result.push(dashletModel);
            }, self);

            array.forEach(self.editorNodes, function (node) {
                var nodeDashletId = attr.get(node, "data-jdash-dashletId");
                var dashletModel = self.getDashlet(nodeDashletId);
                dashletModel.remoteNodes = dashletModel.remoteNodes || {};

                var dashletNode = dom.byId(node.id);
                dashletModel.remoteNodes.editor = dashletNode;
            }, self);
        }

        this.init();
    }



    var wfButton = declare("jdash.wf.Button", Button, {
        postCreate: function () {
            this.on("Click", function () {
                return util.postback(query(this.domNode).parent()[0].id, '');
            }, this);
            this.inherited(arguments);
        }
    });

    var wfDashboardView = declare("jdash.wf.DashboardView", DashboardView, {

        wfCreateDashlet: function (props) {
            var self = this;
            var newDashlets = props.newDashlets;
            delete props.newDashlets;
            for (var i in props) {
                this.set(i, props[i]);
            }
            this._initializeProvider(newDashlets);
            this.provider._returnFromUpdate = true;
            this.provider.newDashlets = newDashlets;
            array.forEach(this.dashletList, function (data) {
                var context = data.context;
                try {
                    context._wfReloadDashlet(false);
                } catch (e) {
                    console.log("Error in full update of dashlet " + context.model.id + ".Err: " + e.message);
                }
            });

            array.forEach(newDashlets, function (dashlet) {
                var model = this.provider.getDashlet(dashlet.id);
                when(this.createDashlet(model), function () {
                    delete self.provider._returnFromUpdate;
                    delete self.provider.newDashlets;
                    self.initLoad();
                });
            }, this);
        },

        _initializeProvider: function (newDashlets) {
            if ((this.provider instanceof wfProvider) && !newDashlets) {

            } else {
                var initValues = this._wfProviderInit;
                var dashletNodes = query(".wfDashletContainer", this.updatePanelNode);
                var dashletEditorNodes = query(".wfDashletEditorContainer", this.updatePanelNode);
                var dashlets = [], modules = [];
                if (this.isLoaded()) {
                    array.forEach(this.dashletList, function (item) {
                        var dashlet = item.context.model.serialized();
                        dashlets.push(dashlet);
                        var existing = array.filter(modules, function (module) {
                            return module.id == dashlet.moduleId;
                        });
                        if (existing.length == 0)
                            modules.push(item.context.model.module.serialized());
                    }, this);
                    if (newDashlets)
                        array.forEach(newDashlets, function (item) {
                            dashlets.push(item);
                            var existing = array.filter(modules, function (module) {
                                return module.id == item.moduleId;
                            });
                            if (existing.length == 0)
                                modules.push(item.module);
                            item.module = null;
                        }, this);
                } else {
                    dashlets = initValues.dashlets;
                    modules = initValues.modules;
                }
                this.provider = new wfProvider(initValues.dashboard, dashlets, modules, dashletNodes, dashletEditorNodes, this, this.updatePanelNode);
                delete this._wfProviderInit;
            }
        },

        _manageLoadStatus: function (defer) {
            var nodes = query(".d-dashboard-loadStatus");
            nodes.forEach(function (node) {
                domStyle.set(node, "display", "block");
                node.innerHTML = language.StartingDashboardLoad;
            });
            defer.then(function () {
                nodes.forEach(function (node) {
                    domStyle.set(node, "display", "none");
                });

            }, function () {
                nodes.forEach(function (node) {
                    node.domStyle.set("display", "none");
                });
            }, function (msg) {
                nodes.forEach(function (node) {
                    node.innerHTML = msg;
                });
            });
        },

        load: function (id) {
            this._initializeProvider();
            var res = this.inherited(arguments);
            this._manageLoadStatus(res);
            var self = this;
            when(res, function () {
                self.initLoad();
            });
            return res;
        },

        postscript: function (args) {
            this.inherited(arguments, [args]);
        },

        buildRendering: function () {

            this.inherited(arguments);
        },

        _removeDashlet: function (context) {
            var self = this;
            var dashletId = context.model.id;
            var res = this.inherited(arguments);

            when(res, function () {
                var editorNodes = query(".wfDashletEditorContainer", self.domNode.parentNode);
                editorNodes.forEach(function (node) {
                    var id = attr.get(node, "data-jdash-dashletId");
                    if (id === dashletId) {
                        domConstruct.destroy(node);
                    }
                })
            });

            return res;
        },

        createDashlet: function (model) {
            if (this.provider._returnFromUpdate) {
                model._provider = this.provider;
                model.set("dashboardId", this.dashboardId);
                var self = this;

                var result = new Deferred();

                when(model.getModule(), function (module) {
                    var pos = self.layout.getPositionInfo(model.position).dashPos;
                    model.set("position", pos);
                    when(self._createDashlet(module, model), function (createResult) {
                        result.resolve(createResult);
                    }, function (err) {
                        result.reject(err);
                        console.log(err.message);
                    });
                }, function (err) {
                    result.reject(err);
                });
                return result;
            }
            var pos = this.layout.getPositionInfo(model.position).dashPos;
            var newPositions = this.layout.fixPositions(pos);

            return this.provider.createDashlet(model, newPositions);
        },

        initSubscriptions: function () {

            function needsNotification(context, command) {
                var not = lang.getObject("config.wfConfig.notifications", null, context.model.module);
                if (not && not.commands) {
                    return not.commands.indexOf(command.name) >= 0;
                }
            }

            var allowedCommands = ["refresh", "maximize", "restore", "remove"];
            var self = this;
            this.subscribe("jdash/dashlet/command/executing", function (event) {
                var context = event.sender;
                var command = event.args.command;
                if (needsNotification(context, command)) {
                    var serverCommand = util.getCommand("commandExecuting", { name: command.name, __relatedDashletId: context.model.id });
                    event.nextDefer = util.postback(context.dashboard.provider.getServerPostId(), json.stringify(serverCommand), null, null, context.dashboard);
                }
            });

            this.subscribe("jdash/dashlet/command/executed", function (event) {
                var context = event.sender;
                var command = event.args.command;
                if (needsNotification(context, command)) {
                    var serverCommand = util.getCommand("commandExecuted", { name: command.name, __relatedDashletId: context.model.id });
                    event.nextDefer = util.postback(context.dashboard.provider.getServerPostId(), json.stringify(serverCommand), null, null, context.dashboard);
                }
            });
        },

        loadDashletProperties: function (dashletId, props) {
            var context = this.getContext(dashletId);
            if (context) {
                for (var i in props) {
                    context.model.set(i, props[i]);
                }
            }
        },

        buildRendering: function () {
            this.inherited(arguments);
        },

        destroyRecursive: function () {
            this.inherited(arguments);
        },

        initLoad: function () {
            var self = this;
            var deferList = [];


            array.forEach(self.provider.editorNodes, function (node) {
                var nodeDashletId = attr.get(node, "data-jdash-dashletId");
                array.forEach(self.dashletList, function (data) {
                    if (data.context.model.id == nodeDashletId) {
                        if (domClass.contains(node, "wfEditorControlLoaded"))
                            data.context.openEditor();
                    }
                });
            });

            setTimeout(function () {
                util.makeVisible(self.domNode.parentNode.parentNode, self.animationDuration);
            });
        },

        destroyRecursive: function () {
            this.inherited(arguments);
        },

        startup: function () {

            this.initSubscriptions();
            var self = this;

            when(this.inherited(arguments), function () {
                var loadid = self._autoloadid;
                delete self._autoloadid;
                if (loadid) {
                    when(self.load(loadid), function () {
                    }, function (e) {
                        throw e;
                    });
                }
            });

        }
    });

    var wfResourceManagerModule = declare([Stateful], {
        constructor: function () {
            this._initDefer = new Deferred();
        },

        initCompleted: function () {
            return this._initDefer;
        },

        _initExtenstions: function () {
            DashletContext.prototype._wfReloadDashlet = function (innerOnly, newPos) {

                if (!innerOnly) {
                    this._wfReloading = true;

                    this.closeEditor();
                    this.pane.removeChild(this.dashlet);
                    var saveDom = this.dashlet.domNode;

                    var newModel = this.dashboard.provider.getDashlet(this.model.id);
                    this.model.remoteNodes = newModel.remoteNodes;
                    var pos = this.dashboard.layout.getPositionInfo(newPos ? newPos : this.model.position).dashPos;
                    this.model.set("position", pos);

                    if (saveDom)
                        domConstruct.destroy(saveDom);
                }

                if (lang.isFunction(this.dashlet._handleDomUpdate))
                    this.dashlet._handleDomUpdate(this.model.remoteNodes.dashlet, innerOnly);
                else this.dashlet.domNode = this.model.remoteNodes.dashlet;

                if (!innerOnly) {
                    this.pane.addChild(this.dashlet);
                    var self = this;

                    delete this._wfReloading;
                }
            }

            DashletContext.prototype._wfDashletDestroying = function (innerOnly) {
                if (lang.isFunction(this.dashlet._handleDomUpdating))
                    this.dashlet._handleDomUpdating(innerOnly);
            }
        },

        init: function (props) {
            if (!this._inited && !this._initInrogress) {
                this._initInrogress = true;
                var self = this;
                this._initExtenstions();
                msAjax.init();
                lang.mixin(ThemeManager.knownResourcePaths, props.resourceOverrides);
                if (props.customThemes)
                    for (var themeId in props.customThemes)
                        ThemeManager.register(props.customThemes[themeId].Key, props.customThemes[themeId].Value);
                var initResult = ThemeManager.init({theme: props.initialThemeId, style: props.initialThemeStyleId, loadFromCookie: props.loadPersistedTheme});
                when(initResult, function () {
                    var res = null;
                    when(res, function (initRes) {
                        self._inited = true;
                        delete self._initInrogress;
                        self._initDefer.resolve(initRes);
                    }, function (err) {
                        delete self._initInrogress;
                        self._initDefer.reject(err);
                    });
                }, function (err) {
                    delete self._initInrogress;
                    self._initDefer.reject(err);
                });
            };
            return this._initDefer;
        }
    })

    var ResMngr = new wfResourceManagerModule();

    return {
        "createDashboard": function (properties, nodeid) {
            properties.updatePanelNode = nodeid;
            //properties.controlNode = dom.byId(nodeid).parentNode;
            //var cnode = properties.controlNode;
            //var dashlets = query(".wfDashletContainer", cnode);
            //var editors = query(".wfDashletEditorContainer", cnode);
            //dashlets.forEach(function (dashlet) {
            //    domConstruct.place(dashlet, cnode);
            //})
            //editors.forEach(function (editor) {
            //    domConstruct.place(editor, cnode);
            //})
            //domStyle.set(cnode, "width", "100%");
            //domStyle.set(nodeid, "width", "100%");
            var view = util.createCmpSync(wfDashboardView, properties, nodeid);
        },

        "manageDashboard": function (id, props) {
            var dash = this.getCmp(id);
            if (dash) {
                var dom = dash.domNode.parentNode;
                if (typeof props.discardEvents != "undefined") {
                    when(dash.contextReady(props.discardEvents.dashletId), function (context) {
                        context.model._wfDiscardEvents = props.discardEvents.eventNames;
                    });
                }
                //util.makeVisible(dom);
            }
        },

        "createDashlet": function (properties, nodeid) {
            var dashboard = this.getCmpByNode(nodeid);
            dashboard.wfCreateDashlet(properties);
        },

        "createCmp": function (modules, properties, nodeid, callback, scope) {
            return util.createCmp.apply(util, arguments);
        },

        "createButton": function (properties, nodeid) {
            var instance = util.createCmpSync(wfButton, properties, nodeid);
            return instance;
        },

        "createDashletStylesList": function (properties, nodeid) {
            var dashletId = properties.dashletId;
            var dashboardId = properties.dashboardId;
            delete properties.dashletId;
            delete properties.dashboardId;
            var context;
            if (dashletId && dashboardId) {
                var dashboard = this.getCmp(dashboardId);
                context = dashboard.getContext(dashletId);
                if (dashletId && dashboardId) {
                    var dashboard = this.getCmp(dashboardId);
                    context = dashboard.getContext(dashletId);
                    if (context) lang.mixin(properties, { context: context });
                    else {
                        lang.mixin(properties, { dashboard: dashboard, dashletId: dashletId });
                    }
                    var instance = util.createCmpSync(DashletStylesList, properties, nodeid);
                    return instance;
                }

            }
        },


        "createDashletPropertyEditor": function (properties, nodeid) {
            var dashletId = properties.dashletId;
            var dashboardId = properties.dashboardId;
            delete properties.dashletId;
            delete properties.dashboardId;
            var context;
            if (dashletId && dashboardId) {
                var dashboard = this.getCmp(dashboardId);
                context = dashboard.getContext(dashletId);
                if (context) lang.mixin(properties, { context: context });
                else {
                    lang.mixin(properties, { dashboard: dashboard, dashletId: dashletId });
                }
                var instance = util.createCmpSync(DashletPropertyEditor, properties, nodeid);
                return instance;
            }
        },

        "createThemeStylesList": function (properties, nodeid) {
            var instance = util.createCmpSync(ThemeStylesList, properties, nodeid);
            return instance;
        },


        "getCmpByNode": function (nodeid) {
            return util.getCmpByNode(nodeid);
        },

        "getCmp": function (id) {
            return util.getCmp(id)
        },

        "callObject": function (scope, method, params) {
            util.callObject(scope, method, params);
        },

        "callDashletContext": function (dashboardid, modelid, method, params) {
            var dashboard = this.getCmp(dashboardid);
            when(dashboard.contextReady(modelid), function (context) {
                util.callObject(context, method, params);
            });
        },

        "callDashlet": function (dashboardid, modelid, method, params) {
            var dashboard = this.getCmp(dashboardid);
            when(dashboard.contextReady(modelid), function (context) {
                util.callObject(context.dashlet, method, params);
            });
        },

        "setCmpProperties": function (id, props) {
            var cmp = this.getCmp(id);
            if (cmp)
                cmp.set(props);
        },

        "destroyCmp": function (id) {
            util.destroyCmp.apply(util, arguments);
        },

        "Ready": function (handler, scope) {
            require(["klt/domReady!"], function () {
                if (scope)
                    handler.apply(scope);
                else handler();
            });
        },

        "setPostbackResult": function (key, result) {
            util.setPostbackResult(key, result);
        },


        "json": json,

        when: when,

        ThemeManager: ThemeManager,

        ResMngr: ResMngr
    }
});
