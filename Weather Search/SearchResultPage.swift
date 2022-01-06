//
//  SearchResultPage.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/27.
//

import SwiftUI
import SwiftSpinner

struct SearchResultPage: View {
    var location: Location
    var isAuto: Bool = false
    
    @StateObject var observed: Observer = Observer()
    @StateObject var localStorage: LocalStorage = LocalStorage()
    @State private var favButtonImage = "plus-circle"
    @State private var showToast = false
    @State private var toastText: String = ""
    @State private var hasShowSpinner: Bool = false
    
    
    var body: some View {
        if !observed.weatherList.isEmpty, hasShowSpinner {
            SwiftSpinner.hide()
        }
        
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
                
                NavigationLink(destination: WeatherDetailsPage(city: location.city, weatherList: observed.weatherList)) {
                    TodaySubView(todayWeather: observed.todayWeather, city: location.city)
                }
                .navigationBarTitle("Weather")
                .padding(.bottom, 40.0)
                .padding(.horizontal, 30.0)
                
                TodaySubView2(todayWeather: observed.todayWeather)
                
                DayWeatherList(allDayWeather: observed.weatherList)
                
            }
            VStack {
                Spacer()
                Toast(text: $toastText).frame(height: 50.0).padding(.bottom, 30.0)
            }
        }
        .navigationTitle(location.city)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            TwitterButton(todayWeather: observed.todayWeather, city: location.city)
        }
        .onAppear(perform: {
            UINavigationBar.appearance().backgroundColor = UIColor.systemGray4
            favButtonImage = (localStorage.isFavorite(city: location.city, state: location.state)) ? "close-circle" : "plus-circle"
            getWeatherByLocation()
            print("Result Page On Appear")
        })
    
    }
    
    func getWeatherByLocation() {
        print("Search Result Page of \(location.city)")
        if !location.compares(other: observed.lastSearchLocation){
            SwiftSpinner.show("Fetching Weather Details for \(location.city)...")
            hasShowSpinner = true
            observed.getSearchedWeather(location: location)
        }
    }
    
    func clickFavButton() {
        if favButtonImage == "plus-circle" {
            favButtonImage = "close-circle"
            localStorage.setFavorite(city: location.city, state: location.state, status: true)
            observed.addFavWeather(location: location, data: observed.weatherList)
            toastText = "\(location.city) was added to the Favorite List"
        }
        else {
            favButtonImage = "plus-circle"
            localStorage.setFavorite(city: location.city, state: location.state, status: false)
            observed.removeFavWeather(location: location)
            toastText = "\(location.city) was removed from the Favorite List"
            
        }
    }
}

struct SearchResultPage_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(city: "Los Angeles", state: "California")
        SearchResultPage(location: location)
    }
}


