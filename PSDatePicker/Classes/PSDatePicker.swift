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
    /**
     *  Device size
     */
    let DEVICE_WIDTH    = UIScreen.main.bounds.size.width
    let DEVICE_HEIGHT   = UIScreen.main.bounds.size.height
   
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var bgAll: UIView!
    @IBOutlet weak var bgTranslucency: UIView!

    @IBOutlet weak var bgTitle: UIView!
    @IBOutlet weak var bgDatePick: UIView!
    @IBOutlet weak var bgSeperator: UIView!
    @IBOutlet weak var bgTimePick: UIView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTitleDate: UILabel!
    @IBOutlet weak var lbTitleTime: UILabel!
    
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnLastWeek: UIButton!
    @IBOutlet weak var btnNextWeek: UIButton!
    
    @IBOutlet weak var lbWeek1: UILabel!
    @IBOutlet weak var lbWeek2: UILabel!
    @IBOutlet weak var lbWeek3: UILabel!
    @IBOutlet weak var lbWeek4: UILabel!
    @IBOutlet weak var lbWeek5: UILabel!
    @IBOutlet weak var lbWeek6: UILabel!
    @IBOutlet weak var lbWeek7: UILabel!
    
    @IBOutlet weak var btnDay1: UIButton!
    @IBOutlet weak var btnDay2: UIButton!
    @IBOutlet weak var btnDay3: UIButton!
    @IBOutlet weak var btnDay4: UIButton!
    @IBOutlet weak var btnDay5: UIButton!
    @IBOutlet weak var btnDay6: UIButton!
    @IBOutlet weak var btnDay7: UIButton!

    @IBOutlet weak var lbStart: UILabel!
    @IBOutlet weak var lbFinish: UILabel!
    
    @IBOutlet weak var pvStart: UIPickerView!
    @IBOutlet weak var pvFinish: UIPickerView!
    
    @IBOutlet weak var bgSelected: UIView!
    
    open var startOfWeek:Week = .mon
    var selectedDate:Date = Date()
    let monthBlockSize = ((UIScreen.main.bounds.size.width - 80) / 7 ) - 6
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initDates()
    }
    
    
    @IBAction func goDates(_ sender: UIButton) {
        print(sender.tag)
        
    }
    
   
    
}

// view control
extension PSDatePicker {
    func initViews() {
        self.btnConfirm.layer.cornerRadius = 4
        self.btnCancel .layer.cornerRadius = 4
        self.bgSelected.layer.cornerRadius = monthBlockSize / 2
        
        language = .ko
    }
    
    func initDates() {
        self.setTodayDate()
        
        self.btnLastWeek.setTitle(Word.lastWeek, for: .normal)
        self.btnNextWeek.setTitle(Word.nextWeek, for: .normal)
        
        let startIndex = startOfWeek.rawValue
        self.lbWeek1.text = Week.allValues[(startIndex  ) % 7].toString()
        self.lbWeek2.text = Week.allValues[(startIndex+1) % 7].toString()
        self.lbWeek3.text = Week.allValues[(startIndex+2) % 7].toString()
        self.lbWeek4.text = Week.allValues[(startIndex+3) % 7].toString()
        self.lbWeek5.text = Week.allValues[(startIndex+4) % 7].toString()
        self.lbWeek6.text = Week.allValues[(startIndex+5) % 7].toString()
        self.lbWeek7.text = Week.allValues[(startIndex+6) % 7].toString()
        
        self.lbStart .text = Word.start
        self.lbFinish.text = Word.finish
        
        self.btnConfirm.setTitle(Word.confirm, for: .normal)
        self.btnCancel .setTitle(Word.cancel , for: .normal)
    }
    
    func setTodayDate() {
        let month:Month = Month(rawValue: DateHelper.getMonth(date: Date()))!
        self.btnMonth.setTitle("\(month.toString())", for: .normal)
        
        self.lbTitleDate.text = DateHelper.date2String(date: Date(), toFormat: Word.getDateFormat())
        self.lbTitleTime.text = DateHelper.date2String(date: Date(), toFormat: Word.getTimeFormat())
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
