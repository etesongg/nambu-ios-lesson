//
//  ViewController.swift
//  ViewTest
//
//  Created by 정송희 on 8/29/24.
//

import UIKit

class ViewController: UIViewController {
    // 라이프 사이클(각 단계에서~~
    // loadView 단계
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
            
    override func viewDidAppear(_ animated: Bool) { // 앱 실행시키면 여기까지 나옴
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    
    
    
    
    
    
}

