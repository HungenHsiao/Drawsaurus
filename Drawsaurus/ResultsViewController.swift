//
//  ResultsViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-07.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var descArray: [UILabel] = []
    var imageArray: [UIImageView] = []
    var database: [Phase]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(10, -7.5, 0, 0)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: UITableViewCell?
        if indexPath.row % 2 == 0 {
            let sentenceCell: SentenceCell = self.tableView.dequeueReusableCellWithIdentifier("SentenceCell") as! SentenceCell

            let phase: SentencePhase = database[indexPath.row] as! SentencePhase
            sentenceCell.sentenceLabel.text = phase.sentence
            cell = sentenceCell
        } else {
            let drawingCell: DrawingCell = self.tableView.dequeueReusableCellWithIdentifier("DrawingCell") as! DrawingCell
            
            let phase: DrawingPhase = database[indexPath.row] as! DrawingPhase
            drawingCell.drawingView.image = phase.drawing
            cell = drawingCell
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 50
        } else {
            return 370
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}

class SentenceCell: UITableViewCell {
    @IBOutlet weak var sentenceLabel: UILabel!
}

class DrawingCell: UITableViewCell {
    @IBOutlet weak var drawingView: UIImageView!
}