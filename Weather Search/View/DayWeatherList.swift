//
//  DayWeatherList.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/25.
//

import SwiftUI

struct DayWeatherList: View {
    var allDayWeather: [DayWeather]
    
    var body: some View {
        List(allDayWeather, id: \.date) { dayWeather in
            Group {
                 DayWeatherRow(dayWeather: dayWeather)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 15.0)
            }.listRowBackground(Color.white.opacity(0.7))
        }
        .listStyle(.plain)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white, lineWidth: 3)
        )
        .background(Color.white.opacity(0.4)).cornerRadius(4)
        .frame(height: 265.0)
        .padding(30.0)
    }
}

struct DayWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        DayWeatherList(allDayWeather: [exampleWeather, exampleWeather, exampleWeather, exampleWeather, exampleWeather, exampleWeather]).background(Color.gray)
    }
}
