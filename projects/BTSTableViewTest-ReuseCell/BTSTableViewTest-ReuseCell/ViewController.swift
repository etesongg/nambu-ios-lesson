//
//  ViewController.swift
//  BTSTableViewTest-ReuseCell
//
//  Created by 정송희 on 9/3/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblMember: UILabel!
    
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    let btsName = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        btsImages.count
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bts", for: indexPath)
//        var config = cell.defaultContentConfiguration()
//        
//        config.image = UIImage(named: btsImages[indexPath.row])
//        config.imageProperties.maximumSize.height = 100
//        config.text = btsName[indexPath.row]
//        config.textProperties.font = .systemFont(ofSize: 30, weight: .bold)
//        config.textProperties.color = .blue
//        config.secondaryText = "\(indexPath.row+1)번째 \(config.text!)"
//        config.secondaryTextProperties.color = .red
//        
//        cell.contentConfiguration = config
//        
//        return cell
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "bts")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "bts") // PrototypeCell이 0이어야 함
        }
        
        var config = cell!.defaultContentConfiguration() // cell이 nil이 아니라는 보장이 있으니 강제로 언래핑 해줌(위에서 nil 검사 하니까)
        config.image = UIImage(named: btsImages[indexPath.row])
        config.imageProperties.maximumSize.height = 80
        config.text = "\(btsName[indexPath.row])"
        config.textProperties.font = .systemFont(ofSize: 30, weight: .heavy)
        config.textProperties.color = .blue
        config.secondaryText = "\(indexPath.row + 1)"
        config.secondaryTextProperties.color = .red
        
        cell?.contentConfiguration = config
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lblMember.text = "\(indexPath.row+1)번째 멤버의 이름은 \(btsName[indexPath.row])"
    }
}

