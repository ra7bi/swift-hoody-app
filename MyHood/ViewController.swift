//
//  ViewController.swift
//  MyHood
//
//  Created by fahad alrahbi on 3/5/16.
//  Copyright © 2016 FahadCoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        DataService.instance.loadPosts()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPost.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Get Post object from array // Single row mean one object
        let post = DataService.instance.loadedPost[indexPath.row]
        
        if let cell = tableview.dequeueReusableCellWithIdentifier("PostCell") as? PostsCell {
            
            // Update the data
            cell.configureCell(post)
            return cell
            //cell.titleLbl.text = "Test"
        }else{
            
            // it will never run but in case
            let cell = PostsCell()
            cell.configureCell(post)
            return cell
        }
    }
    
    
 
    
    
    
    // Check cell hegith in storyborad 
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 92.0
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {

    }
    
    func onPostsLoaded(notif: AnyObject){
        
        print("SomeOneCall me")
        tableview.reloadData()
    }
}

