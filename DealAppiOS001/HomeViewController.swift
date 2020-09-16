//
//  HomeViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/15.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var namelist = ["이지용","지용이","어용지","용지이","이지룡"]
    var pricelist = [10000, 3400, 2000, 5600, 7200]
    var statelist = [1, 0, 1, 1, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
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
        
        if(statelist[indexPath.row] == 1){
            performSegue(withIdentifier: "homeDetailView", sender: nil)
        }
        else{
            showToast(message: "판매 완료된 글")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        myCell.titleLabel.text = "\(indexPath.row + 1)번째 글"
        myCell.writerLabel.text = namelist[indexPath.row]
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
    
    
    
    
    //토스트 컨트롤러
    func showToast(message : String) {
            let width_variable:CGFloat = 10
            let toastLabel = UILabel(frame: CGRect(x: width_variable, y: self.view.frame.size.height-200, width: view.frame.size.width-2*width_variable, height: 35))
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
