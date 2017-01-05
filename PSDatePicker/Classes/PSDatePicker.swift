//
//  PSDatePicker.swift
//  Pods
//
//  Created by PeaceKim on 2017/01/03.
//  Copyright © 2017年 peacekim. All rights reserved.
//
import UIKit

let STR_BUNDLE  = "bundle"
let MODULE_NAME = "PSDatePicker"
let SB_PSDATE   = "PSDateSB"

public class PSDatePicker:UIViewController {
   
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open static func getViewController() -> UIViewController {
        return self.getVc(SB_PSDATE, MODULE_NAME)
    }
    
}

extension PSDatePicker {
    static func getbundle()->Bundle {
        let podBundle = Bundle(for: PSDatePicker.self)
        let bundleURL = podBundle.url(forResource: MODULE_NAME, withExtension: STR_BUNDLE)
        return Bundle(url: bundleURL!)!
    }
    
    static func getVc(_ sbName:String, _ vcName:String)->UIViewController {
        let storyboard = UIStoryboard(name: sbName, bundle: getbundle())
        return storyboard.instantiateViewController(withIdentifier: vcName)
    }
}
