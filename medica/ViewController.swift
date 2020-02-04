//
//  ViewController.swift
//  medica
//
//  Created by 위의석 on 2020/01/31.
//  Copyright © 2020 Wi's Works. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }


}

