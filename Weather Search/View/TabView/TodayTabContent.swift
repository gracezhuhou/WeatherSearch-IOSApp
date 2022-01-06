//
//  TodayTabContent.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/28.
//

import SwiftUI

struct TodayTabContent: View {
    var dayWeather: DayWeather
    
    var body: some View {
        ZStack {
            Image("App_background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    TodayWeatherItem(itemName: "Wind Speed", itemIndex: 0, value: dayWeather.windSpeed)
                    TodayWeatherItem(itemName: "Pressure", itemIndex: 1, value: dayWeather.pressure)
                    TodayWeatherItem(itemName: "Precipitation", itemIndex: 2, value: Double(dayWeather.precipProb))
                }.padding(20.0)
                HStack {
                    TodayWeatherItem(itemName: "Temperature", itemIndex: 3, value: dayWeather.temp)
                    TodayWeatherItem(itemName: dayWeather.weather, itemIndex: 4, value: 0.0)
                    TodayWeatherItem(itemName: "Humidity", itemIndex: 5, value: dayWeather.humidity)
                }.padding(20.0)
                HStack {
                    TodayWeatherItem(itemName: "Visibility", itemIndex: 6, value: dayWeather.visibility)
                    TodayWeatherItem(itemName: "Cloud Cover", itemIndex: 7, value: dayWeather.cloudCover)
                    TodayWeatherItem(itemName: "UVIndex", itemIndex: 8, value: dayWeather.uvIndex)
                }.padding(20.0)
                Spacer()
                Rectangle().frame(height: 0.0).background(Color.white)
            }
            
        }
    }
}

struct TodayTabContent_Previews: PreviewProvider {
    static var previews: some View {
        TodayTabContent(dayWeather: exampleWeather)
    }
}
