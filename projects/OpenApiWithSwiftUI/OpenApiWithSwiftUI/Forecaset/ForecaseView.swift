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
                
                if let forecasts = provider.list { // forecaseprovider에서 list를 옵셔널로 만들어서 언래핑해주기
                    List(forecasts) { forecast in
                        NavigationLink {
                            ForecaseRow(forecast: forecast)
                        } label: {
                            ForecaseRow(forecast: forecast)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    EmptyView()
                }
            }
            .navigationTitle("일기예보")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    WeatherView()
                }
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
