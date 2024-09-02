//
//  ViewController.swift
//  TableViewTest1
//
//  Created by 정송희 on 9/2/24.
//

import UIKit
// tableView도 델리게이트 패턴 따름
class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.section)번째 섹션, \(indexPath.row)번째 로우"
        cell.contentConfiguration = content
        return cell
    }
}

