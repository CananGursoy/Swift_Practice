//
//  DetailsViewController.swift
//  Memorable Places
//
//  Created by Hatice Gursoy on 8/14/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITextFieldDelegate  {
    
    
    // selected instance 
    var memPlace = MemorablePlaceManager.sharedInstance.getMemorablePlaceAtIndex(activePlace)
    
    
    @IBOutlet var locationNameTextField: UITextField!
    @IBOutlet var userNoteTextField: UITextField!
    
    @IBOutlet var latitudeValue: UILabel!
    @IBOutlet var longitudeValue: UILabel!
   
    var canSave = false
    
    
    
    @IBAction func saveBtnTapped(_ sender: AnyObject) {
        
         //show error alert when user leaves location name empty
        if locationNameTextField.text! == "" {
            let alertController = UIAlertController(title: "ERROR", message: "Location name cannot be empty. \n Please enter the location name.", preferredStyle: .alert)
           //  alertController.setValue(NSAttributedString(string:"ERROR", attributes: [NSFontAttributeName: UIFont.systemFontSize(17), NSForegroundColorAttributeName: UIColor.redColor()]), forKey: "attributedTitle")
            
            
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            
        
        }
        
        
        if memPlace.locationName != locationNameTextField.text &&  locationNameTextField.text! != "" {
            memPlace.setLocationName(locationNameTextField.text!)
              canSave = true
        }
        if memPlace.userNote != userNoteTextField.text && userNoteTextField.text != "" {
            memPlace.setuserNote(userNoteTextField.text!)
            canSave = true
        }
        
        if (canSave){
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.locationNameTextField.delegate = self
        
    
         //userNoteTextField.isFirstResponder()

        
        //Round lan and lat so it will look good on the gui
        let roundLat = round(memPlace.latitude * 10000) / 10000
        let roundLon = round(memPlace.longitude * 10000) / 10000
        
    
        locationNameTextField.text =  memPlace.locationName
        latitudeValue.text = "\(roundLat)"
        longitudeValue.text = "\(roundLon)"
        
        if memPlace.userNote != nil{
            userNoteTextField.text = memPlace.userNote
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationNameTextField.isFirstResponder
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
