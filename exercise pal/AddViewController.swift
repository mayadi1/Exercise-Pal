//
//  AddViewController.swift
//  exercise pal
//
//  Created by admin on 11/20/16.
//  Copyright © 2016 Melissa Perenson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var rep: UITextField!
    @IBOutlet weak var hold: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var tag: UITextField!
    @IBOutlet weak var collections: UITextField!
    @IBOutlet weak var reference: UITextField!
    let imagePicker = UIImagePickerController()
    var selectedPhoto: UIImage!
    var fileUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    
        
        let pushedTap = UITapGestureRecognizer(target: self, action: Selector("selectPhoto"))
        pushedTap.numberOfTapsRequired = 1
        firstImage.addGestureRecognizer(pushedTap)
        
        let pushedTap2 = UITapGestureRecognizer(target: self, action: Selector("selectPhoto"))
        pushedTap2.numberOfTapsRequired = 1
        
//        //raise the view when view.edit is true
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
//                
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow"), name: UIKeyboardWillShowNotification, object: nil)
//         NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide"), name: UIKeyboardWillShowNotification, object: nil)
        //
    }

    //Calls this function when the tap is recognized.
     func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func selectPhoto() {
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        
        let photoOptionAlertController = UIAlertController(title: "SourceType?", message: nil, preferredStyle: .Alert)
        
        let cameraAction = UIAlertAction(title: "Take a Camera Shot", style: .Default, handler: { (UIAlertAction) in
            
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
            
        })
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Photo Library", style: .Default, handler: { (UIAlertAction) in
            
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) in
            
            // ..
        }
        
        photoOptionAlertController.addAction(cameraAction)
        photoOptionAlertController.addAction(photoLibraryAction)
        photoOptionAlertController.addAction(cancelAction)
        
        self.presentViewController(photoOptionAlertController, animated: true, completion: nil)
    }
    
    var storageRef: FIRStorageReference{
        return FIRStorage.storage().reference()
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        self.firstImage.image = selectedPhoto
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func saveButtonPressed(sender: AnyObject) {
        
         let ref = FIRDatabase.database().reference()
        
        let name = self.name.text!
        let rep = self.rep.text!
        let image = self.firstImage.image!
        
        if self.firstImage.image != nil{
            var data = NSData()
            data = UIImageJPEGRepresentation(firstImage.image!, 0.1)!
            
            let currentDate = NSDate()
            
            
            print("tjhis si the time")
            print(currentDate.toLongTimeString())
            
            let filePath = "postImage/\(currentDate.toLongTimeString())"
            let metadata =  FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            self.storageRef.child(filePath).putData(data, metadata: metadata, completion: { (metadata, error) in
                if let error = error{
                    print("\(error.description)")
                    return
                }
                self.fileUrl = metadata?.downloadURLs![0].absoluteString
                
                
                let myInfo = [name, rep, self.fileUrl]
                ref.childByAutoId().setValue(myInfo)
            })
        }
    }

}
extension NSDate
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toLongTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .FullStyle
        let timeString = formatter.stringFromDate(self)
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        
        
        //Return Long Time String
        
        return "\(day)" + ", " + timeString
    }

}

