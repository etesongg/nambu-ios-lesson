//
//  BTSViewController.swift
//  BTSViewer2
//
//  Created by 정송희 on 8/30/24.
//

import UIKit

class BTSViewController: UIViewController {

    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var index = 0 { // 옵저버를 통해 changeImage()를 여기에만 두고 다 없앨 수 있음
        didSet{ changeImage() }
    }
    var btsImages = ["bts1", "bts2", "bts3", "bts4","bts5","bts6","bts7"]
    
    func changeImage() {
        btnPrev.isEnabled = true
        btnNext.isEnabled = true
        label.text = "\(index+1)/\(btsImages.count)"
        pageControl.currentPage = index
        if index == 0 {
            btnPrev.isEnabled = false
        }
        if index == btsImages.count - 1 {
            btnNext.isEnabled = false
        }
        imageView.image = UIImage(named: btsImages[index])
    }
    
    @IBAction func changePage(_ sender: UIPageControl) {
        index = sender.currentPage // pageControl 버튼으로 움직일 수 있게 하기 위해 인덱스 값 넣어주기, 이건 sender 사용
//        index = pageControl.currentPage // 위에 동작과 같음, 이건 아울렛으로 지정한 값(pageControl: UIPageControl!) 사용
    }
    @IBAction func actPrev(_ sender: Any) {
        index -= 1
//        changeImage()
    }
    @IBAction func actNext(_ sender: Any) {
        index += 1
//        changeImage()
    }
    
    override func viewDidLoad() { // loadeView() 때는 이미지 인스턴스가 아직 안 만들어져 있음
        super.viewDidLoad()
        pageControl.numberOfPages = btsImages.count
        pageControl.currentPage = index // 기존에 0 으로 설정되어 있긴 함.
        index = 0
//        changeImage()
    }
}
