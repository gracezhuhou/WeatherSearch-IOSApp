//
//  ModelData.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/25.
//

import Foundation
import Alamofire
import SwiftUI


class Observer : ObservableObject{
    @Published var favWeatherList = [String: [DayWeather]]()
    @Published var autoWeatherList = [DayWeather]()  // current location result
    @Published var autoTodayWeather: DayWeather
    
    @Published var weatherList = [DayWeather]()  // search result
    @Published var todayWeather: DayWeather
    @Published var lastSearchLocation: Location
    
    @Published var autoLocation = [Location]()
    
    private let defaultWeather: DayWeather
    private var hasFetchAutoData: Bool

    init() {
        hasFetchAutoData = false
        defaultWeather = DayWeather(date: "Unknown", weatherCode: 0, temp: 0.0, tempApparent: 0.0, tempMin: 0.0, tempMax: 0.0, windSpeed: 0.0, windDir: 0.0, humidity: 0, pressure: 0.0, precipProb: 0, precipType: 0, sunrise: "Unknown", sunset: "Unknown", visibility: 0.0, cloudCover: 0, uvIndex: 0.0)
        autoTodayWeather = defaultWeather
        todayWeather = defaultWeather
        lastSearchLocation = Location(city: "", state: "")
    }
    
    func getWeather(lat: Double, lng: Double, isAuto: Bool = false, isFav: Bool = false, favKey: String = "") {
        // Replace the url string below to your own back-end website url for json data
        let url = URL(string: "https://\(MYURL)/day?lat=\(lat)&lng=\(lng)")!
        AF.request(url, method: .get).responseJSON { response in
            var newList = [DayWeather]()
            print("Request Weather Data of \(lat) \(lng)")
            let json = response.value
            if (json as? [String : AnyObject]) == nil { return }
            if let result = json as? Dictionary<String, AnyObject?> {
                if let data = result["data"] as? Dictionary<String, AnyObject?> {
                    if let timelines = data["timelines"] as? Array<Dictionary<String, AnyObject?>>{
                        for i in 0 ..< timelines.count{
                            if let intervals = timelines[i]["intervals"] as? Array<Dictionary<String, AnyObject?>>{
                                for j in 0 ..< intervals.count{
                                    if let date = intervals[j]["startTime"] as? String, let values = intervals[j]["values"] as? Dictionary<String, AnyObject?> {
                                        let dateArray = date.components(separatedBy: "T")[0].components(separatedBy: "-")
                                        let date_ = dateArray[1] + "/" + dateArray[2] + "/" + dateArray[0]
                                        
                                        if let temp = values["temperature"] as? Double, let tempApparent = values["temperatureApparent"] as? Double, let tempMin = values["temperatureMin"] as? Double, let tempMax = values["temperatureMax"] as? Double, let windSpeed = values["windSpeed"] as? Double, let windDir = values["windDirection"] as? Double, let humidity = values["humidity"] as? Double, let pressure = values["pressureSeaLevel"] as? Double, let weatherCode = values["weatherCode"] as? Int, let precipProb = values["precipitationProbability"] as? Double, let precipType = values["precipitationType"] as? Int, let sunrise = values["sunriseTime"] as? String, let sunset = values["sunsetTime"] as? String, let visibility = values["visibility"] as? Double, let cloudCover = values["cloudCover"] as? Double {
                                            let sunriseArray = sunrise.components(separatedBy: "T")[1].components(separatedBy: "-")[0].components(separatedBy: ":")
                                            let sunrise_ = sunriseArray[0] + ":" + sunriseArray[1]
                                            let sunsetArray = sunset.components(separatedBy: "T")[1].components(separatedBy: "-")[0].components(separatedBy: ":")
                                            let sunset_ = sunsetArray[0] + ":" + sunsetArray[1]
                                            let uvIndex = values["uvIndex"] as? Double ?? 0.0
                                            let dayWeather = DayWeather(date: date_, weatherCode: weatherCode, temp: temp, tempApparent: tempApparent, tempMin: tempMin, tempMax: tempMax, windSpeed: windSpeed, windDir: windDir, humidity: humidity, pressure: pressure, precipProb: precipProb, precipType: precipType, sunrise: sunrise_, sunset: sunset_, visibility: visibility, cloudCover: cloudCover, uvIndex: uvIndex)
                                            newList.append(dayWeather)
                                        }
                                        else {
                                            print("Append Weather Fail: \(j)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if newList.count > 0 {
                if isAuto {
                    self.autoWeatherList = newList
                    self.autoTodayWeather = newList[0]
                }
                else if isFav {
                    self.favWeatherList[favKey] = newList
                }
                else {
                    self.weatherList = newList
                    self.todayWeather = newList[0]
                }
                print("Get weather cnt: \(newList.count)")
            }
        }
    }
    

    
    func getWeatherByLocation(location: Location, isFav: Bool = false) {
        let city = location.city.replacingOccurrences(of: " ", with: "%20")
        let state = location.state.replacingOccurrences(of: " ", with: "%20")
        // Replace \(MYKEY) to your google api key
        let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=+\(city),+\(state)&key=\(MYKEY)&language=en")!
        AF.request(url, method: .get).responseJSON { response in
            print("Get lat and lng of \(location.city)")
            if let json = response.value {
                if (json as? [String : AnyObject]) == nil { return }
                if let result = json as? Dictionary<String, AnyObject?> {
                    if let results = result["results"] as? Array<Dictionary<String, AnyObject?>> {
                        if let geometry = results[0]["geometry"] as? Dictionary<String, AnyObject?> {
                            if let lct = geometry["location"] as? Dictionary<String, AnyObject?> {
                                if let lat = lct["lat"] as? Double, let lng = lct["lng"] as? Double {
                                    self.getWeather(lat: lat, lng: lng, isFav: isFav, favKey: location.toString())
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func getAutoWeather(lat: Double, lng: Double) {
        if hasFetchAutoData { return }
        hasFetchAutoData = true
        self.getWeather(lat: lat, lng: lng, isAuto: true)
    }
    
    func getSearchedWeather(location: Location) {
        self.weatherList.removeAll()
        todayWeather = defaultWeather
        getWeatherByLocation(location: location)
        lastSearchLocation = location
    }
    
    
    // get weather info of favorite cities
    func getFavWeather(favLocations: [String: Location]) {
//        favWeatherList.removeAll()
        for value in favLocations.values {
            getWeatherByLocation(location: value, isFav: true)
        }
    }
    
    func addFavWeather(location: Location, data: [DayWeather]) {
        favWeatherList[location.toString()] = data
        print("Add Fav Weather Info \(favWeatherList.count)")
    }
    
    func removeFavWeather(location: Location) {
        favWeatherList.removeValue(forKey: location.toString())
        print("Remove Fav Weather Info \(favWeatherList.count)")
    }
    


    // auto complete
    func getAutoLocation(city: String = "") {
        self.autoLocation.removeAll()
        if city == "" { return }
        
        let input = city.replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "\t", with: "")
        // Change \(MYKEY) to your google api key
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&key=\(MYKEY)&language=en&types=%28cities%29")!
        AF.request(url, method: .get).responseJSON{ response in
            if let json = response.value {
                if (json as? [String : AnyObject]) != nil{
                    if let result = json as? Dictionary<String, AnyObject?> {
                        if let predictions = result["predictions"] as? Array<Dictionary<String, AnyObject?>> {
                            for i in 0..<predictions.count{
                                if let terms = predictions[i]["terms"] as? Array<Dictionary<String, AnyObject?>> {                                    if let city = terms[0]["value"] as? String, let state = terms[1]["value"] as? String{
                                        self.autoLocation.append(Location(city: city, state: state))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    

}
