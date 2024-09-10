//
//  FestaViewController.swift
//  PlaceIn
//
//  Created by 정송희 on 9/10/24.
//

import UIKit

class FestaViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    var itemArray: [[String: Any]]?
    var areaCode = 1
    var keyword: String?
    var areaData: [(code: String, name: String)] = []
    let apiKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnPrev.isEnabled = false
        btnNext.isEnabled = false
        
        searchBar.delegate = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        tableView.dataSource = self
        tableView.rowHeight = 150
        
        getDefaultData(page: 1)
        lblTitle.text = "Festa!"
    }
    
    func changeJson(urlString: String){
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("getDefaultData session \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                guard let root = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let response = root["response"] as? [String: Any],
                      let body = response["body"] as? [String: Any],
                      let items = body["items"] as? [String: Any],
                      let item = items["item"] as? [[String: Any]] else { return }
                
                self?.itemArray = item
                
                if let totalCount = body["totalCount"] as? Int,
                   let numOfRows = body["numOfRows"] as? Int,
                   let pageNo = body["pageNo"] as? Double {
                    let totalPages = ceil(Double(totalCount) / Double(numOfRows))
                    DispatchQueue.main.async {
                        self?.btnNext.isEnabled = pageNo < totalPages
                        self?.tableView.reloadData()
                    }
                }
            } catch {
                print("getDefaultData catch \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getDefaultData(page: Int) {
        let urlString = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=10&pageNo=\(page)&MobileOS=IOS&MobileApp=AppTest&serviceKey=\(apiKey)&_type=json&listYN=Y&arrange=O&areaCode=\(areaCode)&contentTypeId=15"
        changeJson(urlString: urlString)
    }
    
    func searchWithQuery(_ keyword: String?, page: Int) {
        guard let keyword = keyword,
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  else { return }

        let urlString = "https://apis.data.go.kr/B551011/KorService1/searchKeyword1?numOfRows=10&pageNo=\(page)&MobileOS=IOS&MobileApp=AppTest&serviceKey=\(apiKey)&_type=json&listYN=Y&arrange=O&areaCode=\(areaCode)&contentTypeId=15&keyword=\(encodedKeyword)"
        changeJson(urlString: urlString)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "festa", for: indexPath)
        guard let festa = itemArray?[indexPath.row] else { return cell }
        
        let imageView = cell.viewWithTag(1) as? UIImageView
        imageView?.contentMode = .scaleAspectFill
        if let thumbnail = festa["firstimage"] as? String {
            if let url = URL(string: thumbnail) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
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
        
        let lblAddress = cell.viewWithTag(3) as? UILabel
        lblAddress?.text = festa["addr1"] as? String
        
        let lblTel = cell.viewWithTag(4) as? UILabel
        lblTel?.text = "tel: \(festa["tel"] as? String ?? "-")"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let festa = itemArray?[indexPath.row] else { return }
        
        detailVC.festa = festa
    }
    
    @IBAction func actNext(_ sender: Any) {
        page += 1
    }
    
    @IBAction func actPrev(_ sender: Any) {
        page -= 1
    }
}

extension FestaViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    var areaCodes: [(code: String, name: String)] {
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
            (code: "39", name: "제주도")
        ]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return areaCodes.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return areaCodes[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedArea = areaCodes[row]
        self.areaCode = Int(selectedArea.code) ?? 0
        if let keyword = self.keyword, !keyword.isEmpty {
            searchWithQuery(keyword, page: 1)
        } else {
            getDefaultData(page: 1)
        }
    }
}

extension FestaViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        self.keyword = keyword
        searchWithQuery(self.keyword, page: 1)
        searchBar.resignFirstResponder()
        
    }
}
