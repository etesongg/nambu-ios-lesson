//
//  DetailViewController.swift
//  Translator-test
//
//  Created by 정송희 on 11/5/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var result:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = result
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
