//
//  ViewController.swift
//  AlertControllerTest
//
//  Created by 정송희 on 9/5/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func infoAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Title", message: "정보를 알려드립니다.", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "확인", style: .default) // 알럿 끄는 부분 추가
        alert.addAction(action)
        present(alert, animated: true)
    }

    
    @IBAction func confirmAlert(_ sender: Any) {
        let alert = UIAlertController(title: "확인", message: "진짜 할겁니까?", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel) // 스타일이 더 굵은 글씨임, style: .cancel의 코드를 뒤에 적어도 이 액션이 먼저 나옴
        alert.addAction(actionCancel)
        let actionOkay = UIAlertAction(title: "진행해", style: .default) { _ in
            print("완료되었습니다.")
        }
        alert.addAction(actionOkay)
        present(alert, animated: true)
    }
    
    @IBAction func selectAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Title", message: "~를 선택하세요", preferredStyle: .alert)
        let actionOkay = UIAlertAction(title: "확인", style: .default) { _ in
            print("완료되었습니다.")
        }
        alert.addAction(actionOkay)
        let actionDel = UIAlertAction(title: "삭제", style: .destructive) { _ in
            print("삭제되었습니다.")
        }
        alert.addAction(actionDel)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소되었습니다.")
        }
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
}

