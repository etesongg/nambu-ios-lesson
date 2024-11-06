//
//  MainTableViewController.swift
//  Yangpa-market
//
//  Created by 정송희 on 11/6/24.
//

import UIKit
import Alamofire
import AlamofireImage

class MainTableViewController: UITableViewController {
    var documents:[Document]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기 로그인 처리(로그인 시 로그인 뷰 안 나옴)
        if !UserDefaults.standard.bool(forKey: "isLoggedIn") { // false면 로그인 필요
            if let loginVC = storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController{
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true)
            }
        }
        
        // sale 목록 보여주기
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]

        let endPoint = "\(host)/sales"
        AF.request(endPoint, method: .get, headers: headers).responseDecodable(of: SalesResult.self) { response in
            switch response.result {
                case .success(let salesResult):
                    self.documents = salesResult.documents
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                        print(error.localizedDescription)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return documents?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let document = documents?[indexPath.row] else { return cell }
        
        let productImage = cell.viewWithTag(1) as? UIImageView
        let imageURL = "\(storage)/yangpa/\(document.photo)"
        productImage?.af.setImage(withURL: URL(string: imageURL)!)
//        AF.request(imageURL).responseData { response in
//            if let data = response.data {
//                productImage?.image = UIImage(data: data)
//            } else {
//                productImage?.image = UIImage(named: "defaultImage")
//            }
//        }
        let lblProductName = cell.viewWithTag(2) as? UILabel
        lblProductName?.text = document.productName
        let lblPrice = cell.viewWithTag(3) as? UILabel
        lblPrice?.text = "₩ \(document.price)"
        return cell
    }

    @IBAction func actLogout(_ sender: Any) {
    }
    
}
