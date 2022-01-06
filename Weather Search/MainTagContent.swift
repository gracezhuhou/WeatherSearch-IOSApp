//
//  MainTagContent.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/12/4.
//

import SwiftUI
import Toast_Swift

struct MainTagContent: View {
    var weatherList: [DayWeather]
    var location: Location
    var isAuto: Bool = false
    @StateObject var observed = Observer()
    @StateObject var localStorage = LocalStorage()
    @State private var favButtonImage = "close-circle"
    
    var body: some View {
        let weather = (weatherList.count > 0) ? weatherList[0] : exampleWeather
        
        return ZStack(alignment: .top) {
            Image("App_background")
                .resizable()
                .ignoresSafeArea()
                
            VStack {
                Rectangle().frame(height: 0).background(Color(UIColor.systemGray4))
                
                HStack {
                    Spacer()
                    if !isAuto {
                        Button(action: { clickFavButton() }) {
                            Image(favButtonImage).padding(.trailing, 30.0)
                        }
                    }
                }.frame(height: 40.0)
                
                NavigationLink(destination: WeatherDetailsPage(city: location.city, weatherList: weatherList)) {
                    TodaySubView(todayWeather: weather, city: location.city)
                }
                .navigationBarTitle("Weather")
                .padding(.bottom, 40.0)
                .padding(.horizontal, 30.0)
                
                TodaySubView2(todayWeather: weather)
                
                DayWeatherList(allDayWeather: weatherList)
                
            }
        }
        .navigationTitle(location.city)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            TwitterButton(todayWeather: weather, city: location.city)
        }
        .onAppear(perform: {
            UINavigationBar.appearance().backgroundColor = UIColor.systemGray4
            favButtonImage = (localStorage.isFavorite(city: location.city, state: location.state)) ? "close-circle" : "plus-circle"
        })
    }
    
    func clickFavButton() {
//        if favButtonImage == "plus-circle" {
//            favButtonImage = "close-circle"
//            localStorage.setFavorite(city: location.city, state: location.state, status: true)
//            observed.addFavWeather(location: location, data: weatherList)
//        }
        if favButtonImage == "close-circle"{
//            favButtonImage = "plus-circle"
            localStorage.setFavorite(city: location.city, state: location.state, status: false)
            observed.removeFavWeather(location: location)
        }
    }
}

struct MainTagContent_Previews: PreviewProvider {
    static var previews: some View {
        MainTagContent(weatherList: [exampleWeather, exampleWeather2], location: Location(city: "Los Angeles", state: "CA"), isAuto: false)
    }
}
