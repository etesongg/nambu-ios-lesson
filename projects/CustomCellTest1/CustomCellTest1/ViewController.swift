//
//  ViewController.swift
//  CustomCellTest1
//
//  Created by 정송희 on 9/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bts", for: indexPath)
//        if let imageView:UIImageView? = cell.viewWithTag(1) as? UIImageView { // viewWithTag의 반환형은 UIView 타입임, 사용할 요소들이 다 UIView 하위 애들이기 때문에, 그리고 옵셔널인 이유는 만약에 태그값이 잘못 지정해준 경우 nil 이 반환되기 때문, as는 형변환
//            imageView?.image = UIImage(named: btsImages[indexPath.row])
//        }
        // 위 코드를 guard let으로 한 것임, 근데 여기에는 guard let은 맞지 않음. 만약 이미지 뷰가 없으면 밑에 있는 코드가 필요없는 상황에는 이게 맞음
//        guard let imageView = cell.viewWithTag(1) as? UIImageView else {
//            fatalError()
//        }
        // 위 코드 옵셔널 체이닝으로 한 것임
        let imageView = cell.viewWithTag(1) as? UIImageView // UIImageView 옵셔널 타입임
        imageView?.image = UIImage(named: btsImages[indexPath.row])
        
        let lblNick = cell.viewWithTag(2) as? UILabel // 만약 라벨로 만들고 태그를 1로 이미지를 넣으면 nil 이 나옴. 아무일도 일어나지 않음
        lblNick?.text = bts[indexPath.row]
        let lblDesc = cell.viewWithTag(3) as? UILabel
        lblDesc?.text = "\(indexPath.row + 1)번째 멤버"
        
        return cell
    }
}
