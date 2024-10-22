//
//  BookTableViewController.swift
//  BookFinderWithCodable
//
//  Created by 정송희 on 10/22/24.
//

import UIKit

class BookTableViewController: UITableViewController {
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet var searchBar: UITableView!
    var books:[Book]?
    
    var page = 1 {
        didSet {
            btnPrev.isEnabled = page > 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search(query: "한강", page: page)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books?.count ?? 0
    }
    
    func search(query:String, page:Int){
        let str = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)"
        guard let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: strURL)
        else { return }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
        
            guard let data,
                let result = try? JSONDecoder().decode(Result.self, from: data) // 모델링 해준 Result임
            else { return }
            self.books = result.Books
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        task.resume()
        
    }
    
    @IBAction func actPrev(_ sender: Any) {
        page -= 1
    }
    
    @IBAction func actNext(_ sender: Any) {
        page += 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath)
        guard let book = books?[indexPath.row] else { return cell} // 책이 nil이면 빠져나옴
        let imageView = cell.viewWithTag(1) as? UIImageView
    
        let lblTitle = cell.viewWithTag(2) as? UILabel
        lblTitle?.text = book.title
            
        let lblAuthors = cell.viewWithTag(3) as? UILabel
        let authors = book.authors as? [String]
        lblAuthors?.text = authors?.joined(separator: ", ")
        
        if let thumbnail = book.thumbnail as? String { // 주소를 뽑아서 다시 리퀘스트를 보내야 함
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
