//
//  NewGameViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-05-16.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewGameVCtoDrawVC" {
            let drawVC = segue.destinationViewController as? DrawViewController
            
            database.append(SentencePhase(sentence: textField.text))
            drawVC?.desc = textField.text
            drawVC?.database = database
            
        } else if segue.identifier == "NewGameVCtoFriendsVC" {
            
            let friendsVC = segue.destinationViewController as? FriendsViewController
            friendsVC?.friendList = friendsDB
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup aqfter loading the view, typically from a nib.

        if selectedFriend != nil {
            if selectedFriend != "" {
                friendLabel.text = selectedFriend!
            }
        }
        
        //assigns textfield delegate to VC
        self.textField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var submitDesc: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var friendLabel: UILabel!
    
    var database: [Phase] = []
    var selectedFriend: String?
    var friendsDB: [[String:AnyObject]]?
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //rids of keyboard when tapped anywhere but keyboard
        self.view.endEditing(true)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Hello")
        
    }
    
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}