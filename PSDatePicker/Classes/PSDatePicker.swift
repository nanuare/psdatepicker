//
//  PSDatePicker.swift
//  Pods
//
//  Created by PeaceKim on 2017/01/03.
//  Copyright © 2017年 peacekim. All rights reserved.
//


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
    
    open static func getViewController()->PSDatePicker? {
       // let mainStoryboard: UIStoryboard = UIStoryboard(name:"PSDateSB", bundle: nil)
      //  return mainStoryboard.instantiateViewController(withIdentifier: "PSDatePicker") as! PSDatePicker
        
        
        if let cls:AnyClass = NSClassFromString("PSDatePicker") {
            let myBundle = Bundle.init(for: cls)
            let mainStoryboard: UIStoryboard = UIStoryboard(name:"PSDateSB", bundle: myBundle )
            return mainStoryboard.instantiateViewController(withIdentifier: "PSDatePicker") as! PSDatePicker
            
        } else {
            let podBundle = Bundle(for: PSDatePicker.self)
            let bundleURL = podBundle.url(forResource: "PSDatePicker", withExtension: "bundle")
          //  let bundle = Bundle(url: bundleURL!)!
            
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name:"PSDateSB", bundle: podBundle )
            return mainStoryboard.instantiateViewController(withIdentifier: "PSDatePicker") as! PSDatePicker
        }

        
        
       // return self.getVc("PSDateSB","PSDatePicker") as! PSDatePicker
    }
    
    
    func getVc(_ sbName:String,_ vcName:String) -> UIViewController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name:sbName, bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: vcName)
    }

    
}
