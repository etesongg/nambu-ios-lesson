//
//  ViewController.swift
//  BTSPickerView
//
//  Created by 정송희 on 9/2/24.
//

import UIKit

// 1. 프로토콜 적용, 2. 프로토콜 메서드 구현, 3. 델리게이트 지정
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    let btsName = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.dataSource = self
        picker.delegate = self
    }
    
    @IBAction func actRoll(_ sender: Any) {
        // 처음 나올때 선택되는 위치
        picker.selectRow(5, inComponent: 0, animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return btsImages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView()
        if component == 0 {
            imageView.image = UIImage(named: btsImages[row])
        }else {
            imageView.image = UIImage(systemName: "heart.fill")
            imageView.contentMode = .scaleAspectFit
        }
        return imageView

    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedName = btsName[row]
        label.text = "현재 선택된 멤버의 이름은 \(selectedName)"
    }
}



