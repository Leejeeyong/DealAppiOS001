//
//  ViewController.swift
//  DealAppiOS001
//
//  Created by LEEJEEYONG on 2020/09/13.
//  Copyright © 2020 koiware. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        
    }
    
    class tableViewCell: UITableViewCell{
        @IBOutlet weak var imageviewCell: UIImageView!
        @IBOutlet weak var titleLabelCell: UILabel!
        
    }
}

