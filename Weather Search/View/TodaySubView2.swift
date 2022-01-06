//
//  TodaySubView2.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/29.
//

import SwiftUI

struct TodaySubView2: View {
    var todayWeather: DayWeather
    
    var body: some View {
        HStack(spacing: 13.0) {
            VStack {
                Text("Humidity")
                Image("Humidity").resizable().frame(width: 50.0, height: 50.0)
                Text(String(format: "%0.1f", todayWeather.humidity) + " %")
            }
            VStack {
                Text("Wind Speed")
                Image("Wind Speed").resizable().frame(width: 50.0, height: 50.0)
                Text(String(format: "%0.2f", todayWeather.windSpeed) + " mph")
            }
            VStack {
                Text("Visibility")
                Image("Visibility").resizable().frame(width: 50.0, height: 50.0)
                Text(String(format: "%0.2f", todayWeather.visibility) + " mi")
            }
            VStack {
                Text("Pressure")
                Image("Pressure").resizable().frame(width: 50.0, height: 50.0)
                Text(String(format: "%0.2f", todayWeather.pressure) + " ingh")
            }
        }
    }
}

struct TodaySubView2_Previews: PreviewProvider {
    static var previews: some View {
        TodaySubView2(todayWeather: exampleWeather)
    }
}
