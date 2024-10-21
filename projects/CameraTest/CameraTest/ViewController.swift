//
//  ViewController.swift
//  CameraTest
//
//  Created by 정송희 on 10/21/24.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var camera = UIImagePickerController()
    var picker:PHPickerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        camera.sourceType = .camera
        camera.delegate = self
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        picker = PHPickerViewController(configuration: config)
        picker?.delegate = self
        
    }

    @IBAction func actPhoto(_ sender: Any) {
        let sheet = UIAlertController(title: "리소스 선택", message: "이미지 소스를 선택하세요", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel)
        let actionAlbum = UIAlertAction(title: "Album", style: .default) { _ in
            self.present(self.picker!, animated: true)
        }
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.present(self.camera, animated: true)
        }
        sheet.addAction(actionCancel)
        sheet.addAction(actionAlbum)
        sheet.addAction(actionCamera)
        present(sheet, animated: true)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage { // 메인 쓰레드 동작
            imageView.image = image
            dismiss(animated: true)
        }
        
    }
}

extension ViewController:PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else { return }
        itemProvider.loadObject(ofClass: UIImage.self) { result, _ in
            if let image = result as? UIImage {
                DispatchQueue.main.async{ // 글로벌 쓰레드 동작
                self.imageView.image = image
                }
            }
        }

    }
  
}
