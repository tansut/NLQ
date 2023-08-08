define(["require"], function (require) {
    return {
        headerType: {
            dimensionHeader: 0,
            measureHeader: 1,
        },

        chartType: {
            bar: 0,
            column: 1,
            line: 2,
            area: 3,
            pie: 4
        },

        highChartType: {
            0: 'bar',
            1: 'column',
            2: 'line',
            3: 'area',
            4: 'pie'
        }
    }
})