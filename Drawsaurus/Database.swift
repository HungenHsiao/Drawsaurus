//
//  Database.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-02.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import Foundation
import UIKit


func listPhases(phases: [Phase]) {
    for phase in phases {
        if let drawingPhase = phase as? DrawingPhase {
            println(drawingPhase.drawing)
        } else if let sentencePhase = phase as? SentencePhase {
            println(sentencePhase.sentence)
        }
    }
}