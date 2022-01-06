//
//  WeatherDataTabContent.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/29.
//

import SwiftUI

struct WeatherDataTabContent: View {
    @State var todayWeather: DayWeather
    
    var body: some View {
        return ZStack {
            Image("App_background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack() {
                    VStack {
                        Image("Precipitation").resizable().frame(width: 50.0, height: 50.0)
                        Image("Humidity").resizable().frame(width: 50.0, height: 50.0)
                        Image("Cloud Cover").resizable().frame(width: 50.0, height: 50.0)
                    }.padding()
                    VStack(alignment: .trailing, spacing: 35.0) {
                        Text("Precipitation:").font(.title2)
                        Text("Humidity:").font(.title2)
                        Text("Cloud Cover:").font(.title2)
                    }
                    .padding(.leading, 10.0)
                    VStack(alignment: .leading, spacing: 35.0) {
                        Text("\(String(format: "%0.1f", todayWeather.precipProb)) %").font(.title2)
                        Text("\(String(format: "%0.1f", todayWeather.humidity)) %").font(.title2)
                        Text("\(String(format: "%0.1f", todayWeather.cloudCover)) %").font(.title2)
                    }
                    Spacer()
                }
                .border(Color.white).cornerRadius(4)
                .background(Color.white.opacity(0.25))
                .padding(25.0)
                
                ActivityChart(todayWeather: $todayWeather)
                
                Spacer()
                Rectangle().frame(height: 0.0).background(Color.white)
            }
            
        }
    }
}

struct WeatherDataTabContent_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataTabContent(todayWeather: exampleWeather)
    }
}
