//
//  LoginViewController.swift
//  Yangpa-market
//
//  Created by 정송희 on 11/6/24.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actSignUp(_ sender: Any) {
        let parameters:Parameters = ["userName":txtID.text!, "password":txtPassword.text!]
        let endPoint = "\(host)/members/sign-up"
        let alamo = AF.request(endPoint,method: .post, parameters: parameters)
        alamo.responseDecodable(of: SignUp.self) { response in
            switch response.result {
            case .success(let signup):
                let alert = UIAlertController(title: "회원가입", message: signup.message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default) { _ in
                    self.txtID.text = ""
                    self.txtPassword.text = ""
                }
                alert.addAction(action)
                self.present(alert, animated: true)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func actSignIn(_ sender: Any) {
        let parameters:Parameters = ["userName":txtID.text!, "password":txtPassword.text!]
        let endPoint = "\(host)/members/sign-in"
        let alamo = AF.request(endPoint, method: .post, parameters: parameters)
        alamo.responseDecodable(of: SignIn.self) { response in
            switch response.result {
            case .success(let signIn):
                if signIn.success {
                    UserDefaults.standard.set(signIn.token, forKey: "token")
                    UserDefaults.standard.set(signIn.member.userName, forKey: "userName")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn") // set으로 입력할때는 타입을 안 넣고, .standard.bool(forKey: "isLoggedIn") 가져올때는 타입으로 가져옴
                    self.dismiss(animated: true) // 현재 화면에 모달로 표시된 뷰 컨트롤러를 닫는 역할
                } else {
                    let alert = UIAlertController(title: "로그인", message: signIn.message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
