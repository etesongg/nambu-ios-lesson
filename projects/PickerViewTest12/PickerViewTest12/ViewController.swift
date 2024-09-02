//
//  ViewController.swift
//  PickerViewTest12
//
//  Created by 정송희 on 9/2/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self // 누가 너의 대리인인지 알려줘야 함
        picker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    // 알아서 라벨을 만들어서 사용함
    // 피커뷰가 두개 사용된다면 피커뷰 구분할 매개변수 _ pickerView: UIPickerView
    // titleForRow row: Int 몇번째 row인지 구분할 매개변수
    // forComponent component: Int 몇번째 component인지 구분할 매개변수
    // 좌표 값 주는거임 0~3, 만약 컴포넌트 2개라면 0,0~1,4
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { // titleForRow 재활용 가능?
        return "\(component), \(row)"
    }
    
    // 정확히는 안 나옴, 0에는 300을 주고 1에는 나머지 줘버림
    //    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    //        if component == 0 {
    //            return 300
    //        }else {
    //            return 100
    //        }
    //    }
    // 컴포넌트 마다 지정해도 큰수를 따르는듯?
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // resuing 재활용 (있으면 재활용 없으면 만들어줌)
        // view가 넘어오면 옵셔널이기 때문에 언래핑해줘야 함
        // 현재 안되는 상태인데 다른데서 resuing을 이렇게 사용하기때문에 형식 알아두기
        if let imageView = view as? UIImageView{ // as 형변환, View를 UIImageView로 형변환 / ?는 형변환을 보장하지 않기 때문에 결과값으로 옵셔널해짐 / 결과적으로 UIImageView 옵셔널이 나옴 / 그걸 언래핑까지 해줌
            imageView.image = UIImage(systemName: "person.3")
            return imageView
        }else {
            let aa = UIImageView()
            aa.contentMode = .scaleAspectFit
            aa.image = UIImage(systemName: "heart.fill")
            return aa
        }
        
        
//        if view == nil {
//            let imageView = UIImageView()
//            imageView.image = UIImage(systemName: "heart.fill")
//            imageView.contentMode = .scaleAspectFit // 이미지 비율 맞추기
//            return imageView
//        }else {
//            view.image = UIImage(systemName: "heart.fill")
//            return view
//        }
//    }
        
        
    }
}

