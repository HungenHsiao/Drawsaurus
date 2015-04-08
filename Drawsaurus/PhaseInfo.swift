//
//  File.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-01.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

struct PhaseInfo {
 //   var roundNumber: Int
    var description: String = "Placeholder text"
    var imageSaved: UIImage = UIImage(named: "placeholder.pdf")!
    
    init(description _description: String, imageSaved _imageSaved: UIImage) {
   //     roundNumber = _roundNumber
        description = _description
        imageSaved = _imageSaved
    }
}
