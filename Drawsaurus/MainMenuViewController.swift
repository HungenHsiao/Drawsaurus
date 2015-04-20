//
//  ViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-03-31.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCtoDrawView" {
            let drawVC = segue.destinationViewController as? DrawViewController
            
            database.append(SentencePhase(sentence: textField.text))
            drawVC?.desc = textField.text
            drawVC?.database = database
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup aqfter loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = CGPoint(x: 115, y: 50)
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self

        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = CGPoint(x: 115, y: 50)
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var submitDesc: UIButton!
    @IBOutlet var labelBG: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var newGameButton: UIButton!
    
    @IBOutlet weak var userWelcomeLabel: UILabel!
    
    var database: [Phase] = []
    
    @IBAction func newGame() {
        newGameButton.hidden = true
        submitDesc.hidden = false
        labelBG.hidden = false
        textField.hidden = false
    }
    
    
    
    //Facebook Delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        // println(result)
        
        returnUserData()
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                // Do work
                println("User Logged In")
                newGameButton.hidden = false
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        userWelcomeLabel.text = "Please log in to play"
        newGameButton.hidden = true
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user: \(result)")
                
                let userName : NSString = result.valueForKey("first_name") as! NSString
                self.userWelcomeLabel.text = "Welcome \(String(userName))!"
                let userEmail : NSString = result.valueForKey("email") as! NSString
           //     let friendList: NSString = result.valueForKey("invitable_friends") as! NSString
            //    println(friendList)
            //    println("User Name is: \(userName)")
             //   println("User Email is: \(userEmail)")
            }
        })
        
        let graphRequest2 : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/friends", parameters: nil)
        graphRequest2.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user friends: \(result)")
            }
        })
    }
}

