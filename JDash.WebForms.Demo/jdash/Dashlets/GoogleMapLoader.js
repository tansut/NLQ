define(["require", "http://www.google.com/jsapi"], function (require) {
    return {
        load: function (name, req, load, config) {

            function loadSignal() {
                load();
            }
            google.load("maps", "3", { "callback": loadSignal, other_params: "sensor=true&libraries=visualization" });
        }
    }
});