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

                
        var bndl:Bundle? = nil
        
        for bun in Bundle.allFrameworks {
            if (bun.builtInPlugInsPath?.contains("PSDatePicker"))!{
                print("2 is loaded? \(bun.isLoaded), builtin plug in path : \(bun.builtInPlugInsPath)")
                bndl = bun
                bun.load()
                
                break
            }

        }
        
        /*

        if let vc:PSDatePicker = PSDatePicker.getViewController() {
            self.present(vc, animated: true, completion: nil)
        } else {
            print("PSDatePicker.getViewController() has error")
        }
 
       
 
         if let cls:AnyClass = NSClassFromString("PSDatePicker") {
            let myBundle = Bundle.init(for: cls)
         } else {
            print("NSClassFromString(PSDatePicker) has error")
         }
         */
        let mainStoryboard: UIStoryboard = UIStoryboard(name:"PSDateSB", bundle: bndl )
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "PSDatePicker")
        self.present(vc, animated: true, completion: nil)

 
        
    }
    
  

}

