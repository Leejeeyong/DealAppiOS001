//
//  HomeViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/15.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var namelist : [String] = []
    var datelist : [String] = []
    var pricelist : [Int] = []
    var statelist : [Int] = []
    var titleList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        
        db.collection("TableData").order(by: "Date", descending: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var i = 0
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.titleList.insert(document.get("Title") as! String, at: i)
                    self.namelist.insert(document.get("Writer") as! String, at: i)
                    self.datelist.insert(document.get("Date") as! String, at: i)
                    self.pricelist.insert(document.get("Price") as! Int, at: i)
                    self.statelist.insert(document.get("State") as! Int, at: i)
                    i+=1
                }
                self.tableView.reloadData()
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        initRefresh()
    }

    //테이블 새로고침 컨트롤
    func initRefresh(){
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(UpdateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "새로고침")
        
        tableView.addSubview(refresh)
        
    }
    
    //테이블 새로고침
    @objc func UpdateUI(refresh : UIRefreshControl){
        
        let db = Firestore.firestore()
        
        db.collection("TableData").order(by: "Date", descending: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var i = 0
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.titleList.insert(document.get("Title") as! String, at: i)
                    self.namelist.insert(document.get("Writer") as! String, at: i)
                    self.datelist.insert(document.get("Date") as! String, at: i)
                    self.pricelist.insert(document.get("Price") as! Int, at: i)
                    self.statelist.insert(document.get("State") as! Int, at: i)
                    i+=1
                }
            }
        }
        
        refresh.endRefreshing()
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //segue동작시 실행 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue action")
        guard let detailVC = segue.destination as? HomeDetailViewController else{ return }
        
        detailVC.rowNum = tableView.indexPathForSelectedRow?.row
        
    }
    
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
        return titleList.count-1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        let firstIndex = titleList[indexPath.row].index(titleList[indexPath.row].startIndex, offsetBy: 0)
        let lastIndex = titleList[indexPath.row].index(titleList[indexPath.row].startIndex, offsetBy: 10)
        
        myCell.titleLabel.text = "\(titleList[indexPath.row][firstIndex..<lastIndex])"
        myCell.writerLabel.text = namelist[indexPath.row]
        myCell.priceLabel.text = "\(pricelist[indexPath.row]) 원"
        myCell.dateLabel.text = datelist[indexPath.row]
        
        if(statelist[indexPath.row] == 1){
            myCell.stateLabel.text = "판매중"
            myCell.backgroundColor = nil
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
