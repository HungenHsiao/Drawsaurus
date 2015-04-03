//
//  Database.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-02.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import Foundation
import UIKit

class Database {
    var phases: [PhaseInfo] = []
   // var phase: PhaseInfo!
    
    init() {

    }
    
    func addPhase(#newPhase: PhaseInfo) {
        phases.append(newPhase)
    }
    
    func listPhases() {
        for phase in phases {
            println(phase.roundNumber)
            println(phase.description)
            println(phase.imageSaved)
        }
    }
}