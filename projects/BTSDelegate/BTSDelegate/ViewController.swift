//
//  ViewController.swift
//  PickerViewTest
//
//  Created by 정송희 on 8/30/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var picker: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(component)번째 컴포넌트 \(row)번째 로우 "
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblTitle.text = "\(component)번째 컴포넌트 \(row)번째 로우 "
    }
    

// 컴포넌트 갯수 만큼 실행됨, 컴포넌트 각각 row가 몇개인지 알아야 하니까
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 4
        }else {
            return 6
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
}

