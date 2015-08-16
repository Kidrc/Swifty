//
//  ViewController.swift
//  BasicUI
//
//  Created by Kidrc on 8/16/15.
//  Copyright (c) 2015 Kidrc. All rights reserved.
//

import UIKit

struct LSummonerObject {
    var id:String = ""
    var name:String = ""
    var level:String = ""
    var rank:String = ""
    var division:String = ""
}

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
        if let result = lol_Search_By_Name(nameText.text) {
            dataLabel.text = result.rank + " " + result.division
        }
        else {
            dataLabel.text = "Summoner Not Found"
        }
    }
    
    // MARK: Actions
    
    @IBAction func searchButton(sender: UIButton) {
        if let result = lol_Search_By_Name(nameText.text) {
            dataLabel.text = result.rank + " " + result.division
        }
        else {
            dataLabel.text = "Summoner Not Found"
        }
    }
}

func lol_Search_By_Name(name:String) -> LSummonerObject? {
    var receivedObject = LSummonerObject()
    
    var encodedName = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    var urlString = "https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/" + encodedName + "?api_key=f948774c-1584-4faa-bf93-03f0b344ef9a"
    var url = NSURL(string: urlString)!
    
    var session = NSURLSession.sharedSession()
    var request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"
    request.addValue("text/html", forHTTPHeaderField: "Content-Type")
    
    var completed = false
    var receivedData:NSData = NSData()
    
    var task = session.dataTaskWithRequest(request) {
        (data, response, error) -> Void in
        if error != nil {
        }
        else {
            receivedData = data
            completed = true
        }
    }
    task.resume()
    
    while(!completed) {}
    completed = false
    
    var json = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject]
    var standardName = name.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString
    receivedObject.name = json![standardName]!["name"] as! String
    receivedObject.id = String(json![standardName]!["id"] as! Int)
    
    
    urlString = "https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/"+receivedObject.id+"/entry?api_key=f948774c-1584-4faa-bf93-03f0b344ef9a"
    url = NSURL(string: urlString)!
    request.URL = url
    
    task = session.dataTaskWithRequest(request) {
        (data, response, error) -> Void in
        if error != nil {
            
        }
        else {
            receivedData = data
            completed = true
        }
    }
    task.resume()
    
    while(!completed){}
    completed = false
    
    json = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject]
    
    var id = receivedObject.id
    receivedObject.rank = json![id]![0]!["tier"] as! String
    receivedObject.division = json![id]![0]!["entries"]!![0]!["division"] as! String
    return receivedObject
}



