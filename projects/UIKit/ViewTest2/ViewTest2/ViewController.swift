//
//  ViewController.swift
//  ViewTest2
//
//  Created by 정송희 on 8/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnTouched: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func actChange(_ sender: Any) {
        label.text = "\(segmentControl.selectedSegmentIndex+1) 번째를 눌러주셨습니다."
    }
    @IBAction func didEndOnExit(_ sender: Any) {
        label.text = textField.text
    }
    @IBAction func actSliderValueChange(_ sender: Any) {
        label.text = "\(slider.value)"
    }
    @IBAction func actSwitch(_ sender: Any) {
        if switch1.isOn {
            label.text = "스위치가 켜졌습니다."
        }else {
            label.text = "스위치가 꺼졌습니다."
        }
    }
    @IBAction func actStepperValueChange(_ sender: Any) {
        label.text = "\(stepper.value)"
    }
    
    @IBAction func btnTouched(_ sender: Any) {
        imageView.image = UIImage(systemName: "heart.fill")
        
    }
    override func viewDidLoad() { // 화면이 실행될때 해주는 작업
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segmentControl.setTitle("네번째", forSegmentAt: 3)
        segmentControl.setEnabled(false, forSegmentAt: 2) // 활성화
        segmentControl.selectedSegmentIndex = 1
        
        slider.maximumValue = 100
        slider.minimumValue = -100
        slider.value = 0
        
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 0.2
        stepper.value = 0
        
        let image = UIImage(named: "bts1")
        imageView.image = image

    }

}

