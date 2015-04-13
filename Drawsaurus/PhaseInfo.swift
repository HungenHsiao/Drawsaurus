//
//  File.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-01.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit


class Phase {

}

class SentencePhase: Phase {
    var sentence: String = "Placeholder text"
    
    init(sentence _sentence: String) {
        sentence = _sentence
    }
}


class DrawingPhase: Phase {
    var drawing: UIImage = UIImage(named: "placeholder.pdf")!
    
    init(drawing _drawing: UIImage) {
        drawing = _drawing
    }
}

