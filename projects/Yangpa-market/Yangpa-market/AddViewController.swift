//
//  AddViewController.swift
//  Yangpa-market
//
//  Created by 정송희 on 11/6/24.
//

import UIKit
import PhotosUI
import Alamofire

class AddViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func actPhoto(_ sender: Any) {
        let sheet = UIAlertController(title: "이미지 선택", message: "이미지의 출처를 선택하세요", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel)
        let actionAlbum = UIAlertAction(title: "앨범", style: .default) { _ in
            self.present(self.picker!, animated: true)
        }
        let actionCamera = UIAlertAction(title: "카메라", style: .default) { _ in
            self.present(self.camera, animated: true)
        }
        sheet.addAction(actionCancel)
        sheet.addAction(actionAlbum)
        sheet.addAction(actionCamera)
        present(sheet, animated: true)
    }
    
    @IBAction func actRegister(_ sender: Any) {
        let endPoint = "\(host)/sales"
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        let formData = MultipartFormData()
        formData.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
        formData.append(txtName.text!.data(using: .utf8)!, withName: "productName")
        formData.append(txtDesc.text!.data(using: .utf8)!, withName: "description")
        formData.append(txtPrice.text!.data(using: .utf8)!, withName: "price")
        let userDefault = UserDefaults.standard
        let userName = userDefault.string(forKey: "userName")
        formData.append(userName!.data(using: .utf8)!, withName: "userName")
        
        guard let token = userDefault.string(forKey: "token") else { return }
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(token)",
            "Content-Type":"multipart/form-data"
        ]
        AF.upload(multipartFormData: formData, to: endPoint, headers: headers).responseDecodable(of: SalesResult.self) { response in
            switch response.result {
                case .success(let salesResult):
                    let alert = UIAlertController(title: "상품등록", message: salesResult.message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

// 앨범
extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider, // 사진 가져오기
              itemProvider.canLoadObject(ofClass: UIImage.self) // 사진 로드 체크
        else { return }
        itemProvider.loadObject(ofClass: UIImage.self) { result, _ in
            if let image = result as? UIImage {
                DispatchQueue.main.async{ // 글로벌 쓰레드 동작
                    self.imageView.image = image // 클로저 안 이어서 self 써야함
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

// 카메라
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage { // 메인 쓰레드 동작
            imageView.image = image
            dismiss(animated: true)
        }
        
    }
}
