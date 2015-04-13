//
//  GuessView.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-01.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    
    @IBOutlet var guessTextField: UITextField!
    @IBOutlet var savedImage: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet var showResultsButton: UIButton!
    
    var receivedImage: UIImage!
    var database: [Phase]!
    var receivedDesc: String?
    
    let numberOfGameIterations = 3
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GuessViewtoDrawView" {
            let drawVC = segue.destinationViewController as? DrawViewController
            drawVC?.desc = guessTextField.text
            drawVC?.database = database
        } else if segue.identifier == "GuessVCtoResultsVC" {
            let resultsVC = segue.destinationViewController as? ResultsViewController
            resultsVC?.database = database
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if receivedImage != nil {

            database.append(DrawingPhase(drawing: UIGraphicsGetImageFromCurrentImageContext()))
            database.append(SentencePhase(sentence: receivedDesc!))

            savedImage.image = receivedImage
            
            listPhases(database) //prints the database in console
        }
        
        if database.count >= numberOfGameIterations {
            sendButton.hidden = true
            showResultsButton.hidden = false
        }
    }
}
