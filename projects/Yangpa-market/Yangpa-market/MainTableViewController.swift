//
//  MainTableViewController.swift
//  Yangpa-market
//
//  Created by 정송희 on 11/6/24.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserDefaults.standard.bool(forKey: "isLoggedIn") { // false면 로그인 필요
            if let loginVC = storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController{
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func actLogout(_ sender: Any) {
    }
    
}
