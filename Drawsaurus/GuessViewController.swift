//
//  GuessView.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-01.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var guessTextField: UITextField!
    @IBOutlet var savedImage: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet var showResultsButton: UIButton!
    
    var receivedImage: UIImage!
    var database: [Phase]!
    var receivedDesc: String?
    
    let numberOfGameIterations = 3
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        database.append(SentencePhase(sentence: guessTextField.text))
        
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

            savedImage.image = receivedImage
            
            listPhases(database) //prints the database in console
        }
        
        if database.count >= numberOfGameIterations {
            sendButton.hidden = true
            showResultsButton.hidden = false
        }
        
        if database.count == 1 {
 //           savedImage.image = database[1] as? DrawingPhase
        }
        
        //assigns textfield delegate to VC
        self.guessTextField.delegate = self
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
