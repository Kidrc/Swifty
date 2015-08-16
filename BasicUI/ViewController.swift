//
//  ViewController.swift
//  BasicUI
//
//  Created by Kidrc on 8/16/15.
//  Copyright (c) 2015 Kidrc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    @IBAction func searchButton(sender: UIButton) {
        dataLabel.text = "Hello World"
    }
    
}

