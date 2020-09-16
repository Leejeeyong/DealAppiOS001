//
//  ViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/13.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController{
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var InfoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        
        db.collection("UserData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func LoginButtonAction(_ sender: Any) {
        
        view.endEditing(true)
        
        let db = Firestore.firestore()
        
        db.collection("UserData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(self.IDTextField.text == (document.get("ID") as! String)){
                        print("아이디 일치")
                        if(self.InfoTextField.text == (document.get("PASSWORD") as! String)){
                            print("비밀번호 일치")
                            print("\(document.data())")
                            self.performSegue(withIdentifier: "showLogintComp", sender: nil)
                        }
                        else{
                            self.showToast(message: "비밀번호 오류")
                        }
                    }
                }
                
            }
            
            
            
        }
        
    }
    
    
    
    
    
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
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

}

