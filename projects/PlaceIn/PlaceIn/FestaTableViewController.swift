//
//  FestaTableViewController.swift
//  PlaceIn
//
//  Created by 정송희 on 9/9/24.
//

import UIKit

class FestaTableViewController: UITableViewController {
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var pickerView: UIPickerView!
    var areaData: [(code: String, name: String)] = []
    let apiKey = "xozPkq%2BiV%2FoJagSV4GOgGCuilEOLlfDGKUpqMzbzvKYOmP%2FIAzBXoXrJZW%2B81iqTf%2B%2B7NSPW8prKqZP0CuL2xA%3D%3D"
    var itemArray: [[String: Any]]?
    var areaCode = 1
    var keyword: String?
    var page = 1 {
        didSet {
            btnPrev.isEnabled = page > 1
            if let keyword = keyword, !keyword.isEmpty {
                searchWithQuery(keyword, page: 1)
            } else {
                getDefaultData(page: page)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        tableView.rowHeight = 150
        btnPrev.isEnabled = false
        btnNext.isEnabled = false
        getDefaultData(page: 1)
    
    }
    
    
    func getDefaultData(page: Int) {
        let urlString = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=10&pageNo=\(page)&MobileOS=IOS&MobileApp=AppTest&serviceKey=\(apiKey)&_type=json&listYN=Y&arrange=O&areaCode=\(areaCode)&contentTypeId=15"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let data else { return }
            do {
                guard let root = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let response = root["response"] as? [String: Any] else { return }
                guard let body = response["body"] as? [String: Any] else { return }
                guard let items = body["items"] as? [String: Any] else { return }
                guard let item = items["item"] as? [[String: Any]] else { return }
                self.itemArray = item
                
                if let totalCount = body["totalCount"] as? Int,
                   let numOfRows = body["numOfRows"] as? Int, let pageNo = body["pageNo"] as? Double {
                    let totalPages = ceil(Double(totalCount) / Double(numOfRows))
                    DispatchQueue.main.async {
                        self.btnNext.isEnabled = pageNo < totalPages
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("json parsing error")
            }
        }
        task.resume()
    }
    
    func searchWithQuery(_ keyword: String?, page: Int) {
        guard let keyword else { return }
        let urlString = "https://apis.data.go.kr/B551011/KorService1/searchKeyword1?numOfRows=10&pageNo=\(page)&MobileOS=IOS&MobileApp=AppTest&serviceKey=\(apiKey)&_type=json&listYN=Y&arrange=O&areaCode=\(areaCode)&contentTypeId=15&keyword=\(keyword)"
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let data else { return }
            do {
                guard let root = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let response = root["response"] as? [String: Any] else { return }
                guard let body = response["body"] as? [String: Any] else { return }
                guard let items = body["items"] as? [String: Any] else { return }
                guard let item = items["item"] as? [[String: Any]] else { return }
                self.itemArray = item
                
                if let totalCount = body["totalCount"] as? Int,
                   let numOfRows = body["numOfRows"] as? Int, let pageNo = body["pageNo"] as? Double {
                    let totalPages = ceil(Double(totalCount) / Double(numOfRows))
                    DispatchQueue.main.async {
                        self.btnNext.isEnabled = pageNo < totalPages
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("json parsing error")
            }
        }
        task.resume()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "festa", for: indexPath)
        guard let festa = itemArray?[indexPath.row] else { return cell }
        
        let imageView = cell.viewWithTag(1) as? UIImageView
        imageView?.contentMode = .scaleAspectFill
        if let thumbnail = festa["firstimage2"] as? String {
            if let url = URL(string: thumbnail) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data {
                        DispatchQueue.main.async {
                            imageView?.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
        }
        
        let lblTitle = cell.viewWithTag(2) as? UILabel
        lblTitle?.text = festa["title"] as? String
        
        let lblAdress = cell.viewWithTag(3) as? UILabel
        lblAdress?.text = festa["addr1"] as? String
        
        let lblTel = cell.viewWithTag(4) as? UILabel
        guard let tel = festa["tel"] as? String else { return cell }
        lblTel?.text = "tel: \(tel.count > 0 ? tel : "-")"
        return cell
    }
    
    @IBAction func actPrev(_ sender: Any) {
        page -= 1
    }
    
    @IBAction func actNext(_ sender: Any) {
        page += 1
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
        guard let detailVC = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let festa = itemArray?[indexPath.row] else { return }
        
        detailVC.festa = festa
    }
}

extension FestaTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        self.keyword = keyword // keyword 사용
        page = 1
        searchBar.resignFirstResponder()
        print("Searching for keyword: \(self.keyword ?? ""), page: \(page)")
        searchWithQuery(self.keyword, page: page)
    }
}
extension FestaTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    var areaList: [(code: String, name: String)] {
        return [
            (code: "1", name: "서울"),
            (code: "2", name: "인천"),
            (code: "3", name: "대전"),
            (code: "4", name: "대구"),
            (code: "5", name: "광주"),
            (code: "6", name: "부산"),
            (code: "7", name: "울산"),
            (code: "8", name: "세종특별자치시"),
            (code: "31", name: "경기도"),
            (code: "32", name: "강원특별자치도"),
            (code: "33", name: "충청북도"),
            (code: "34", name: "충청남도"),
            (code: "35", name: "경상북도"),
            (code: "36", name: "경상남도"),
            (code: "37", name: "전북특별자치도"),
            (code: "38", name: "전라남도"),
            (code: "39", name: "제주도")]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        areaList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        areaList[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedArea = areaList[row]
        print("Selected Area: \(selectedArea.name), Code: \(selectedArea.code)")
        self.areaCode = Int(selectedArea.code) ?? 0
        getDefaultData(page: 1)
    }
}
