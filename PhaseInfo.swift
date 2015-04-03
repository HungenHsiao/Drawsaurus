//
//  File.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-01.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class PhaseInfo {
    var roundNumber: Int
    var description: String
    var imageSaved: UIImage
    
    init(roundNumber _roundNumber: Int, description _description: String, imageSaved _imageSaved: UIImage) {
        roundNumber = _roundNumber
        description = _description
        imageSaved = _imageSaved
    }
}
