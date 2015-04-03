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
    var receivedImage: UIImage!
    var database = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if receivedImage != nil {
            var image: UIImage = receivedImage
            let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
            savedImage = UIImageView(image: image)
            
            savedImage.frame = CGRect(x: 0, y: 55, width: 320, height: 400)
            view.addSubview(savedImage)
            database.listPhases()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GuessViewtoDrawView" {
            let drawVC = segue.destinationViewController as? DrawViewController
            drawVC?.desc = guessTextField.text
            drawVC?.database = database
        }
    }
}
