//
//  SampleView.swift
//  SwiftUiViewsTest
//
//  Created by 정송희 on 10/29/24.
//

import SwiftUI

enum Flavor: String {
    case chocolate, vanilla, strawberry
}

struct PickerView: View {
    @State private var selectedFlavor: Flavor = .chocolate
    var body: some View {
        List {
            Text(selectedFlavor.rawValue)
            Picker("Flavor", selection: $selectedFlavor) {
                Text("Chocolate").tag(Flavor.chocolate)
                Text("Vanilla").tag(Flavor.vanilla)
                Text("strawberry").tag(Flavor.strawberry)
            }
        }
    }
}

struct DatePickerView: View {
    @State var selectedDate: Date = Date() // 프로퍼티
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
        return formatter // 리턴이 있으니 연산 프로퍼티
    }
    var body: some View { // 연산 프로퍼티
        VStack {
            Text(selectedDate, formatter: dateFormatter)
                .font(.title).padding(.top, 15)
            
            DatePicker(selection: $selectedDate, label: {
                Text("일시를 선택하시오")})
            .datePickerStyle(.graphical)
                    .padding()
            List {
                DatePicker("", selection: $selectedDate, in: Date()...Date().addingTimeInterval(3600*24*7), displayedComponents: [.date])
            
            }
        }
    }
}

struct GaugeView: View {
    @State private var current: Double = 0.0
    @State private var progress: Double = 0.0
    var minValue: Double
    var maxValue: Double
    
    var body: some View {
        VStack {
            Gauge(value: progress, label: {
                Text("진행상황")
            }).padding()
            HStack {
                Button("증가") {progress+=0.1}
                Button("감소") {progress-=0.1}
            }
            Gauge(value: current, in:minValue...maxValue) {
                Text("속도")
            } currentValueLabel: {
                Text("\(Int(current))")
            } minimumValueLabel: {
                Text("\(Int(minValue))")
            } maximumValueLabel: {
                Text("\(Int(maxValue))")
            }.padding()
            Button("증가") {
                current += 1
            }
            
        }
    }
}

struct DisclosureGroupView: View {
    @State private var isExpanded: Bool = false
    @State private var isShow: Bool = false
    @State private var isSound: Bool = true
    
    var body: some View {
        List {
            DisclosureGroup("Items", isExpanded: $isExpanded) {
                Toggle("보기", isOn: $isShow)
                Toggle("소리듣기", isOn: $isSound)
            }.padding()
        }
    }
}

struct FormView: View {
    enum Notification: String {
        case Sound="소리", Vibrate="진동", Silent="묵음"
    }
    @State var isOn = false
    @State var selectedNoti: Notification = .Sound
    @State var selectedFlavor: Flavor = .strawberry
    var body: some View {
        NavigationView {
            Form {
                Section("Menu1") {
                    Picker("알림", selection: $selectedNoti) {
                        Text(Notification.Sound.rawValue).tag(Notification.Sound)
                        Text(Notification.Vibrate.rawValue).tag(Notification.Vibrate)
                        Text(Notification.Silent.rawValue).tag(Notification.Silent)
                    }
                }
                Section("Menu2") {
                    Toggle("Play notification sound", isOn: $isOn)
                }
                Section(header: Text("Menu2")) {
                    Text("Direct Messages")
                    Text("Mentions")
                    Text("Anything")
                }
            }
        }
    }
}

#Preview {
    FormView()
}
