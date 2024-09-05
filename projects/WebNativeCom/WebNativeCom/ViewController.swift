//
//  ViewController.swift
//  WebNativeCom
//
//  Created by 정송희 on 9/5/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webViewConfig = WKWebViewConfiguration() // 대신해주는 애를 여러명 써줄수 있음 전에는 self로 지정했음, 이거는 메시지 이름을 통해서 대신해주는 애를 구분함
        let userContnet = WKUserContentController()
        
        userContnet.add(self, name: "SendMessage") // 이것도 델리게이트임?!
        userContnet.add(self, name: "SayHello")
        userContnet.add(self, name: "SetUser")
//        let handler = MessageHandler() // 핸들러로 만들어 보기
//        userContnet.add(handler, name: "SetUser")
        webViewConfig.userContentController = userContnet
        let frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height/3 * 2)) // 버튼을 놓으려고 프레임을 조정한거임, 루트 뷰의 영역을 비워두고 나머지에 웹 정보를 보여주려고 한거임
        
        webView = WKWebView(frame: frame, configuration: webViewConfig)
        view.addSubview(webView!)
        guard let url = URL(string:"http://127.0.0.1:8080") else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
        webView?.uiDelegate = self
    }
    
    @IBAction func action1(_ sender: Any) {
        webView?.evaluateJavaScript("call_func1()")
    }
    
    @IBAction func action2(_ sender: Any) {
        let name = "에스파"
        webView?.evaluateJavaScript("call_func2('\(name)')")
    }
    
    @IBAction func action3(_ sender: Any) {
//        여기에 있는 데이터를 json으로 바꿔서 이기종간에도 이해하도록 바꿔줌, json 만들고 직렬화 해서 보냄
        let info = ["phone":"010-1111-1111","email":"a@a.com","name":"홍길동","gender":"male"]
        do { // JSONSerialization는 throw로 보낼수도 있기 때문에 try-catch로 핸들링 해줘야 함???
            let infoData:Data = try JSONSerialization.data(withJSONObject: info) // json을 만들고 그걸가지고 data를 만듦
            guard let encodedDate = String(data: infoData, encoding: .utf8) else { return }
            webView?.evaluateJavaScript("call_func3('\(encodedDate)')", completionHandler: { result, error in
                if let error {
                    return
                }
                guard let info = result as? [String:String] else {return} // raturn 값을 받을 경우 completionHandler가 필요
                print(info)
            })
            } catch {
            print("에러발생")
        }
        
        
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "SendMessage" {
            print("self:SendMessage")
        } else if message.name == "SayHello" {
            print("self:SayHello")
        } else if message.name == "SetUser" { // 위에 핸들러로 추가해놓으면 여기 실행될 일 없음
            print("SetUser")
            if let info = message.body as? [String:String] {// string 타입을 string string 딕셔너리의 옵셔널로 바꾼것
                print(info["name"]!, info["email"]!, info["gender"]!)
            }
        } else {
            print("정의되지 않은 메세지")
        }
    }
}

extension ViewController:WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert) // 우리가 title을 가지고 어떤 일을 하는게 아니기 때문에 nil값을 넣어줌
        let actionOkay = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler(true)
        }
        let actionCancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            completionHandler(false)
        }
        alert.addAction(actionOkay)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = defaultText
        }
        let action = UIAlertAction(title: "입력하시오", style: .default) { _ in
            if let text1 = alert.textFields?[0] { // alert에 add로 더했으니 여러개 넣을 수 있음 그래서 Fields이고 인덱스 0 인걸 가져와야 함
                let text = text1.text == "" ? defaultText : text1.text
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//class MessageHandler: NSObject, WKScriptMessageHandler {
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print("Message Handler: \(message)")
//    }
//}

