//
//  DayWeatherRow.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/25.
//

import SwiftUI

struct DayWeatherRow: View {
    var dayWeather: DayWeather
    
    var body: some View {
        HStack(spacing: 8.0) {
            Text(dayWeather.date).frame(width: 90)
            dayWeather.image
                .resizable().frame(width: 30, height: 30)
            Text(dayWeather.sunrise).frame(width: 50)
            Image("sun-rise")
                .resizable().frame(width: 30, height: 30)
            Text(dayWeather.sunset).frame(width: 50)
            Image("sun-set")
                .resizable().frame(width: 30, height: 30)
        }
        
    }
}

struct DayWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        DayWeatherRow(dayWeather: exampleWeather)
            .previewInterfaceOrientation(.portraitUpsideDown)
            .padding(30.0)
    }
}
