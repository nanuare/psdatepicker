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

    @IBOutlet weak var lbTime: UILabel!
    
    var fDate:Date = Date()
    var tDate:Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        PSDatePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goButton(_ sender: UIButton) {
        PSDatePicker.showDatePicker(self)
    }
    @IBAction func goMon(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .mon
        PSDatePicker.selectedTimeStart = self.fDate
        PSDatePicker.selectedTimeFinished = self.tDate
        
        PSDatePicker.showDatePicker(self)
        
    }
    
    @IBAction func goTue(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .tue
        PSDatePicker.showDatePicker(self)
    }
    @IBAction func goSat(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .sat
        PSDatePicker.showDatePicker(self)
    }
    @IBAction func goSun(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .sun
        PSDatePicker.showDatePicker(self)
    }
    @IBAction func goFri(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .fri
        PSDatePicker.showDatePicker(self)
    }
    
    @IBAction func goWed(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .wed
        PSDatePicker.showDatePicker(self)
    }
    
}

extension ViewController:DatePickerDelegate{
    func dismissed(fromDate:Date, toDate:Date) {
        self.lbTime.text = "\(self.date2String(date: fromDate, toFormat: "yyyy/MM/dd HH:mm")) ~ \(self.date2String(date: toDate, toFormat: "HH:mm"))"
        self.fDate = fromDate
        self.tDate = toDate
        
    }
    
    func date2String(date:Date!, toFormat:String!) -> String{
        let formatter   = self.getDefaultDateFormat(toFormat)
        return formatter.string(from: date)
    }
    
    func getDefaultDateFormat(_ format:String)->DateFormatter{
        let formatter        = DateFormatter()
        
        // 端末の設定による出力形式の差を解消
        formatter.calendar   = Calendar.init(identifier: Calendar.Identifier.gregorian)
        formatter.locale     = Locale(identifier: "ja_JP")
        formatter.timeZone   = TimeZone.current
        formatter.dateFormat = format
        
        return formatter
    }
    
}
