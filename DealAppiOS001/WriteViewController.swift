//
//  WriteViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/16.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTextView.layer.cornerRadius = 10
        priceTextView.layer.cornerRadius = 10
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

}
