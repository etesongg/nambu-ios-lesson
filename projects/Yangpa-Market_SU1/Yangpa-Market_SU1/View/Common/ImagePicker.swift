//
//  ImagePicker.swift
//  SwiftUi-Uikit
//
//  Created by 정송희 on 11/7/24.
//

import SwiftUI
import PhotosUI

// 앨범에서 사진 선택
class ImagepickerCoordinator: NSObject, PHPickerViewControllerDelegate {
    let parent:ImagePicker

    init(parent:ImagePicker){
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        guard let itemProvider = results.first?.itemProvider else { return }
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                self.parent.image = image as? UIImage
            }
        }
        picker.dismiss(animated: true)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image:UIImage?
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        
    }
    func makeCoordinator() -> ImagepickerCoordinator {
        ImagepickerCoordinator(parent: self)
    }
}

struct ImagepickerView:View {
    @State var isPresented: Bool = false
    @State var aImage:UIImage? // 이미지가 바뀔때 새로 그려줌(사진 선택할때마다 해당 사진 보여주기
    var body: some View {
        VStack {
            
            if let aImage{ // aImage가 nil이면 Image 안보여줌
                Image(uiImage: aImage).resizable().frame(width: 300, height: 300)
            }
            Button("PickerView") {
                isPresented.toggle()
            }.sheet(isPresented: $isPresented) { // 트루면 이미지 띄어주고 펄스면 안 띄어줌
                ImagePicker(image: $aImage)
            }
        }
    }
}

#Preview {
    ImagepickerView()
}
