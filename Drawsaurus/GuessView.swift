//
//  GuessView.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-01.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    
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
    
    @IBOutlet var guessTextField: UITextField!
    @IBOutlet var savedImage: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet var showResultsButton: UIButton!
    
    var receivedImage: UIImage!
    var database: Database!
    var receivedDesc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if receivedImage != nil {

            database.addPhase(PhaseInfo(description: receivedDesc!, imageSaved: UIGraphicsGetImageFromCurrentImageContext()))
            savedImage.image = receivedImage
            
            database.listPhases()  //prints the database in console
        }
        
        if database.phases.count == 6 {
            sendButton.hidden = true
            showResultsButton.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
}
