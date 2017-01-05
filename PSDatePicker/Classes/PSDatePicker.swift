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
   
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var bgAll: UIView!
    @IBOutlet weak var bgTranslucency: UIView!
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
   
   
    
}

// view control
extension PSDatePicker {
    func initViews() {
        self.btnConfirm.layer.cornerRadius = 4
        self.btnCancel .layer.cornerRadius = 4
        
        
    }
}

// Actions
extension PSDatePicker {
    @IBAction func goCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func goConfirm(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// Util
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

/* Open */
extension PSDatePicker {
    open static func getViewController() -> UIViewController {
        return self.getVc(SB_PSDATE, MODULE_NAME)
    }
    
    open static func showDatePicker(_ target:UIViewController){
        let vc = PSDatePicker.getViewController()
        target.present(vc, animated: true, completion: nil)
    }
}
