//
//  PickerView.swift
//  SwiftUi-Uiket
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI

struct PickerView:UIViewRepresentable {
    func makeUIView(context: Context) -> UIPickerView {
        UIPickerView()
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
//        uiView.dataSource = context.coordinator
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> PickerViewCoordinator {
        PickerViewCoordinator()
    }
}

class PickerViewCoordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    // Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    // DataSource
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(component), \(row)"
//    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart.fill")
        return imageView
    }
}

#Preview {
    PickerView()
}
