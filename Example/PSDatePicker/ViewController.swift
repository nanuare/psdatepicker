//
//  ViewController.swift
//  PSDatePicker
//
//  Created by PeaceKim on 01/04/2017.
//  Copyright (c) 2017 PeaceKim. All rights reserved.
//

import UIKit
import PSDatePicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goButton(_ sender: UIButton) {

        if let vc = PSDatePicker.getViewController() {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
  

}

