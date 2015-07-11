//
//  WelcomeViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-05-15.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WelcomeVCtoMainVC" {
            let mainVC = segue.destinationViewController as? MainMenuViewController
            mainVC?.friendsDB = friendsDB
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup aqfter loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            let loginView : FBSDKLoginButton = FBSDKLoginButton()

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    //Facebook Delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
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
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")

        
        //make the newGameButton hidden true later

    }
    
    var friendsDB = []
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user: \(result)")
                
                let userName : NSString = result.valueForKey("first_name") as! NSString
                //    let userEmail : NSString = result.valueForKey("email") as! NSString
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
                let friendsData = result.valueForKey("data") as? [[String:AnyObject]]
                self.friendsDB = friendsData!
            }
        })
        
        let token = FBSDKAccessToken.currentAccessToken().tokenString
        println("token: \(token)")
    }
    
}
