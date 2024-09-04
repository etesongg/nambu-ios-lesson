//
//  DetailViewController.swift
//  BTSApp
//
//  Created by 정송희 on 9/4/24.
//

import UIKit

class DetailViewController: UIViewController {
//    var imageName:String? // 인스턴싱할때(생성될때) 값이 없음(nil)인 상태가 있음
//    var memberName:String?
    var member:[String:String]? // 딕셔너리를 하나 넘겨받음
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var lblNick: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNick.text = member?["stage-name"] // 받아온 member가 옵셔널이기 때문에 옵셔널 처리를 해줘야 함
        if let imageName = member?["image"] { // 변수명을 하나로 쓸 수 있음
            imageProfile.image = UIImage(named: imageName)
        }
    }
//    if let image = imageName { // 위에처럼 변수명을 하나로 쓸 수 있음
//        imageProfile.image = UIImage(named: image)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
