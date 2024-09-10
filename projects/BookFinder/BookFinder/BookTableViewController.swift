//
//  BookTableViewController.swift
//  BookFinder
//
//  Created by 정송희 on 9/6/24.
//

import UIKit

class BookTableViewController: UITableViewController {
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    let apiKey = ""
    var page = 1 {
        didSet {
            btnPrev.isEnabled = page > 1
            searchWithQuery(searchBar.text, page: page)
        }
    }
    
    var documents:[[String:Any]]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        btnPrev.isEnabled = false
        btnNext.isEnabled = false
    }
    
    func searchWithQuery(_ query:String?, page:Int) { // 값을 안 넣을 수도 있으니 쿼리는 옵셔널임
        guard let query else { return }
        let endPoint = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)"
        
        guard let strURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string:strURL) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // get이 기본값이기 때문에 안 넣어줘도 됨
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared // 싱글톤 객체 - 충돌방지
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                print(error.localizedDescription) // 원래 알럿이 와야함
                return
            }
            guard let data else { return }
            do {
                guard let root = try JSONSerialization.jsonObject(with: data) as? [String:Any] // 직렬화 풀기, root에는 documents, meta가 있음 전자는 어레이를 후자는 오브젝트를 가지고 있음
                else { return }
                self.documents = root["documents"] as? [[String:Any]] // root["documents"]의 타입은 Any타입임 그래서 우리가 원래 바꾸고 싶었던 대로 [[String:Any]]타입으로 타입캐스팅 해줘야 함
                if let meta = root["meta"] as? [String:Any],
                   let isEnd = meta["is_end"] as? Bool {
                    DispatchQueue.main.async {
                        self.btnNext.isEnabled = !isEnd // 프로퍼티 있는 애들은 다 self해줘야 함
                    }
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON Parsing error 발생")
            }
        }
        task.resume() // task는 세션을 통해 요청을 보냄 그리고 data, response, error를 반환받음
    }
    // 안됨
    @IBAction func actPrev(_ sender: Any) {
        page -= 1
    }
    
    @IBAction func actNext(_ sender: Any) {
        page += 1
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        documents?.count ?? 0 // nil 결합 연산자
        // 아래와 똑같음
        //        if let documents {
        //            return documents.count
        //        } else {
        //            return 0
        //        }
              
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath)
        guard let book = documents?[indexPath.row] else { return cell} // 책이 nil이면 빠져나옴
        let imageView = cell.viewWithTag(1) as? UIImageView
//        if let image = book["thumbnail"] {
//            imageView?.image = UIImage(named: image as? String ?? "")
//        }
        
        let lblTitle = cell.viewWithTag(2) as? UILabel
        lblTitle?.text = book["title"] as? String
        
        let lblAuthors = cell.viewWithTag(3) as? UILabel
        let authors = book["authors"] as? [String]
        lblAuthors?.text = authors?.joined(separator: ", ")
        
        let lblPublisher = cell.viewWithTag(4) as? UILabel
        lblPublisher?.text = book["publisher"] as? String
        
        let lblPrice = cell.viewWithTag(5) as? UILabel
        lblPrice?.text = "\((book["price"] as? Int) ?? 0)원"
        
        if let thumbnail = book["thumbnail"] as? String { // 주소를 뽑아서 다시 리퀘스트를 보내야 함
            if let url = URL(string: thumbnail) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data {
                        DispatchQueue.main.async{
                            imageView?.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow ,
            let book = documents?[indexPath.row]
        else {return}
        
        detailVC?.strURL = book["url"] as? String
    }
 

}

extension BookTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.resignFirstResponder()
    }
}
