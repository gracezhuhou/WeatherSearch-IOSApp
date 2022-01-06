//
//  TodayWeatherItem.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/28.
//

import SwiftUI

struct TodayWeatherItem: View {
    
    var itemName: String
    var itemIndex: Int
    var value: Double
    
//    private let itemName = ["Wind Speed", "Pressure", "Precipitation", "Temperature", "Humidity", "Visibility", "Cloud Cover", "UVIndex"]
    private let unit = [" mph", " inHg", " %", "°F", "",  "%", " mi", " %", ""]
    
    var body: some View {
        return VStack {
            VStack(spacing: 10.0) {
                Image(itemName).resizable().frame(width: 90.0, height: 90.0)
                if itemIndex != 4 {
                    Text(String(format: itemIndex == 3 ? "%0.0f" : "%0.1f", value) + unit[itemIndex])
                }
                Text(itemName).padding(.vertical, itemIndex == 4 ? 15.0 : 0.0)
            }.frame(width: 120.0, height: 180.0)
        }
        .border(Color.white).cornerRadius(4)
        .background(Color.white.opacity(0.3))
    }
}

struct TodayWeatherItem_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherItem(itemName: "Temperature", itemIndex: 3, value: 30.34).background(Color.blue)
    }}
