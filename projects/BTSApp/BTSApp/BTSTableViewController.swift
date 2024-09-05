//
//  BTSTableViewController.swift
//  BTSApp
//
//  Created by 정송희 on 9/4/24.
//

import UIKit

class BTSTableViewController: UITableViewController {
//    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
//    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
    let bts:[[String:String]] = [
        ["name":"RM","image":"bts1","desc":"1번째 멤버"],
        ["name":"진","image":"bts2","desc":"2번째 멤버"],
        ["name":"슈가","image":"bts3","desc":"3번째 멤버"],
        ["name":"제이홉","image":"bts4","desc":"4번째 멤버"],
        ["name":"지민","image":"bts5","desc":"5번째 멤버"],
        ["name":"뷔","image":"bts6","desc":"6번째 멤버"],
        ["name":"정국","image":"bts7","desc":"7번째 멤버"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        title = "BTS"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bts", for: indexPath)
        // 데이터가 딕셔너리 형태면 이렇게 해야함
        let member:[String:String] = bts[indexPath.row] // ["desc": "1번째 멤버", "name": "RM", "image": "bts1"]
        let imageView = cell.viewWithTag(1) as? UIImageView
        // 이미지네임은 꼭 언래핑을 해줘야 해서 처리해준거임
        if let image = member["image"] { // image = bts1
            imageView?.image = UIImage(named: image) // (named: image)
        }
        let lblNick = cell.viewWithTag(2) as? UILabel
        lblNick?.text = member["name"]
            
        let lblDesc = cell.viewWithTag(3) as? UILabel
        lblDesc?.text = member["desc"]

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
        let newVC = segue.destination as? DetailViewController // 전환될 뷰 컨트롤러 지정, newVC의 타입은 DetailViewController?이 됨
        guard let newVC = newVC, let indexPath = tableView.indexPathForSelectedRow else { // guard let 구문을 사용하여 옵셔널 바인딩 함, newVC가 nil이면 빠져나감, 이때는 guard let이 알맞음
            return
        }
        newVC.member = bts[indexPath.row]
    }


}
