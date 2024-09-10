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
<<<<<<< HEAD
        if let imageName = member?["image"] {
=======
        lblNick.text = member?["stage_name"] // 받아온 member가 옵셔널이기 때문에 옵셔널 처리를 해줘야 함
        if let imageName = member?["image"] { // 변수명을 하나로 쓸 수 있음
>>>>>>> 66383ed (open api, BookFinder)
            imageProfile.image = UIImage(named: imageName)
        }
        lblNick.text = member?["stage-name"] // 받아온 member가 옵셔널이기 때문에 옵셔널 처리를 해줘야 함
        // lblNick.text = "member?['stage-name']" 이거는 에러남
        // 이유는 값이 nil이 나온다고 해도 스트링으로 만들어줘 "nil"이 되기 때문에 옵셔널 처리 해준게 아니게 됨
        // 사용하고 싶으면 밑에 처럼 기본 값을 줘야 함
        // let memberName = member?["name"] ?? "기본 이름"
        // lblNick.text = memberName
    }
    // 어레이일 경우
//    lblNick.text = memberName
//    if let imageName {
//        imageProfile.image = UIImage(named: imageName)
//    }
    
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
