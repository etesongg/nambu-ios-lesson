//
//  ForecaseView.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//
import SwiftUI

let sampleForecase = Forecast(id: 1731056400, main: Main(temp: 16.6, humidity: 27), weather: [Weather(main: "Clear", description: "맑음", icon: "01n")], date: "2024-11-08 09:00:00")
    
struct ForecaseRow: View {
    let forecast:Forecast
    var body: some View {
        VStack(alignment: .leading) {
            Text(forecast.date)
            HStack {
                HStack {
                    let strURL = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
                    
                    AsyncImage(url: URL(string: strURL)) { image in
                        image.resizable().frame(width: 50, height: 50)
                    } placeholder: {
                        Image(systemName: "sun.min")
                    }
                    Text(forecast.weather[0].description)
                }
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "thermometer.medium")
                        Text(String(format: "%.1f℃", forecast.main.temp))
                    }.foregroundStyle(.red)
                    HStack {
                        Image(systemName: "humidity")
                        Text("\(forecast.main.humidity)%")
                    }.foregroundStyle(.blue)
                }
            }
            
        }.padding()
    }
}

#Preview {
    ForecaseRow(forecast: sampleForecase)
}
