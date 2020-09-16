//
//  MyDealViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/16.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit

class MyDealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var namelist = ["이지용","지용이","어용지","용지이","이지룡"]
    var pricelist = [10000, 3400, 2000, 5600, 7200]
    var statelist = [1, 0, 1, 1, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "myDealDeatailView", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "MydealCell", for: indexPath) as! MydealCell
        
        myCell.titleLabel.text = "\(indexPath.row + 1)번째 글"
        myCell.priceLabel.text = "\(pricelist[indexPath.row]) 원"
        myCell.dateLabel.text = "2020년08월11일"
        
        if(statelist[indexPath.row] == 1){
            myCell.stateLabel.text = "판매중"
        }
        else{
            myCell.stateLabel.text = "판매완료"
            myCell.backgroundColor = UIColor.lightGray
        }
        
        print("작동중")
        
        return myCell
    }
    
}
