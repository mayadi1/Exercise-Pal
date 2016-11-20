//
//  AddViewController.swift
//  exercise pal
//
//  Created by admin on 11/20/16.
//  Copyright © 2016 Melissa Perenson. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var rep: UITextField!
    @IBOutlet weak var hold: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var tag: UITextField!
    @IBOutlet weak var collections: UITextField!
    @IBOutlet weak var reference: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
