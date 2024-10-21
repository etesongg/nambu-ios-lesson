//
//  AddViewController.swift
//  PListTest
//
//  Created by 정송희 on 10/21/24.
//

import UIKit
import PhotosUI

class AddViewController: UIViewController {
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtNick: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var bts:NSMutableArray?
    var camera = UIImagePickerController()
    var picker:PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera.sourceType = .camera
        camera.delegate = self
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 3 // 최대 3개 선택가능
        config.filter = .images
        
        picker = PHPickerViewController(configuration: config)
        picker?.delegate = self
    }
    
    @IBAction func actPhoto(_ sender: Any) {
        let sheet = UIAlertController(title: "이미지 소스선택", message: "이미지의 소스를 선택하세요", preferredStyle: .alert)
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
    
    // document 폴더에 저장
    @IBAction func actSave(_ sender: Any) {
        let imageName:String? = UUID().uuidString+".png"
        let newMember = ["nick":txtNick.text, "desc":txtDesc.text, "image":imageName] // nick, desc가 string? 이어서 imageeh ?로 바꿔줬음
        bts?.add(newMember)
        let target = urlWithFileName("bts.plist")
        try? bts?.write(to: target)
        
        // 이미지 뷰에 저장하는 기능이 없어서 타입을 바꿔서 저장해야함
        guard let image = imageView.image,
              let data = image.jpegData(compressionQuality: 0.8) // 압축률 선택
        else { return }
        
        let fileURL = urlWithFileName(imageName!)
        print("actSave ",fileURL)
        try? data.write(to: fileURL)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    // 카메라
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage { // 메인 쓰레드 동작
            imageView.image = image
            picker.dismiss(animated: true)
        }
        
    }
    // 앨범
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
