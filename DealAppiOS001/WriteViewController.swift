//
//  WriteViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/16.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit
import Firebase

class WriteViewController: UIViewController {
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTextView.layer.cornerRadius = 10
        priceTextView.layer.cornerRadius = 10
        
        mainTextView.text = "제목 : \n상태: \n구매시기: \n거래방법: \n상세설명: "
    }
    
    @IBAction func writeAction(_ sender: Any) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        if(mainTextView.text.count >= 10 && Int(priceTextView.text!)! >= 2000){
            // Add a second document with a generated ID.
            ref = db.collection("TableData").addDocument(data: [
                "Writer": "Alan",
                "Title": mainTextView.text ?? "",
                "Price": Int(priceTextView.text ?? "") ?? 0,
                "Date": "20200808",
                "State": 1,
                "ImageInf": "aaaa"
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            loadView()
            self.tabBarController?.selectedIndex = 0
        }
        else{
            showToast(message: "내용은 10글자 이상, 금액 2000원 이상으로 기입 하세요")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    //토스트 컨트롤러
    func showToast(message : String) {
            let width_variable:CGFloat = 10
        let toastLabel = UILabel(frame: CGRect(x: width_variable, y: self.view.frame.size.height/4, width: view.frame.size.width-2*width_variable, height: 35))
            // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
}
