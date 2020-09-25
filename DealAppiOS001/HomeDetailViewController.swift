//
//  HomeDetailViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/16.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit
import Firebase

class HomeDetailViewController: UIViewController {
    var rowNum : Int!           //Segue로 전달 받는 값
    
    
    @IBOutlet weak var detailTitleText: UITextView!
    @IBOutlet weak var detailNameText: UILabel!
    @IBOutlet weak var detailProceText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        
        db.collection("TableData").order(by: "Date", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var i = 0
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if(self.rowNum == i){
                        self.detailTitleText.text = document.get("Title") as? String
                        self.detailNameText.text = "이름 : \(document.get("Writer") as? String ?? "") "
                        self.detailProceText.text = "\(document.get("Price") ?? "") 원"
                    }
                    i+=1
                }
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
