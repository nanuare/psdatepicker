//
//  PSDatePicker.swift
//  Pods
//
//  Created by PeaceKim on 2017/01/03.
//  Copyright © 2017年 peacekim. All rights reserved.
//
import UIKit

public class PSDatePicker:UIViewController {
    var backView:UIView = UIView.init()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.isModalInPopover = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .currentContext
        self.view.backgroundColor   = UIColor.clear
        
        self.backView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        self.backView.backgroundColor = UIColor.orange
        
        self.view.addSubview(self.backView)
        self.view.isOpaque = false
      
        
    }
    
    open static func getViewController()->UIViewController? {
       
        let podBundle = Bundle(for: PSDatePicker.self)
        
        print("path :  \(podBundle.bundlePath)/PSDatePicker.bundle")
        for bn in Bundle.allFrameworks {
            print("bundle frame id   : \(bn.bundleIdentifier)")
            print("bundle frame path : \(bn.bundlePath)")
        }
        
        let bundleURL = podBundle.url(forResource: "PSDatePicker", withExtension: "bundle")
        
        let storyboard = UIStoryboard(name: "PSDateSB", bundle: Bundle(url: bundleURL!)!)
        let vc = storyboard.instantiateViewController(withIdentifier: "PSDatePicker")
        
        return vc
    }
    
}
