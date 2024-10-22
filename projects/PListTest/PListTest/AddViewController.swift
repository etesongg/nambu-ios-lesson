//
//  AddViewController.swift
//  PListTest
//
//  Created by 정송희 on 10/21/24.
//

import UIKit
import PhotosUI

class AddViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtNick: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var bts:NSMutableArray?
    var camera:UIImagePickerController? // 옵셔널로 안 만들어도 상관없는데 picker랑 통일 시키려고 옵셔널로 만듬
    var picker:PHPickerViewController? // PHPickerConfiguration이 필요해서 옵셔널로 만듬
    
    fileprivate func setupKeyboardEvnet() {
        // Notification 사용하기 위해, default 들어가면 싱글톤, name: 감시할 대상, object: 전달할일 있으면 써줌
        // viewDidLoad에 위치해 있으면 viewDidLoad가 너무 길어져서 리팩토링으로 뺌
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera = UIImagePickerController()
        camera?.sourceType = .camera // photolibrary로 쓰면 리젝당함 이제 못씀, camera로 사용하기
        camera?.delegate = self // delegate 일을 대신해주는데 자격이 필요함
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 3 // 최대 3개 선택가능
        config.filter = .images
        
        picker = PHPickerViewController(configuration: config)
        picker?.delegate = self
        
        // 키보드 포커스 없어졌을때 내리기
        txtNick.delegate = self
        txtDesc.delegate = self
        
        setupKeyboardEvnet()
    }

    
    @IBAction func actPhoto(_ sender: Any) {
        let sheet = UIAlertController(title: "이미지 소스선택", message: "이미지의 소스를 선택하세요", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel)
        let actionAlbum = UIAlertAction(title: "Album", style: .default) { _ in
            self.present(self.picker!, animated: true) // handler는 액션이 선택됐을때 실행할 함수
        }
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.present(self.camera!, animated: true)
        }
        sheet.addAction(actionCancel)
        sheet.addAction(actionAlbum)
        sheet.addAction(actionCamera)
        present(sheet, animated: true)
    }
    
    // document 폴더에 저장
    @IBAction func actSave(_ sender: Any) {
        let imageName:String? = UUID().uuidString+".png" // 이미지 이름을 유일하게 만들기 위한 처리
        let newMember = ["nick":txtNick.text, "desc":txtDesc.text, "image":imageName] // nick, desc가 string? 이어서 image도 ?로 바꿔줬음
        bts?.add(newMember)
        let target = urlWithFileName("bts.plist")
        try? bts?.write(to: target)
        
        // 이미지 뷰에 저장하는 기능이 없어서 타입을 바꿔서 저장해야함
        guard let image = imageView.image,
              let data = image.jpegData(compressionQuality: 0.8) // 압축률 선택
        else { return }
        
        let fileURL = urlWithFileName(imageName!, type: .png)
        print("actSave ",fileURL)
        try? data.write(to: fileURL)
        
        performSegue(withIdentifier: "back", sender: nil)
    }
    
    
    // 키보드가 올라오면 실행, 셀렉트로 사용하려면 @objc 써줘야함?
    @objc func keyboardWillShow(_ sender:Notification){
        view.frame.origin.y = -200
    }
    // 키보드가 없을때 실행
    @objc func keyboardWillHide(_ sender:Notification){
        view.frame.origin.y = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // 키보드의 포커스가 없을때 실행, 텍스트필드의 현재 상태를 포기했다는 요청을 리시버에게 알려주는 뜻
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
// picker, camera의 Delegate 설정, Delegate는 필요한 파라미터를 넘겨줌
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    // 카메라, 설정이 끝났을때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage { // 메인 쓰레드 동작
            imageView.image = image
            picker.dismiss(animated: true) // present의 반대
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
