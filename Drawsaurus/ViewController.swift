//
//  ViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-03-31.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCtoDrawView" {
            let drawVC = segue.destinationViewController as? DrawViewController
            
            drawVC?.desc = textField.text
            drawVC?.database = database
        }
    }
    
    @IBOutlet var submitDesc: UIButton!
    @IBOutlet var labelBG: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var newGameButton: UIButton!
    
    var database = Database()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGame() {
        newGameButton.hidden = true
        submitDesc.hidden = false
        labelBG.hidden = false
        textField.hidden = false
    }
}

