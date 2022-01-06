//
//  ChartController.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/29.
//

import Foundation
import Highcharts
import SwiftUI


struct Chart: UIViewControllerRepresentable {
    
    var allDayWeather: [DayWeather]

    func makeUIViewController(context: UIViewControllerRepresentableContext<Chart>) -> ChartViewController {
        var data = [[Double]]()
        
        for i in 0..<allDayWeather.count{
            data.append([Double(i), allDayWeather[i].tempMin, allDayWeather[i].tempMax])
        }
        
        let chartViewController = ChartViewController()
        chartViewController.setData(data: data)
        
        return chartViewController
    }

    func updateUIViewController(_ uiView: ChartViewController, context: UIViewControllerRepresentableContext<Chart>) {
    }
}


class ChartViewController: UIViewController {
    
    var data: [[Double]] = []
    
    func setData(data: [[Double]]) {
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let chartView = HIChartView(frame: view.bounds)
        
        let options = HIOptions()
        
        let chart = HIChart()
        chart.type = "arearange"
//        chart.zoomType = "x"
//        chart.scrollablePlotArea = HIScrollablePlotArea()
//        chart.scrollablePlotArea.minWidth = 600
        chart.height = 350
//        chart.scrollablePlotArea.scrollPositionX = 1
        options.chart = chart

        let title = HITitle()
        title.text = "Temperature Variation by Day"
        options.title = title

        let xAxis = HIXAxis()
//        xAxis.type = "datetime"
//        xAxis.accessibility = HIAccessibility()
//        xAxis.accessibility.rangeDescription = "Range: Jan 1st 2017 to Dec 31 2017."
        options.xAxis = [xAxis]

        let yAxis = HIYAxis()
        yAxis.title = HITitle()
        yAxis.title.text = "Temperature"
        options.yAxis = [yAxis]

        let tooltip = HITooltip()
        // tooltip.crosshairs = true
        tooltip.shared = true
        tooltip.valueSuffix = "°F"
//        tooltip.headerFormat = ""
        tooltip.split = true
        options.tooltip = tooltip

        let legend = HILegend()
        legend.enabled = false
        options.legend = legend
        
        let plotOptions = HIPlotOptions()
        plotOptions.arearange = HIArearange()
        plotOptions.arearange.fillColor = HIColor(linearGradient: ["x1": 0, "y1": 0, "x2:": 0, "y2": 1],
                                               stops: [[0, "rgb(248,159,66)"], [1, "rgba(100,173,230,0.5)"]])

        plotOptions.arearange.lineWidth = 0
        
        plotOptions.series = HISeries()
        plotOptions.series.animation = HIAnimationOptionsObject()
        plotOptions.series.animation.defer = 0
        plotOptions.series.animation.duration = 0
        options.plotOptions = plotOptions
        

        let temperatures = HIArearange()
        temperatures.name = "Temperatures"
        temperatures.data = self.data
        temperatures.marker = HIMarker()
        temperatures.marker.fillColor = HIColor(name: "black")
        
//        print(self.data)

        options.series = [temperatures]

        chartView.options = options

        self.view.addSubview(chartView)
    }
}
