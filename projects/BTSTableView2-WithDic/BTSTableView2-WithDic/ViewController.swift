//
//  ViewController.swift
//  BTSTableView2-WithDic
//
//  Created by 정송희 on 9/3/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let bts:[[String:String]] = [
        ["name":"RM","image":"bts1","desc":"1번째 멤버"],
        ["name":"진","image":"bts2","desc":"2번째 멤버"],
        ["name":"슈가","image":"bts3","desc":"3번째 멤버"],
        ["name":"제이홉","image":"bts4","desc":"4번째 멤버"],
        ["name":"지민","image":"bts5","desc":"5번째 멤버"],
        ["name":"뷔","image":"bts6","desc":"6번째 멤버"],
        ["name":"정국","image":"bts7","desc":"7번째 멤버"]]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paper", for: indexPath)
        let member:[String:String] = bts[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = member["name"] // string? 타입임 딕셔너리는 항상 옵셔널
        config.textProperties.font = .boldSystemFont(ofSize: 30)
        // 옵셔널 바인딩
        if let image = member["image"]{
            config.image = UIImage(named: image) // 이렇게 하면 (named: member["image"]!) 나중에는 키를 모르기 때문에 터짐 그래서 옵셔널 바인딩을 해야함
            config.imageProperties.maximumSize.height = 80
        }
        config.secondaryText = member["desc"]
        config.secondaryTextProperties.color = .red
        cell.contentConfiguration = config
        
        return cell
    }


}

