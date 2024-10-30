//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 정송희 on 10/30/24.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationSplitView {
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }

            }
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a landmark")
        }

        
    }
}

#Preview {
    LandmarkList()
}
