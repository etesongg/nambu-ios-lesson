//
//  ViewController.swift
//  TableViewTest-ReuseCell2
//
//  Created by 정송희 on 9/3/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1000
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "can", for: indexPath) // 재활용 셀 요청, 같은 이름 두가지 메서드가 있는데 옵셔널인 것과 아닌것이 있음. 아닌걸 쓰면 알아서 만들어 주기 때문에 옵셔널 아닐걸 사용하는게 편함, 이걸 사용하려면 storyboard에서 PrototypeCell의 갯수를 1개이상한후 identifier를 설정 해주어야함
        // for에는 별 기능 없음. 그냥 매개변수 indexPath 넣어주기
        print(cell)
        var content = cell.defaultContentConfiguration()

        content.text = "\(indexPath.section)번째 섹션 \(indexPath.row)번째 로우"
        cell.contentConfiguration = content
        return cell
    }

}

