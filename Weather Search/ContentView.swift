//
//  ContentView.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/24.
//

import Foundation
import UIKit
import SwiftUI
import SwiftSpinner

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var observed = Observer()
    @StateObject var localStorage = LocalStorage()
    @State private var searchText: String = ""
    @State private var hasShowSpinner: Bool = false
    @State private var toastText: String = ""
    @State private var favNum = 0
    
    var body: some View {
        
        getCurrWeather()
        if !observed.autoWeatherList.isEmpty,  observed.favWeatherList.count == localStorage.allFavorites.count, !hasShowSpinner{
            SwiftSpinner.hide( { hasShowSpinner = true } )
        }
        
        
        return NavigationView {
            ZStack {
                Image("App_background")
                    .resizable()
                    .ignoresSafeArea()
                    
                VStack(spacing: 0.0) {
                    Rectangle().frame(height: 0).background(Color(UIColor.systemGray4))
                    
                    SearchBar(text: $searchText)
                        .padding(.horizontal, 15.0)
                        .background(Color(UIColor.systemGray4))
                        .onChange(of: searchText) { newValue in
                            observed.getAutoLocation(city: newValue)
                        }.zIndex(1)

                    ZStack(alignment: .top) {
                        VStack {
                            TabView {
                                MainTagContent(weatherList: observed.autoWeatherList, location: Location(city: locationManager.placemark?.locality ?? "Unknown", state: ""), isAuto: true, observed: observed, localStorage: localStorage)

                                ForEach(observed.favWeatherList.keys.sorted(), id: \.self) { key in
                                    let city = String(key.split(separator: "&")[0])
                                    let state = String(key.split(separator: "&")[1])
                                    MainTagContent(weatherList: observed.favWeatherList[key]!, location: Location(city: city, state: state), observed: observed, localStorage: localStorage)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .id(observed.favWeatherList.count+1)
                        }
                        
                        // Auto Complete
                        if (!observed.autoLocation.isEmpty) {
                            List {
                                Group {
                                    ForEach(0 ..< observed.autoLocation.count, id: \.self) { index in
                                        ZStack(alignment: .leading){
                                            let location = observed.autoLocation[index]
                                            Text(location.city)
                                            
                                            NavigationLink(destination: SearchResultPage(location: location, observed: observed, localStorage: localStorage)
                                                            .onAppear(
                                                                perform: {
                                                                    searchText = ""
                                                                })) {
                                                                    EmptyView()
                                                                }
                                                                .opacity(0.0)
                                                                .navigationBarTitle("Weather")
                                        }
                                    }
                                }.listRowBackground(Color.white.opacity(0.7))
                            }
                            .listStyle(.plain)
                            .frame(height: 220.0)
                            .padding(.top)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 3)
                            )
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(4)
                            .padding(.horizontal, 23.0)
                            .offset(y: -17)
                        }
                        
                    }
                }
                
                VStack {
                    Spacer()
                    Toast(text: $toastText).frame(height: 50.0).padding(.bottom, 30.0)
                }
            }.navigationBarHidden(true)
            
        }
        .onAppear(perform: {
            localStorage.getAllFavorites()
            observed.getFavWeather(favLocations: localStorage.allFavorites)
            SwiftSpinner.show("Loading...")
            favNum = localStorage.allFavorites.count
        })
        .onChange(of: localStorage.allFavorites.count) { newFavNum in
            if newFavNum < favNum {
                toastText = "\(localStorage.lastRemoveCity) was removed from the Favorite List"
            }
            favNum = newFavNum
        }
    }
    
    func getCurrWeather() {
        if let location = locationManager.lastLocation, observed.autoWeatherList.isEmpty {
            observed.getAutoWeather(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
