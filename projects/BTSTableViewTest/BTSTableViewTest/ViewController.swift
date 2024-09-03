//
//  ViewController.swift
//  BTSTableViewTest
//
//  Created by 정송희 on 9/2/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    let btsName = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self // 너의 대리인이 누구야? 나!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        btsImages.count
    }
    // row 틀 안에 cell 내용이 들어감
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration() // 만들어서 반환하는 애가 구조체(최고부모 보면 struct로 선언되어 있음)이기 때문에 var로 선언해야함
        
        content.image = UIImage(named: btsImages[indexPath.row])
        content.imageProperties.maximumSize.height = 100
        content.text = btsName[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        content.secondaryText = "\(indexPath.row+1)번째"
        content.textProperties.color = UIColor.blue
        content.secondaryTextProperties.color = UIColor.red
        cell.contentConfiguration = content
        
        return cell
    }
  


}

