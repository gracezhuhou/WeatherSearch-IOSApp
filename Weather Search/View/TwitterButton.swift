//
//  TwitterButton.swift
//  Weather Search
//
//  Created by 朱侯青晨 on 2021/11/28.
//

import SwiftUI

struct TwitterButton: View {
    var todayWeather: DayWeather
    var city: String
    
    
    var body: some View {
        var url: String = "https://twitter.com/intent/tweet?text=The current temperature at \(city) is \(todayWeather.tempApparent)°F. The weather conditions are \(todayWeather.weather)&hashtags=CSCI571WeatherSearch&url= "
        url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!  //.replacingOccurrences(of: " ", with: "%20")
//        print(URL(string: url) ?? "none")
        
        return Link(destination: (URL(string: url) ?? URL(string: "https://twitter.com")!)) {
            Image("twitter").foregroundColor(Color.blue)
        }.padding(10.0)
    }
}

struct TwitterButton_Previews: PreviewProvider {
    static var previews: some View {
        TwitterButton(todayWeather: exampleWeather, city: "Los Angeles")
    }
}
