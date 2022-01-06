//
//  WeatherDetailsPage.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/28.
//

import SwiftUI

struct WeatherDetailsPage: View {
    var city: String
    var weatherList: [DayWeather] = [exampleWeather]
    
    var body: some View {
        
        let todayWeather = (weatherList.count > 0) ? weatherList[0] : exampleWeather
        
        return ZStack(alignment: .top) {
//            Image("App_background")
//                .resizable()
//                .ignoresSafeArea()
            
            VStack(spacing: 0.0) {
                
                TabView {
                    TodayTabContent(dayWeather: todayWeather)
                        .tabItem { Label{ Text("TODAY") } icon: { Image("Today_Tab") } }
                        .tag(1)
                    WeeklyTabContent(allDayWeather: weatherList)
                        .tabItem { Label{ Text("WEEKLY") } icon: { Image("Weekly_Tab") } }
                        .tag(2)
                    WeatherDataTabContent(todayWeather: todayWeather)
                        .tabItem { Label{ Text("WEATHER DATA") } icon: { Image("Weather_Data_Tab") } }
                        .tag(3)
                }
                
            }
            Rectangle().frame(height: 0).background(Color(UIColor.systemGray4))
            
        }
        .navigationTitle(city)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            TwitterButton(todayWeather: todayWeather, city: city)
        }
    }
}

struct WeatherDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsPage(city: "Los Angeles", weatherList: [exampleWeather])
    }
}
