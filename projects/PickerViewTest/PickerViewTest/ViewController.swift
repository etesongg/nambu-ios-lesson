//
//  ViewController.swift
//  PickerViewTest
//
//  Created by 정송희 on 8/30/24.
//

import UIKit
// picker를 사용하기 위한 프로토콜 추가
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self // 피커 뷰에 표시할 메서드를 제공 numberOfComponents(in:), numberOfRowsInComponent(_:)
        picker.delegate = self // 피커 뷰의 이벤트(예: 행 선택 시) 처리를 담당하도록 설정 titleForRow(_:forComponent:), didSelectRow(_:inComponent:)
    }
    
    // 피커 본문 내용
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0{
//            return bts[row] // // bts 배열에서 현재 행(row)에 해당하는 이름 가져옴
//        }else {
//            return ""
//        }
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = UIImage(named: btsImages[row]) //데이터
        let imageView = UIImageView() // 틀
        imageView.image = image // UIImageView에 UIImage 객체를 설정하여 이미지를 화면에 표시
        return imageView
//        if component == 0{
//            let label = UILabel()
//            label.text = bts[row]
//            label.textAlignment = .center // 원래는 NSTextAlignment.center, 열거형 생략으로 .center로 작성 가능
//            return label
//        }else {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: btsImages[row])
//            return imageView
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        200
    }
    
    // 라벨 내용
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selectedName = bts[picker.selectedRow(inComponent: 0)]
//        let selectedImage = btsImages[picker.selectedRow(inComponent: 1)]
//        lblTitle.text = "이름은 \(selectedName) 사진은 \(selectedImage) "
        lblTitle.text = "\(component)번째 컴포넌트 \(row)번째 로우 "
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    // pickerView는 컴포넌트 갯수 만큼 실행됨, 컴포넌트 각각 row가 몇개인지 알아야 하기 때문
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return bts.count
        }else {
            return btsImages.count
        }
    }
 
}

