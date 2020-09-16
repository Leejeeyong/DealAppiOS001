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

    @IBAction func LoginButtonAction(_ sender: Any) {
        
        
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
                    }
                }
                
            }
            
            
            
        }
        
    }
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

}

