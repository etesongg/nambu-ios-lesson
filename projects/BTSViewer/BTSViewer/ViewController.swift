//
//  ViewController.swift
//  BTSViewer
//
//  Created by 정송희 on 8/22/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let images = ["bts1", "bts2", "bts3", "bts4", "bts5", "bts6", "bts7"]
    var index = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: images[0])
    }

    @IBAction func next(_ sender: Any) {
        index += 1
        if index > 6 { index = 6}
        imageView.image = UIImage(named: images[index])
        
    }
    
    @IBAction func prev(_ sender: Any) {
        index -= 1
        if index < 0 {index = 0}
        imageView.image = UIImage(named: images[index])
    }
}

