//
//  FirstWeatherSubView.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/27.
//

import SwiftUI

struct FirstWeatherSubView: View {
    var todayWeather: DayWeather
    var city: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0.0) {
                todayWeather.image.padding(15.0)
                VStack(alignment: .leading, spacing: 0.0) {
                    Text("\(Int(todayWeather.temp))°F").font(.title).fontWeight(.bold)
                    Text(todayWeather.weather).padding(.vertical, 20.0)
                    Text(city)
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/).fontWeight(.bold)
                }.padding(.trailing, 60.0)
            }
            .border(Color.white).cornerRadius(4)
            .background(Color.white.opacity(0.25))
            .padding(.vertical, 40.0)
            
            HStack(spacing: 13.0) {
                VStack {
                    Text("Humidity")
                    Image("Humidity").resizable().frame(width: 50.0, height: 50.0)
                    Text(String(format: "%0.1f", todayWeather.humidity) + " %")
                }
                VStack {
                    Text("Wind Speed")
                    Image("WindSpeed").resizable().frame(width: 50.0, height: 50.0)
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
}

struct FirstWeatherSubView_Previews: PreviewProvider {
    static var previews: some View {
        let todayWeather = DayWeather(date: "Unknown", weatherCode: 0, temp: 0.0, tempApparent: 0.0, tempMin: 0.0, tempMax: 0.0, windSpeed: 0.0, windDir: 0.0, humidity: 0, pressure: 0.0, precipProb: 0, precipType: 0, sunrise: "Unknown", sunset: "Unknown", visibility: 0.0, cloudCover: 0)
        FirstWeatherSubView(todayWeather: todayWeather, city: "Los Angeles")
    }
}
