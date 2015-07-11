//
//  ViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-03-31.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit
import iAd

class MainMenuViewController: UIViewController, ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "VCtoDrawView" {
//            let drawVC = segue.destinationViewController as? DrawViewController
//            
//            database.append(SentencePhase(sentence: textField.text))
//            drawVC?.desc = textField.text
//            drawVC?.database = database
//        
//        } 
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MainVCtoNewGameVC" {
            let newGameVC = segue.destinationViewController as? NewGameViewController
            
            newGameVC?.friendsDB = friendsDB as? [[String : AnyObject]]
            
        } else if segue.identifier == "MainVtoDrawV" {
            let drawVC = segue.destinationViewController as? DrawViewController
            drawVC?.database = selectedGame
            if selectedGame!.count % 2 != 0 {
                drawVC?.desc = gameDesc!
            }
        } else if segue.identifier == "MainVtoGuessV" {
            let guessVC = segue.destinationViewController as? GuessViewController
            guessVC?.database = selectedGame
            if selectedGame!.count == 2 {
                guessVC?.receivedImage = gameImage!
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup aqfter loading the view, typically from a nib.
 //       newGameView.hidden = true
        
        getGameData()
        
        //iAd banner
        adBanner.hidden = true
        adBanner.delegate = self
        self.canDisplayBannerAds = true
        
        println("MainVC")
        println(friendsDB)
        
        self.existingGameTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        startTimer()
        
    }
    
    @IBOutlet var newGameButton: UIButton!
    var friendsDB = []
    var existingGameDB = ["Game #1", "Game #2"]
    var existingGameDatabase: [[Phase]] = [[SentencePhase(sentence: "life sucks and then we die."), DrawingPhase(drawing: UIImage(named: "life.png")!)], [SentencePhase(sentence: "dog eat dog world.")]]
    
    
//    func retrieveGame(gameData: AnyObject) {
//        var turns = gameData.count
//        var temporaryPhaseArray: [Phase] = []
//        for (var i = 0; i < turns; i++) {
//        
//            if i % 2 == 0 {
//                var gameInfo = gameData[i]["guess"] as? String
//                temporaryPhaseArray.append(SentencePhase(sentence: gameInfo!))
//            } else {
//                var gameInfo = gameData[i]["drawing"] as? String
//                let url: NSURL = NSURL(string: gameInfo!)!
//                let data = NSData(contentsOfURL: url)
//                temporaryPhaseArray.append(DrawingPhase(drawing: UIImage(data: data!)!))
//            }
//        }
//        println(temporaryPhaseArray)
//
//        self.existingGameDatabase.append(temporaryPhaseArray)
//        self.existingGameDB.append("Game #3")
//        println(self.existingGameDatabase)
//    }
//    
    
    func getGameData() {
        
        let url = NSURL(string:"http://localhost:8000/turns.json")
        var sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(url!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            if error == nil {
                let dataObject = NSData(contentsOfURL: location)
                let gameData: AnyObject? = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil)
                println(gameData)
                println(gameData!.count)
                //self.retrieveGame(gameData!)
                var turns = gameData!.count
                var temporaryPhaseArray: [Phase] = []
                for (var i = 0; i < turns; i++) {
                    
                    if i % 2 == 0 {
                        var gameInfo = gameData![i]["guess"] as? String
                        temporaryPhaseArray.append(SentencePhase(sentence: gameInfo!))
                    } else {
                        var gameInfo = gameData![i]["drawing"] as? String
                        let url: NSURL = NSURL(string: gameInfo!)!
                        let data = NSData(contentsOfURL: url)
                        temporaryPhaseArray.append(DrawingPhase(drawing: UIImage(data: data!)!))
                    }
                }
                
                self.existingGameDatabase.append(temporaryPhaseArray)
                self.existingGameDB.append("Game #3")
                println(self.existingGameDatabase)
                println(self.existingGameDB)
              //  var gameInfo = gameData![0]["guess"] as! String
              //  self.existingGameDatabase.append([SentencePhase(sentence: gameInfo)])
              //  self.existingGameDB.append("Game #3")
            }
        })
        downloadTask.resume()
    }
    
    //iAd stuff
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
       // NSLog("Error!")
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
    

    @IBAction func refresh(sender: UIButton) {
        self.existingGameTableView.reloadData()
    }
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var existingGameTableView: UITableView!
    @IBOutlet weak var adBanner: ADBannerView!
    var selectedGame: [Phase]?
    var gameDesc: String?
    var gameImage: UIImage?
    
    @IBAction func continueGame(sender: UIButton) {
        if selectedGame != nil {
            if selectedGame!.count % 2 == 0 {
                self.performSegueWithIdentifier("MainVtoGuessV", sender: nil)
            } else {
                self.performSegueWithIdentifier("MainVtoDrawV", sender: nil)
            }
        }
    }
    
    var timer = NSTimer()
    var timeRemaining = 9
    
    func countDown() {
        timeRemaining--
        timerLabel.text = "\(timeRemaining)"
        if timeRemaining == 0 {
            timer.invalidate()
        }
    }
    
    func startTimer() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        
    }
    
    @IBAction func newGame() {

    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existingGameDB.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let existingGameCell: ExistingGameCell = self.existingGameTableView.dequeueReusableCellWithIdentifier("ExistingGameCell") as! ExistingGameCell
        existingGameCell.existingGameLabel.text = existingGameDB[indexPath.row]
        cell = existingGameCell
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let rowHeight: CGFloat = 25
        return rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected friend #\(indexPath.row)!")
        selectedGame = existingGameDatabase[indexPath.row]
        var gameDescription: SentencePhase = selectedGame!.first as! SentencePhase
        gameDesc = gameDescription.sentence
        if selectedGame!.count == 2 {
            var gamePicture: DrawingPhase = selectedGame!.last as! DrawingPhase
            gameImage = gamePicture.drawing
            
        } else {
            var gameClue: SentencePhase = selectedGame!.last as! SentencePhase
            gameDesc = gameClue.sentence
            println(gameDesc!)
        }
    }
}

class ExistingGameCell: UITableViewCell {
    @IBOutlet weak var existingGameLabel: UILabel!
}
