//
//  DetailViewController.swift
//  PlaceIn
//
//  Created by songhee jeong on 9/10/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var addInfo: UIButton!
    @IBOutlet weak var lblTel: UILabel!
    @IBOutlet weak var lblAddr2: UILabel!
    @IBOutlet weak var lblAddr1: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var festa: [String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let festa = festa else {return}
        
        lblTitle.text = festa["title"] as? String
        lblAddr1.text = festa["addr1"] as? String
        lblAddr2.text = festa["addr2"] as? String ?? "-"
        let tel = festa["tel"] as? String ?? "-"
        lblTel.text = "tel: \(tel)"
        
        imageView?.contentMode = .scaleAspectFill
        if let imageUrlString = festa["firstimage"] as? String, let imageUrl = URL(string: imageUrlString) {
            let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC = segue.destination as? AddInfoViewController else { return }
            infoVC.titleKeyword = festa?["title"] as? String
        
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

