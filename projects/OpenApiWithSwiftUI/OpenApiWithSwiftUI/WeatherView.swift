//
//  WeatherView.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var provider: WeatherProvider
    var body: some View {
        HStack {
            Text(provider.description)
//            AsyncImage(url: URL(string:provider.icon)) {
//                image in
//                image.resizable().frame(width: 30, height: 30)
//            } placeholder: {
//                Image(systemName: "sun.main")
//            }
            
            if let temp = provider.temp {
                Text(String(format: "%.1f℃",temp))
                    .foregroundStyle(temp>10 ? Color.red : Color.blue)
//                    .padding(.leading, -10)
            }
        }
    }
}

#Preview {
    let provider = WeatherProvider()
    WeatherView().environmentObject(provider).onAppear {
        provider.getWeather()
    }
}
