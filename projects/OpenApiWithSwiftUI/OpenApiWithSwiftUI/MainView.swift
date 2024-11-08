//
//  MainView.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//

import SwiftUI

struct MainView: View {
    let weatherProvider = WeatherProvider()
    var body: some View {
        TabView {
            BookList()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("책검색")
                }
            ForecaseView()
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("일기예보")
                }
        }.environmentObject(weatherProvider)
            .onAppear() {
                weatherProvider.getWeather()
            }
    }
}

#Preview {
    MainView()
}
