//
//  ViewController.swift
//  SQLITEmachineTest1
//
//  Created by admin on 9/26/19.
//  Copyright © 2019 apurva. All rights reserved.
//

import UIKit
import  SQLite3

class ViewController: UIViewController {

    @IBOutlet weak var tableViewFinal: UITableView!
    
    @IBAction func plusButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Alert", message: "Please enter the food items", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
            print("okaction successful")
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        insertQuery()
    }
    
    func insertQuery() {
        
        let insertQueryData = "insert into menuTable(foodName, foodPrice) values ('hghgj', '87')"
        
        let isSuccess = DatabaseLibrary.sharedObject.executeQuery(query: insertQueryData)
        if isSuccess {
            print("insert query success")
        }
        else {
            print("insert query failed")
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Menu Card"
    }


}

