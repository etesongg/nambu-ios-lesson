//
//  MainTableViewController.swift
//  PListTest
//
//  Created by 정송희 on 10/21/24.
//

import UIKit

class MainTableViewController: UITableViewController {
    var bts:NSMutableArray? // 배열의 내용을 변경할 수 있는 즉, 가변(mutable) 배열을 만들기 위해서

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManage = FileManager.default // 파일 핸들링, 여러 앱이 동시에 파일 시스템에 접근할 때 충돌을 방지하기 위해 싱글톤 객체로 만듬
        let targetURL = urlWithFileName("bts.plist")
        print(targetURL)
        guard fileManage.fileExists(atPath: targetURL.path()) // 파일 유무 판단, URL -> string으로 변환 path() 사용
        else {
            guard let originURL = Bundle.main.url(forResource: "bts.plist", withExtension: nil)// 파일 url
            else {
                print("원본을 찾을 수 없습니다.")
                return
            }
            do{
                try fileManage.copyItem(at: originURL, to: targetURL)
            }catch {
                print("복사 실패")
            }
            return
        }
        bts = try? NSMutableArray(contentsOf: targetURL, error: ())
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    
    // unwind segue가 도착하고서 실행돼야하기 때문에 main에 만들어 줘야 함
    @IBAction func retrunFromAdd(segue:UIStoryboardSegue){
        guard let bts else { return }
//        tableView.reloadData() // 쓸데없이 전체 리로드 중, 낭비임
        let indexPath = IndexPath(row: bts.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade) // indexPath에 맞는 selfRow가 실행됨, 추가된 인덱스만 로드되는거임
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bts?.count ?? 0 // nil이면 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bts", for: indexPath) // 재사용

        guard let member = bts?[indexPath.row] as? [String:String] else { return cell }
        let imgProfile = cell.viewWithTag(1) as? UIImageView // as로 형변환
        let lblNick = cell.viewWithTag(2) as? UILabel
        let lblDesc = cell.viewWithTag(3) as? UILabel
        
        // 이미지 보이게 하기
        if let imageName = member["image"] { // 여기서는 if let이 더 적합함. imageName이 없다고 다른 요소도 안 보여주는건 이상
            if imageName.starts(with: "bts"){
                imgProfile?.image = UIImage(named: imageName)
            } else {
                let path = urlWithFileName(imageName, type: .png).path()
                imgProfile?.image = UIImage(contentsOfFile: path)
            }
            
        }
        
        lblNick?.text = member["nick"] // text는 기본적으로 옵셔널(String?)로 정의 하기 때문에 언래핑 필요없음
        lblDesc?.text = member["desc"]
        
        return cell
    }
    

    // 삭제 권한 주기 true 허용, false 허용 안 함, indexpath를 받기때문에 section, row로도 설정가능
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row % 2 == 0 ? .delete : .insert // edit 모드를 insert로 할것인지 delete로 할 것인지 정함
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let target = urlWithFileName("bts.plist")
        if editingStyle == .delete {
            // Delete the row from the data source
            bts?.removeObject(at: indexPath.row) // 갯수를 맞춰줘야 안 터짐, 데이터 소스 배열(bts)의 갯수와 테이블 뷰의 행(row) 수가 일치
            try? bts?.write(to: target) // list에 업데이트
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            let newMemeber = ["nick":"차은우", "desc":"new member", "image":"default"]
            bts?.insert(newMemeber, at: indexPath.row)
            try? bts?.write(to: target)
            tableView.insertRows(at: [indexPath], with: .left)
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let target = urlWithFileName("bts.plist")
        guard let bts else { return }
        let member = bts[fromIndexPath.row]
        bts.removeObject(at: fromIndexPath.row)
        bts.insert(member, at: to.row)
        try? bts.write(to: target) // 순서를 바꿨으면 plist에 업데이트 해줘야 앱을 껐다켜도 유지됨, 하드디스크에 저장하는 거기 때문에 예외처리 해줘야 함
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addVc = segue.destination as? AddViewController else { return }
        addVc.bts = bts
    }
    
    

}
