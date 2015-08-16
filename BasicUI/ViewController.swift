//
//  ViewController.swift
//  BasicUI
//
//  Created by Kidrc on 8/16/15.
//  Copyright (c) 2015 Kidrc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Handle the text field's user inputs through delegate callbacks.
        nameText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide the keyboard.
        nameText.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        lol_Search_By_Name()
    }
    
    // MARK: Actions
    
    @IBAction func searchButton(sender: UIButton) {
        lol_Search_By_Name()
    }

    func lol_Search_By_Name() {
        dataLabel.text = nameText.text;
    }


    
}

