//
//  TodaySubView.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/27.
//

import SwiftUI

struct TodaySubView: View {
    var todayWeather: DayWeather
    var city: String
    
    var body: some View {
        HStack(spacing: 0.0) {
            todayWeather.image.padding(15.0)
            VStack(alignment: .leading, spacing: 0.0) {
                Text("\(Int(todayWeather.temp))°F")
                    .font(.title).fontWeight(.bold)
                    .foregroundColor(Color.black)
                Text(todayWeather.weather)
                    .padding(.vertical, 20.0)
                    .foregroundColor(Color.black)
                Text(city)
                    .font(.title3).fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(width: 160.0, alignment: .leading)
            }
            Spacer(minLength: 0)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white, lineWidth: 3)
        )
        .background(Color.white.opacity(0.4)).cornerRadius(4)
    }
}

struct TodaySubView_Previews: PreviewProvider {
    static var previews: some View {
        TodaySubView(todayWeather: exampleWeather, city: "Los Angeles")
            .background(.blue)
            .padding(.horizontal, 30.0)
    }
}
