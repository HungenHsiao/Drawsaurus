//
//  FriendsViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-04-20.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var friendsTableView: UITableView!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FriendVCtoMainVC" {
            let mainVC = segue.destinationViewController as? MainMenuViewController
            mainVC?.selectedFriend = selectedFriend
        }
    }
    
    var friendDB = ["Friend0", "Friend1", "Friend2", "Friend3", "Friend4", "Friend5", "Friend6", "Friend7", "Friend8", "Friend9"]
    var friendList: [[String:AnyObject]]?
    
    var selectedFriend: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendDB = []
        for var i = 0; i < friendList?.count; i++ {
            let currentFriend = friendList![i]
            friendDB.append((currentFriend["name"] as? String)!)
        }
        
        self.friendsTableView.contentInset = UIEdgeInsetsMake(10, -7.5, 0, 0)
        self.friendsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendDB.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let friendCell: FriendCell = self.friendsTableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendCell
        friendCell.friendLabel.text = friendDB[indexPath.row]
        cell = friendCell
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let rowHeight: CGFloat = 46
        return rowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected friend #\(indexPath.row)!")
        selectedFriend = friendDB[indexPath.row]
    }
}

class FriendCell: UITableViewCell {
    @IBOutlet weak var friendLabel: UILabel!
}

class Friend {
    var _name: String?
    var _id: String?
    
    init(name: String, id: String) {
        _name = name
        _id = id
    }
}