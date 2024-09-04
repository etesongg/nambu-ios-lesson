//
//  MainTableViewController.swift
//  TableViewControllerTest
//
//  Created by 정송희 on 9/4/24.
//

import UIKit

class MainTableViewController: UITableViewController {
    let btsImages = ["bts1","bts2","bts3","bts4","bts5","bts6","bts7"]
    let bts = ["RM", "진", "슈가", "제이홉", "지민", "뷔", "정국"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
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
        return bts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        if indexPath.row % 2 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "bts", for: indexPath)
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: "bts1", for: indexPath)
        }
        let imageView = cell.viewWithTag(1) as? UIImageView
        imageView?.image = UIImage(named: btsImages[indexPath.row])
        let lblNick = cell.viewWithTag(2) as? UILabel
        lblNick?.text = bts[indexPath.row]
        let lblDesc = cell.viewWithTag(3) as? UILabel
        lblDesc?.text = "\(indexPath.row+1)번째 멤버"

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
