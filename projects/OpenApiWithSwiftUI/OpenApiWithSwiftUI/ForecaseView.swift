//
//  ForecaseView.swift
//  OpenApiWithSwiftUI
//
//  Created by 정송희 on 11/8/24.
//
import SwiftUI

struct ForecaseView: View {
    @StateObject var provider = ForecaseProvider()
    @State var city = ""
    var body: some View {
        NavigationSplitView {
            VStack {
                SearchBar(searchText: $city) {
                    provider.getForecase(city: city)
                }
            }
                if let forecasts = provider.list {
                    List(forecasts) { forecasts in
                        NavigationLink {
                            ForecaseRow(forecast: forecasts)
                        } label: {
                            ForecaseRow(forecast: forecasts)
                        }
                        
                }.listStyle(.plain)
                        .navigationTitle("일기예보")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                WeatherView()
                            }
                        }
                } else {
                    EmptyView()
            }
        } detail: {
            
        }
    }
}

#Preview {
    let weatherProvider = WeatherProvider()
    ForecaseView().environmentObject(weatherProvider).onAppear {
        weatherProvider.getWeather()
    }
    
}
