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
        PSDatePicker.showDatePicker(self)
    }
    @IBAction func goMon(_ sender: UIButton) {
        PSDatePicker.startOfWeek = .mon
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

