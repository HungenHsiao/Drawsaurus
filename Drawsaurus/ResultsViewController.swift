//
//  ResultsViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-07.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var desc0: UILabel!
    @IBOutlet weak var desc1: UILabel!
    @IBOutlet weak var desc2: UILabel!
    @IBOutlet weak var desc3: UILabel!
    @IBOutlet weak var desc4: UILabel!
    @IBOutlet weak var desc5: UILabel!
    
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    var descArray: [UILabel] = []
    var imageArray: [UIImageView] = []
    var database: Database!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //arrays labels and imageviews
        descArray = [
            desc0, desc1, desc2, desc3, desc4, desc5
        ]
        imageArray = [
            image0, image1, image2, image3, image4, image5
        ]
        
        for index in 0 ..< database.phases.count {
            descArray[index].text = database.phases[index].description
            imageArray[index].image = database.phases[index].imageSaved
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
