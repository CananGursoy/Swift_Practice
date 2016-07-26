//
//  ViewController.swift
//  Cat Years
//
//  Created by Hatice Gursoy on 6/27/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class ViewController: UIViewController {
     var audioPlayer = AVAudioPlayer()

    @IBOutlet weak var catAge: UITextField!
    @IBOutlet weak var displayCatAge: UILabel!
    @IBOutlet weak var catPicture: UIImageView!
    
    @IBAction func getCatAge(sender: AnyObject) {
    
    if (!catAge.text!.isEmpty){
        
        var catAgeNumber = Int(catAge.text!)!
        
        catAgeNumber = catAgeNumber * 7
        displayCatAge.text = "Your cat is \(catAgeNumber) in cat years"
        
        // Set the sound file name & extension
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cat", ofType: "mp3")!)
        
        do {
            // Preperation
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        
        // Play the sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch _{
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        catPicture.image=UIImage(named: "cat.png")
            
        //Hide the keyboard after user keys in age
        catAge.resignFirstResponder()
        
        
        }
        else {
        
        catPicture.image=UIImage(named:"")
        displayCatAge.text = nil
        }
      
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         catAge.becomeFirstResponder()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

