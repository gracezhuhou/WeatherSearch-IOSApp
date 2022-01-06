//
//  WeeklyTabContent.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/29.
//

import SwiftUI

struct WeeklyTabContent: View {
    @State var allDayWeather: [DayWeather]
    
    var body: some View {
        let todayWeather = allDayWeather[0]
        
        return ZStack {
            Image("App_background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack(spacing: 0.0) {
                    todayWeather.image.padding(15.0)
                    Spacer()
                    VStack(alignment: .leading, spacing: 0.0) {
                        Text(todayWeather.weather)
                            .font(.title).fontWeight(.bold).padding(.vertical, 20.0)
                        Text("\(Int(todayWeather.temp))°F")
                            .font(.largeTitle).fontWeight(.bold)
                    }.frame(height: 220.0)
                    Spacer()
                }
                .border(Color.white).cornerRadius(4)
                .background(Color.white.opacity(0.25))
                .padding(25.0)
                
                Chart(allDayWeather: allDayWeather).padding(.vertical)
                
                Spacer()
                Rectangle().frame(height: 0.0).background(Color.white)
            }
        }
    }
}

struct WeeklyTabContent_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTabContent(allDayWeather: [exampleWeather])
    }
}
