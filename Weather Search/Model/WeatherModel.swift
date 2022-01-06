//
//  WeatherModel.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/27.
//

import Foundation
import SwiftUI

var weatherDesc: [Int: String] = [4201: "Heavy Rain", 4001: "Rain", 4200: "Light Rain", 6201: "Heavy Freezing Rain",
    6001: "Freezing Rain", 6200: "Light Freezing Rain", 6000: "Freezing Drizzle", 4000: "Drizzle",
    7101: "Heavy Ice Pellets", 7000: "Ice Pellets", 7102: "Light Ice Pellets", 5101: "Heavy Snow",
    5000: "Snow", 5100: "Light Snow", 5001: "Flurries", 8000: "Thunderstorm", 2100: "Light Fog",
    2000: "Fog", 1001: "Cloudy", 1102: "Mostly Cloudy", 1101: "Partly Cloudy", 1100: "Mostly Clear",
    1000: "Clear", 3000: "Light Wind", 3001: "Wind", 3002: "Strong Wind"];

struct DayWeather: Hashable, Codable {
    var date: String
    var weatherCode: Int
    var temp: Double
    var tempApparent: Double
    var tempMin: Double
    var tempMax: Double
    var windSpeed: Double
    var windDir: Double
    var humidity: Double
    var pressure: Double
    var precipProb: Double
    var precipType: Int
    var sunrise: String
    var sunset: String
    var visibility: Double
    var cloudCover: Double
    var uvIndex: Double
    
    var weather: String {
        weatherDesc[weatherCode] ?? "Unknown"
    }

    var image: Image {
        Image(weatherDesc[weatherCode] ?? "Clear")
    }
    
//    var timeInterval: Double {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        let dateTime = formatter.date(from: date) ?? Date.init()
//        return dateTime.timeIntervalSince1970 * 1000
//    }
}

struct Location: Hashable, Codable {
    var city: String
    var state: String
    
    func compares(other: Location) -> Bool {
        if city == other.city, state == other.state {
            return true
        }
        else {
            return false
        }
    }
    
    func toString() -> String {
        return city + "&" + state
    }
}

var exampleWeather = DayWeather(date: "10/21/2021", weatherCode: 0, temp: 0.0, tempApparent: 0.0, tempMin: 0.0, tempMax: 10.0, windSpeed: 0.0, windDir: 0.0, humidity: 32.0, pressure: 0.0, precipProb: 14, precipType: 0, sunrise: "05:00", sunset: "18:00", visibility: 0.0, cloudCover: 12.4, uvIndex: 0.0)
var exampleWeather2 = DayWeather(date: "10/22/2021", weatherCode: 0, temp: 0.0, tempApparent: 0.0, tempMin: 0.0, tempMax: 10.0, windSpeed: 0.0, windDir: 0.0, humidity: 0, pressure: 0.0, precipProb: 0, precipType: 0, sunrise: "05:01", sunset: "18:02", visibility: 0.0, cloudCover: 0, uvIndex: 0.0)
var exampleWeather3 = DayWeather(date: "10/23/2021", weatherCode: 0, temp: 0.0, tempApparent: 0.0, tempMin: 0.0, tempMax: 10.0, windSpeed: 0.0, windDir: 0.0, humidity: 0, pressure: 0.0, precipProb: 0, precipType: 0, sunrise: "05:01", sunset: "18:02", visibility: 0.0, cloudCover: 0, uvIndex: 0.0)


