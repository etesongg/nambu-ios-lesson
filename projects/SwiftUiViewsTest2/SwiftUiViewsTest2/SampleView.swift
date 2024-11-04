//
//  SampleView.swift
//  SwiftUiViewsTest2
//
//  Created by 정송희 on 10/30/24.
//

import SwiftUI

struct GrouBoxView: View {
    @State var agreementText = ""
    @State var isOn1 = true
    @State var isOn2 = false
    var body: some View {
        GroupBox(label: Label("떠든사람", systemImage: "person.3")) { // groupbox에는 제목 label이 들어감
            Text("떠든사람1")
            Text("떠든사람2")
            Text(agreementText)
        }
        GroupBox(label: Label("켜기", systemImage: "switch.2")) {
            Toggle("큰방", isOn: $isOn1)
            Toggle("작은방", isOn: $isOn2)
        }
    }
}

struct LabelView: View {
    @State private var isOn = true
    var body: some View {
        VStack {
            Label("Lightning", systemImage: "bolt.fill")
            Label("Lightning", systemImage: "bolt.fill")
                .labelStyle(.titleOnly)
            Label("Lightning", systemImage: "bolt.fill")
                .labelStyle(.iconOnly)
            Label("Lightning", systemImage: "bolt.fill")
                .labelStyle(.titleAndIcon)
            List {
                LabeledContent("이름") {
                    Text("홍길동")
                }
                LabeledContent("사진") {
                    Image(systemName: "person.3")
                }
                Toggle("toggle", isOn: $isOn)
                LabeledContent("trash") {
                    Image(systemName: "trash")
                }
            }
        }.padding(.top, 30)
    }
}

struct TextFieldView: View {
    enum Field: Hashable {
        case username
        case password
    }
    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    var body: some View {
        List {
            TextField("이름", text: $username)
                .focused($focusedField, equals: .username)
                .onSubmit { // 엔터치면 포커스를 다음으로 넘김
                    focusedField = .password
                }
            SecureField("비밀번호", text: $password)
                .focused($focusedField, equals: .password)

            Button("로그인") {
                if username.isEmpty {
                    focusedField = .username
                }else if password.isEmpty {
                    focusedField = .password
                } else {
                    print(username, password)
                    focusedField = nil
                }
                
            }.onAppear(perform: {
                focusedField = .username
            })
        }
    }
}
var items = ["Item1", "Item2","Item3", "Item4","Item5"]
struct ListView:View {
    var body: some View {
        List {
            Text("Item1")
            Text("Item2")
            Text("Item3")
            Text("Item4")
            Text("Item5")
        }
        
        List {
            ForEach(items, id:\.self) { item in
                Text(item)
            }
            
        }.listStyle(.inset)
    }
}

struct ListDeleteMoveView: View {
    @State var items = ["Item1", "Item2","Item3", "Item4","Item5"]
    var body: some View {
        List {
            EditButton()
            ForEach(items, id: \.self) {
                item in Text(item)
            }.onDelete(perform: { indexSet in
                items.remove(atOffsets: indexSet)
            })
            .onMove(perform: { indices, newOffset in
                items.move(fromOffsets: indices, toOffset: newOffset)
            })
        }
    }
}

struct SectionView:View {
    var body: some View {
        List {
            Section {
                ForEach(items, id:\.self) { item in
                    Text(item).font(.system(size: 20, weight: .thin))
                }
            }
            Section {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            } header: {
                Text("Section Header")
                    .font(.title)
                    .fontWeight(.bold)
            } footer: {
                Label("Section Footer", systemImage:  "pencil.circle")
            }
        }
    }
}

struct NavigationView :View {
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(btsImages.indices, id: \.self) { index in
                    NavigationLink(
                        destination: Image(btsImages[index])
                            .frame(width: 50, height: 100)
) {
                            Text(bts[index])
                        }
                        
                }
            }.navigationTitle("Navigation Title")
                .navigationBarTitleDisplayMode(.inline) // .authmatic, .large
        } detail: {
            Text("Item을 선택하세요")
        }
    }
}

struct TabTestView: View {
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    var body: some View {
        
        TabView {
            NavigationView()
                .tabItem {
                    Text("first")
                        .foregroundStyle(.red)
                        .font(.largeTitle)
                    
                    
                }
            Text("Second View")
                .foregroundStyle(.red)
                .font(.largeTitle)
            
                .tabItem { Image("bts1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 5, height: 5)
                    Text("Second")
                }
        }
    }
}

struct LayoutTest :View {
    var body: some View {
        Text("Layout Test")
            .padding()
            .background(.blue)
            .frame(width: 200, height: 100)
            .position(CGPoint(x: 200, y: 200))
    }
}
// vstack의 공간에 대한 정보
struct GeometryTest: View {
    var body: some View {
        GeometryReader { reader in
            VStack {
                // height = 759
                // height/2 = 379.5
                // height/3 = 253
                Text("\(reader.size.width), height = \(reader.size.height/3)").frame(width: reader.size.width, height: reader.size.height/3)
                    .background(.blue)
                Text("\(reader.size.width), height = \(reader.size.height)").frame(width: reader.size.width, height: reader.size.height)
                    .background(.red)
            }
        }
    }
}

#Preview {
    LabelView()
}
