//
//  ViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-03-31.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit
import iAd

class MainMenuViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate, ADBannerViewDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCtoDrawView" {
            let drawVC = segue.destinationViewController as? DrawViewController
            
            database.append(SentencePhase(sentence: textField.text))
            drawVC?.desc = textField.text
            drawVC?.database = database
        } else if segue.identifier == "MainVCtoFriendsVC" {
            let friendsVC = segue.destinationViewController as? FriendsViewController
            friendsVC?.friendList = friendsDB
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup aqfter loading the view, typically from a nib.
        submitDesc.hidden = true
        labelBG.hidden = true
        textField.hidden = true
        friendButton.hidden = true
        friendLabel.hidden = true
        //banner is hidden as soon as view loads b/c the block will be blank when the view loads
        adBanner.hidden = true
        
        //assign delegate to self (the MainMenuViewController); allows us to load our banner in and out of the scene even when there's nothing inside
        adBanner.delegate = self
        
        //allows VC to display the bannerAds
        self.canDisplayBannerAds = true
        
        if selectedFriend != nil {
            if selectedFriend != "" {
                friendLabel.text = selectedFriend!
            }
        }
        
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
        
        //assigns textfield delegate to VC
        self.textField.delegate = self
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        NSLog("Error!")
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        //will load ad
    }
    
    //animate on and into our scene; apple requires ad to be animated onto the scene instead of popped up
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        adBanner.hidden = false
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var submitDesc: UIButton!
    @IBOutlet var labelBG: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var adBanner: ADBannerView!
    @IBOutlet weak var userWelcomeLabel: UILabel!
    
    var database: [Phase] = []
    var selectedFriend: String?
    var friendsDB: [[String:AnyObject]]?
    
    @IBAction func newGame() {
        newGameButton.hidden = true
        submitDesc.hidden = false
        labelBG.hidden = false
        textField.hidden = false
        friendButton.hidden = false
        friendLabel.hidden = false
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
                newGameButton.hidden = false
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        userWelcomeLabel.text = "Please log in to play"
        
        //make the newGameButton hidden true later
        newGameButton.hidden = false
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
                self.friendsDB = friendsData
            }
        })
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //rids of keyboard when tapped anywhere but keyboard
        self.view.endEditing(true)
    }
    
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

