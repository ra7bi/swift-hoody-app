//
//  AddPostVC.swift
//  MyHood
//
//  Created by fahad alrahbi on 3/6/16.
//  Copyright © 2016 FahadCoder. All rights reserved.
//

import UIKit

// When you use UIImagepucker delegate , you must use navigation delegate

class AddPostVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var descField: UITextField!
    
    // for picker 
    
    var imagePicker:UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This is for @IBoutlet pistimg
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
        
        
        imagePicker = UIImagePickerController()
        
        // Self delegate
        imagePicker.delegate = self
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func addPicBtnPressed(sender: UIButton!) {
        
        sender.setTitle("", forState: .Normal)
        
        // call image delegate 
        presentViewController(imagePicker, animated: true, completion: nil)
    }
   

    @IBAction func makePostBtnPressed(sender: UIButton!) {
        
        // check if all are okay validation
        
        if let title = titleField.text , let desc = descField.text, let img = postImg.image{
            
            let imagePath = DataService.instance.saveImageAndCreatePath(img)
            
            var post = Post(imagePath: imagePath, title: title, postDesc: desc)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    
    @IBAction func cancelBtnPressed(sender: UIButton!) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Delegate for image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
       
        // Image from function parameter
        postImg.image = image
    }
}
