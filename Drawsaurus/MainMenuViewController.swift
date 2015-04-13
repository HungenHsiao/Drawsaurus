//
//  ViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-03-31.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCtoDrawView" {
            let drawVC = segue.destinationViewController as? DrawViewController
            
            database.append(SentencePhase(sentence: textField.text))
            drawVC?.desc = textField.text
            drawVC?.database = database
        }
    }
    
    @IBOutlet var submitDesc: UIButton!
    @IBOutlet var labelBG: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var newGameButton: UIButton!
    
    var database: [Phase] = []
    
    @IBAction func newGame() {
        newGameButton.hidden = true
        submitDesc.hidden = false
        labelBG.hidden = false
        textField.hidden = false
    }
}

