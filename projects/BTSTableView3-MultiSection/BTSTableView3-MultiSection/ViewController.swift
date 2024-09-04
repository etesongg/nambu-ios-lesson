//
//  ViewController.swift
//  BTSTableView3-MultiSection
//
//  Created by 정송희 on 9/3/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    let exo = ["시우민","디오","첸","백현","세훈","카이","루한","레이","찬열","수호","크리스","타오"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - DataSource Delegate Methouds
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        switch indexPath.row % 5 {
        case 0: cell.accessoryType = .checkmark
        case 1: cell.accessoryType = .detailButton
        case 2: cell.accessoryType = .detailDisclosureButton
        case 3: cell.accessoryType = .disclosureIndicator
        case 4: cell.accessoryType = .none
        default: cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "BTS" : "EXO"
    }
    // Delegate titleFor 보다 viewFor가 더 우선(현재 viewFor에서 해준것만 보여줌)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if section == 0 {
            imageView.image = UIImage(systemName: "person.3.fill")
        }else {
            imageView.image = UIImage(systemName: "person.3")
        }
        return imageView
    }
    // secion header 높이 키우기
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        section == 0 ? "BTS Footer" : "EXO Footer"
//    }
}

