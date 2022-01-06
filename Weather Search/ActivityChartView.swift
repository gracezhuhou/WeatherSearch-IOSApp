//
//  ActivityChartView.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/29.
//

import Foundation
import Highcharts
import SwiftUI


struct ActivityChart: UIViewControllerRepresentable {
    
    @Binding var todayWeather: DayWeather

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityChart>) -> ActivityChartViewController {
        
        let chartViewController = ActivityChartViewController()
        chartViewController.setData(data: [Int(todayWeather.cloudCover), Int(todayWeather.precipProb), Int(todayWeather.humidity)])
        
        return chartViewController
    }

    func updateUIViewController(_ uiView: ActivityChartViewController, context: UIViewControllerRepresentableContext<ActivityChart>) {
//        uiView.text = text
    }
}



class ActivityChartViewController: UIViewController {
    var data: [Int] = []
    
    func setData(data: [Int]) {
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let chartView = HIChartView(frame: view.bounds)
        chartView.plugins = ["solid-gauge"]

        let options = HIOptions()

        let chart = HIChart()
        chart.type = "solidgauge"
        chart.height = 420
        options.chart = chart

        let title = HITitle()
        title.text = "Weather Data"
        title.style = HICSSObject()
        title.style.fontSize = "25px"
        options.title = title

        let tooltip = HITooltip()
        tooltip.borderWidth = 0
        tooltip.shadow = HIShadowOptionsObject()
        tooltip.shadow.opacity = 0
        tooltip.style = HICSSObject()
        tooltip.style.fontSize = "16px"
        tooltip.valueSuffix = "%"
        tooltip.pointFormat = "{series.name}<br><span style=\"font-size:2em; color: {point.color}; font-weight: bold\">{point.y}</span>"
        tooltip.positioner = HIFunction(jsFunction: "function (labelWidth) { return { x: (this.chart.chartWidth - labelWidth) / 2, y: (this.chart.plotHeight / 2) + 15 }; }")
        options.tooltip = tooltip

        let pane = HIPane()
        pane.startAngle = 0
        pane.endAngle = 360

        let background1 = HIBackground()
        background1.backgroundColor = HIColor(rgba: 90, green: 199, blue: 49, alpha: 0.35)
        background1.outerRadius = "110%"
        background1.innerRadius = "90%"
        background1.borderWidth = 0

        let background2 = HIBackground()
        background2.backgroundColor = HIColor(rgba: 80, green: 162, blue: 244, alpha: 0.35)
        background2.outerRadius = "89%"
        background2.innerRadius = "69%"
        background2.borderWidth = 0

        let background3 = HIBackground()
        background3.backgroundColor = HIColor(rgba: 255, green: 86, blue: 94, alpha: 0.35)
        background3.outerRadius = "68%"
        background3.innerRadius = "48%"
        background3.borderWidth = 0

        pane.background = [
          background1, background2, background3
        ]

        options.pane = pane

        let yAxis = HIYAxis()
        yAxis.min = 0
        yAxis.max = 100
        yAxis.lineWidth = 0
//        yAxis.tickPosition = ""
        yAxis.tickWidth = 0
        yAxis.minorTickWidth = 0
        yAxis.labels = HILabels()
        yAxis.labels.enabled = false
        options.yAxis = [yAxis]

        let plotOptions = HIPlotOptions()
        plotOptions.solidgauge = HISolidgauge()
        let dataLabels = HIDataLabels()
        dataLabels.enabled = false
        plotOptions.solidgauge.dataLabels = [dataLabels]
        plotOptions.solidgauge.linecap = "round"
        plotOptions.solidgauge.stickyTracking = false
        plotOptions.solidgauge.rounded = true
        plotOptions.series = HISeries()
        plotOptions.series.animation = HIAnimationOptionsObject()
        plotOptions.series.animation.defer = 0
        plotOptions.series.animation.duration = 0
        options.plotOptions = plotOptions

        let cloudCover = HISolidgauge()
        cloudCover.name = "Cloud Cover"
        let cloudCoverData = HIData()
        cloudCoverData.color = HIColor(rgba: 90, green: 199, blue: 49, alpha: 1)
        cloudCoverData.radius = "110%"
        cloudCoverData.innerRadius = "90%"
        cloudCoverData.y = NSNumber(value: data[0])
        cloudCover.data = [cloudCoverData]

        let precipitation = HISolidgauge()
        precipitation.name = "Precipitation"
        let precipitationData = HIData()
        precipitationData.color = HIColor(rgba: 80, green: 162, blue: 244, alpha: 1)
        precipitationData.radius = "89%"
        precipitationData.innerRadius = "69%"
        precipitationData.y = NSNumber(value: data[1])
        precipitation.data = [precipitationData]

        let humidity = HISolidgauge()
        humidity.name = "Humidity"
        let humidityData = HIData()
        humidityData.color = HIColor(rgba: 255, green: 86, blue: 94, alpha: 1)
        humidityData.radius = "68%"
        humidityData.innerRadius = "48%"
        humidityData.y = NSNumber(value: data[2])
        humidity.data = [humidityData]

        options.series = [cloudCover, precipitation, humidity]

        chartView.options = options

        self.view.addSubview(chartView)
    }

}
        
