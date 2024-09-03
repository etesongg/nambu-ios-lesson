//
//  ViewController.swift
//  BTSTableView3-MultiSection
//
//  Created by 정송희 on 9/3/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    let exo = ["시우민","디오","첸","백현","세훈","카이","루한","레이","찬열","수호","크리스","타오"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return bts.count
//        }else {
//            return exo.count
//        }
        section == 0 ? bts.count : exo.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idol", for: indexPath)
        var config = cell.defaultContentConfiguration()
        if indexPath.section == 0{
            config.text = "\(bts[indexPath.row])"
        }else {
            config.text = "\(exo[indexPath.row])"
        }
        
        cell.contentConfiguration = config
        
        return cell
    }

}

