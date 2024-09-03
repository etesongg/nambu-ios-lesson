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
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") //  재활용통을 테이블 뷰가 가지고 있어 테이블뷰한테 요청
        print(cell) // 초반 스무개정도 nil
        if cell == nil { // 재활용통이 비어있다면? 맨 처음에는 비어있음.
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell") // 만들어서 반환, reuseIdentifier 어떤 재활용 통에 넣어줘야 하는지 알려줌
        }
        var content = cell?.defaultContentConfiguration() //옵셔널 체이닝?으로 nil값이 나오면 무시하고 값이 있으면
        content?.text = "\(indexPath.section)번째 section \(indexPath.row)번째 row"
        cell?.contentConfiguration = content
        return cell!
        
    }


}

