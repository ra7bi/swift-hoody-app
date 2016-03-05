//
//  DataService.swift
//  MyHood
//
//  Created by fahad alrahbi on 3/6/16.
//  Copyright © 2016 FahadCoder. All rights reserved.
//

import Foundation
import UIKit

// This class will never clean from memory ,
class DataService {
    
    // Only can create one instance
    static let instance = DataService()
    let KEY_POST = "posts"
    
    private var _loadedPosts = [Post]()
    
    var loadedPost:[Post]{
        
        return _loadedPosts
    }
    
    
    
    func savePost()
    {
        // Convert Data to byet
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
    
        // Save Data
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POST)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func loadPosts()
    {
        // if we got it back
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POST) as? NSData
        {
            // convert nsdata to array of [Post] object  => [] mean array 
            
            if let postArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post]
            {
                _loadedPosts = postArray
            }
            
            
         NSNotificationCenter.defaultCenter().postNotificationName("postsLoaded", object: nil)
        }
        
        
    }
    
    
    // Save Image to file and change the name .
    func saveImageAndCreatePath(image: UIImage) ->String
    {
        
        let imgData = UIImagePNGRepresentation(image)
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullpath = documentsPathFroFileName(imagePath)
        imgData?.writeToFile(fullpath, atomically: true)
        return imagePath
    }
    
    
    // Get image back from folder 
    func imageforPath(path:String) -> UIImage?
    {
        
        let fullpath = documentsPathFroFileName(path)
        let image = UIImage(named: fullpath)
        return image
        
    }
    
    
    func addPost(post:Post){
        
        
        _loadedPosts.append(post)
        savePost()
        loadPosts()
        
    }
    
    
    // Function to get Directoryes for Document folder where we store the image
    func documentsPathFroFileName(name:String)->String{
        
        // search for Document folder in the app dir
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        // Take the path as string
        let fullPath = path[0] as NSString
        // add the name to the end of the path
        return fullPath.stringByAppendingPathComponent(name)
        
    }
}