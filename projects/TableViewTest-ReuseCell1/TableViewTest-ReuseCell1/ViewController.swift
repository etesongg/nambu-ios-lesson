//
//  ViewController.swift
//  TableViewTest-ReuseCell1
//
//  Created by 정송희 on 9/2/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        테이블뷰 요청
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        print(cell) // 초반 스무개정도 nil
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        var content = cell?.defaultContentConfiguration() //옵셔널 체이닝?dm로 nil값이 나오면 무시하고 값이 있으면
        content?.text = "\(indexPath.section)번째 section \(indexPath.row)번째 row"
        cell?.contentConfiguration = content
        return cell!
        
    }


}

