//
//  BookTableViewController.swift
//  BookFinderWithAF
//
//  Created by 정송희 on 10/28/24.
//

import UIKit
import Alamofire
import Kingfisher

class BookTableViewController: UITableViewController {
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    var books: [Book]?
    var page = 0 {
        didSet {
            btnPrev.isEnabled = page > 1
            search(query: searchBar.text, page: page) // didSet에 넣어줘서 actNext, Prev에 안 넣어줘도 됨
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnPrev.isEnabled = false
        btnNext.isEnabled = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func search(query: String?,page: Int){
        guard let query else { return }
        let endPoint = "https://dapi.kakao.com/v3/search/book"
        let params:Parameters = ["query":query,"page":page] // body에 들어가는거 여기에 넣기 String : any 로 추론 , 타입을 꼭 적어줘야됨
        let headers:HTTPHeaders = ["Authorization":apiKey]
        
        //리퀘스트 만들기
        let alamo = AF.request(endPoint, method: .get, parameters: params,headers: headers )//생략은 가능하나 순서를 꼭 지켜줘야함
        alamo.responseDecodable(of:Root.self) { response in //(of:Root.self->파싱할모델)
            switch response.result {
            case .success(let root):
                self.books = root.Books
//                var meta = root.meta
                DispatchQueue.main.async {
                    self.btnNext.isEnabled = !root.meta.isEnd
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
        return books?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath)
        
        guard let book = books?[indexPath.row] else { return cell }
        
        let imgCover = cell.viewWithTag(1) as? UIImageView
        let lblTitle = cell.viewWithTag(2) as? UILabel
        let lblAuthors = cell.viewWithTag(3) as? UILabel
        
        lblTitle?.text = book.title
        lblAuthors?.text = book.authors.joined(separator: ", ")
        let coverURL = URL(string: book.thumbnail)
        imgCover?.kf.setImage(with: coverURL, placeholder: UIImage(systemName: "book.closed.fill")) // imgCover 이미지 뷰에 coverURL에 해당하는 이미지를 다운로드하고, 다운로드되는 동안 "book.closed.fill"을 표시

        return cell
    }
    
    
    @IBAction func actNext(_ sender: UIBarButtonItem) {
        page += sender.tag // Prev, Next 같이 사용하기 둘의 태그를 +1, -1로 해줌
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow ,
              let book = self.books?[indexPath.row]
                else { return }
        
        detailVC?.strUrl = book.url
    }
    

}

extension BookTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        search(query: searchBar.text, page: 1)
        page = 1
        searchBar.resignFirstResponder()
    }
}
