//
//  ViewController.swift
//  HaticeWebViewPractice
//
//  Created by Hatice Gursoy on 7/10/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL( string: "http://www.bloomberg.com")!
        
        webview.loadRequest(NSURLRequest(URL: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

