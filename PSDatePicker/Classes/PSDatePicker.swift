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

public protocol DatePickerDelegate : NSObjectProtocol {
    
    @available(iOS 2.0, *)
    func dismissed(fromDate:Date, toDate:Date)
}

public class PSDatePicker:UIViewController {
    /**
     *  Device size
     */
    let DEVICE_WIDTH    = UIScreen.main.bounds.size.width
    let DEVICE_HEIGHT   = UIScreen.main.bounds.size.height
    let colorDefaultTint    = 0x007AFF
    
    var selectableTimes:[String] = []

    let monthBlockSize = ((UIScreen.main.bounds.size.width - 60 - 20) / 7 )
    open static var timeInterval = 15
    open static var startTime:Date? = nil
    open static var finishTime:Date? = nil
    open static var startOfWeek:Week = .mon
    open static var isTimeAutoSelect = true
    open static var delegate:DatePickerDelegate? = nil
    
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
    
    @IBOutlet weak var lcBgDateSelectLeading: NSLayoutConstraint!
    
    var displayDate :Date = Date()
    var selectedDate:Date = Date()
    var selectedTimeStart   :(hour:Int,min:Int) = (0,0)
    var selectedTimeFinish  :(hour:Int,min:Int) = (0,0)
    
    var btnDates:[UIButton] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initDates()
    }
    
}

// view control
extension PSDatePicker {
    
    
    /// viewDidLoad時実行
    func initViews() {
        self.btnConfirm.layer.cornerRadius = 4
        self.btnCancel .layer.cornerRadius = 4
        self.bgSelected.layer.cornerRadius = monthBlockSize / 2
        
        self.pvStart .delegate = self
        self.pvFinish.delegate = self
        
        self.pvStart .dataSource = self
        self.pvFinish.dataSource = self
        
        self.btnDates.append(self.btnDay1)
        self.btnDates.append(self.btnDay2)
        self.btnDates.append(self.btnDay3)
        self.btnDates.append(self.btnDay4)
        self.btnDates.append(self.btnDay5)
        self.btnDates.append(self.btnDay6)
        self.btnDates.append(self.btnDay7)
        
        language = .jp
        
        self.setStartFinishTime()
    }
    
    /// viewDidLoad　→　initViews
    private func setStartFinishTime(){
        let ti = PSDatePicker.timeInterval
        
        if let start = PSDatePicker.startTime {
            let hour = DateHelper.getHour24(date: start)
            let min = DateHelper.getMinute(date: start)
            assert(hour >= 0 && hour <= 23, "PSDatePicker.startTime is invalid number. It should be between 0 and 23")
            assert(min  >= 0 && min  <= 59, "PSDatePicker.startTime is invalid number. It should be between 0 and 59")
        } else {
            PSDatePicker.startTime = DateHelper.string2Date(dateStr: "09:00", format: "HH:mm")
        }
        
        if let finish = PSDatePicker.finishTime {
            let hour = DateHelper.getHour24(date: finish)
            let min = DateHelper.getMinute(date: finish)
            assert(hour >= 0 && hour <= 24, "PSDatePicker.finishTime is invalid number. It should be between 0 and 24")
            assert(min  >= 0 && min  <= 60, "PSDatePicker.finishTime is invalid number. It should be between 0 and 60")
        } else {
            PSDatePicker.finishTime = DateHelper.string2Date(dateStr: "23:59", format: "HH:mm")
        }
        
        let startTime:(hour:Int,min:Int) = DateHelper.getTimes24(date: PSDatePicker.startTime!)
        let finishTime:(hour:Int,min:Int) = DateHelper.getTimes24(date: PSDatePicker.finishTime!)
        
        assert(finishTime.hour >= startTime.hour, "PSDatePicker.finishTime is invalid Hour. FinissTime should be earlier than startTime")
        
        let x = (60/ti)*(finishTime.hour - startTime.hour) + ((finishTime.min/ti)-(startTime.min/ti))
        
        self.selectableTimes.removeAll()
        
        for i in 0...x {
            let startTotalMin = (startTime.hour * 60) + startTime.min
            let totalMin = startTotalMin + (i * ti)
            self.selectableTimes.append(String(format:"%02d:%02d",(totalMin/60), (totalMin%60)))
        }
    }

    
    
    /// viewWillAppear時のみ実行
    func initDates() {
        self.btnLastWeek.setTitle(Word.lastWeek, for: .normal)
        self.btnNextWeek.setTitle(Word.nextWeek, for: .normal)
        
        let startIndex = PSDatePicker.startOfWeek.rawValue
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
        
        self.setTodayDate()
        self.setDates(standardDate:Date())
        
    }
    
    /// 本日以前の日は選択できないようにする
    private func disableSelectTheDayBeforeOfToday(index:Int, btnDate:(year:Int,month:Int,day:Int)){
        //本日以前の日は選択できないようにする
        let toDay:(year:Int,month:Int,day:Int) = DateHelper.getDates(date:Date())
        
        if btnDate.year < toDay.year {
            self.btnDates[index].isEnabled = false
            self.btnLastWeek.isEnabled = false
        } else if (btnDate.year == toDay.year && btnDate.month < toDay.month) {
            self.btnDates[index].isEnabled = false
            self.btnLastWeek.isEnabled = false
        } else if btnDate.year == toDay.year && btnDate.month == toDay.month && btnDate.day < toDay.day {
            self.btnDates[index].isEnabled = false
            self.btnLastWeek.isEnabled = false
        } else {
            self.btnDates[index].isEnabled = true
        }

    }

    
    /// 今日の日付をタイトルに設定する
    /// view will appear -> initDatas　でのみ呼び出す
    fileprivate func setTodayDate() {
        self.setMonth(standardDate: Date())
        
        let dateFrom = self.timeAdjustByTimeInterval(hour: DateHelper.getHour24(date: Date()), min: DateHelper.getMinute(date: Date()))
        let dateAddedTimeInterval = DateHelper.getAddingMins(date: Date(), numOfMins: PSDatePicker.timeInterval)
        let dateTo = self.timeAdjustByTimeInterval(hour: DateHelper.getHour24(date: dateAddedTimeInterval), min: DateHelper.getMinute(date: dateAddedTimeInterval))
        
        self.lbTitleDate.text = DateHelper.date2String(date: Date(), toFormat: Word.getDateFormat())
        self.lbTitleTime.text = DateHelper.date2String(date: Date(), toFormat: Word.getTimeFormat(timeFrom: dateFrom, timeTo: dateTo))
        self.displayDate = self.getStartWeekOfDate(standardDate:Date())
        
        self.setupSelectedTime()
    }
    
    fileprivate func setMonth(standardDate:Date){
        let month:Month = Month(rawValue: DateHelper.getMonth(date: standardDate))!
        self.btnMonth.setTitle("\(month.toString())", for: .normal)
    }
    
    /// initDates、goLastWeek、goNextWeek、goToday時実行
    /// 今日設定時、週が変わる時の日付BTNに数字を設定する
    ///
    /// - Parameter standardDate: 基準日
    fileprivate func setDates(standardDate:Date) {
        
        if DateHelper.getMonth(date: standardDate) != DateHelper.getMonth(date: self.displayDate) {
            self.setMonth(standardDate: standardDate)
        }
        
        //指定日の週の開始日を保存する
        self.displayDate = self.getStartWeekOfDate(standardDate:standardDate)
        
        //Btnたちの初期化
        for btn in self.btnDates {
            btn.setTitleColor(self.getHexColor(0x007AFF), for: .normal)
            btn.isSelected = false
        }
        self.bgSelected.isHidden = true
        self.btnLastWeek.isEnabled = true
        
        //BTNに数字設定
        for i in 0...6 {
            
            //BTNの日付（Date形式）
            let btnDate = DateHelper.getAddingDays(date: self.displayDate, numOfDays: i)
            
            //BTNの日付（year, month, day形式）
            let btnDateYearMonthDay:(year:Int,month:Int,day:Int) = DateHelper.getDates(date:btnDate)
            
            //日の数字を設定
            self.btnDates[i].setTitle(self.getDateOfWeek(week: i , standardDate: standardDate), for: .normal)
            
            //background selected感知・設定
            if DateHelper.getDates(date:self.selectedDate) == btnDateYearMonthDay {
                self.btnDates[i].setTitleColor(UIColor.white, for: .normal)
                self.bgSelected.isHidden = false
                self.lcBgDateSelectLeading.constant = self.monthBlockSize*CGFloat(self.btnDates[i].tag-1)
            }
            
            // 本日以前の日は選択できないようにする
            self.disableSelectTheDayBeforeOfToday(index:i, btnDate:btnDateYearMonthDay)
        }
        
    }
    
    
    /// 指定日付を設定する
    ///
    /// - Parameter index: 日付ボタンのインデクス
    fileprivate func selectDate(index:Int){
        self.selectedDate = DateHelper.getAddingDays(date: self.displayDate, numOfDays: (index-1))
        self.lbTitleDate.text = DateHelper.date2String(date: self.selectedDate, toFormat: Word.getDateFormat())
    }
    
}

/* Actions */
extension PSDatePicker {
    @IBAction func goCancel(_ btn: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func getDateFromSelectedDate()->(from:Date,to:Date){
        let dateStr = DateHelper.date2String(date: self.selectedDate, toFormat: "yyyy:MM:dd")
        
        var fromTime:String = "\(dateStr) \(self.selectableTimes[self.pvStart .selectedRow(inComponent: 0)])"
        var toTime  :String = "\(dateStr) \(self.selectableTimes[self.pvFinish.selectedRow(inComponent: 0)])"
        
        if self.isToday(self.selectedDate) {
            fromTime = "\(dateStr) \(self.selectableTimes[self.pvStart .selectedRow(inComponent: 0) + self.getNowIndex()] )"
            toTime   = "\(dateStr) \(self.selectableTimes[self.pvFinish.selectedRow(inComponent: 0) + self.getNowIndex()] )"
        }
        
        let fromDateTime = DateHelper.string2Date(dateStr: fromTime , format: "yyyy:MM:dd HH:mm")
        let toDateTime   = DateHelper.string2Date(dateStr: toTime   , format: "yyyy:MM:dd HH:mm")
        
        return (from:fromDateTime,to:toDateTime)
    }

    
    @IBAction func goConfirm(_ btn: UIButton) {
        dismiss(animated: true) {
            PSDatePicker.delegate?.dismissed(fromDate:self.getDateFromSelectedDate().from, toDate: self.getDateFromSelectedDate().to)
        }
    }
    
    
    @IBAction func goDates(_ btn: UIButton) {
        
        // 指定日付を設定する
        self.selectDate(index: btn.tag)
        
        //Btnsの初期化
        for btn in self.btnDates {
            btn.setTitleColor(self.getHexColor(0x007AFF), for: .normal)
            btn.isSelected = false
        }
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                //bgSelectアンカーからの距離を再調節する
                self.lcBgDateSelectLeading.constant = self.monthBlockSize*CGFloat(btn.tag-1)
                //bgSelectの位置を設定する
                self.bgSelected.frame = CGRect(x: btn.frame.origin.x,
                                               y: self.bgSelected.frame.origin.y,
                                               width: btn.frame.size.width,
                                               height: self.bgSelected.frame.size.height)
                
        }, completion: { bool in
            // ボタンテキスト色変更
            btn.setTitleColor(UIColor.white, for: .normal)
            // タイトル変更
            self.lbTitleDate.text = DateHelper.date2String(date: self.selectedDate, toFormat: "MM月 dd日 EE")
            // bgSelectedが隠されていたら、表示する
            self.bgSelected.isHidden = false
            //日付に合わせて時間リストを再読みだす
            self.pvStart.reloadAllComponents()
            self.pvFinish.reloadAllComponents()
            //時間リストにピックアップされている時間を調節
            self.setupSelectedTime()
        })

    }
    
    
    /// １週前に戻る
    ///
    /// - Parameter btn: 押されたボタン
    @IBAction func goLastWeek(_ btn: UIButton) {
        self.setDates(standardDate: DateHelper.getAddingDays(date: self.displayDate, numOfDays: -7))
    }
    
    
    /// １週後を表示す
    ///
    /// - Parameter btn: 押されたボタン
    @IBAction func goNextWeek(_ btn: UIButton) {
        self.setDates(standardDate: DateHelper.getAddingDays(date: self.displayDate, numOfDays: 7))
    }
    
    
    /// 本日に戻る
    ///
    /// - Parameter btn: 押されたボタン
    @IBAction func goToday(_ btn: UIButton) {
        self.setDates(standardDate:Date())
    }
    
}

/* logic */
extension PSDatePicker {
    
    /// 基準日からの日付を求める
    ///
    /// - Parameters:
    ///   - week: 週の補正値
    ///   - standardDate: 基準日
    /// - Returns: 基準日に対しての週の日付
    fileprivate func getDateOfWeek(week:Int, standardDate:Date)->String{

        let date = DateHelper.getAddingDays(date: self.displayDate, numOfDays: week)
        
        if DateHelper.getMonth(date: date) != DateHelper.getMonth(date: standardDate) {
            return String(format:"%d/%d",DateHelper.getMonth(date: date),DateHelper.getDay(date: date))
        }
        
        return String(format:"%02d",DateHelper.getDay(date: date))
    }

    
    /// 基準日からその週の始まりの週を求める
    ///
    /// - Parameter standardDate: 基準日
    /// - Returns: その週の始まり日
    fileprivate func getStartWeekOfDate(standardDate:Date) -> Date {
        var dayValue = 0
        
        if DateHelper.getWeekDay(date: standardDate) >= PSDatePicker.startOfWeek.rawValue {
            dayValue = -(DateHelper.getWeekDay(date: standardDate) - PSDatePicker.startOfWeek.rawValue )
        } else {
            dayValue = -(DateHelper.getWeekDay(date: standardDate) - PSDatePicker.startOfWeek.rawValue ) - 7
        }
        
        return DateHelper.getAddingDays(date: standardDate, numOfDays: dayValue)
    }
    
    fileprivate func setupSelectedTime(){
        if !PSDatePicker.isTimeAutoSelect {
            PSDatePicker.isTimeAutoSelect = true
        } else if self.isToday(self.selectedDate) {
            self.pvStart .selectRow(0, inComponent: 0, animated: false)
            self.pvFinish.selectRow(4, inComponent: 0, animated: false)
        } else if self.getNowIndex()+4 <= self.selectableTimes.count {
            self.pvStart .selectRow(self.getNowIndex()  , inComponent: 0, animated: false)
            self.pvFinish.selectRow(self.getNowIndex()+4, inComponent: 0, animated: false)
        }
    }
    
    fileprivate func timeSelected(){
        var startRow    = self.pvStart.selectedRow(inComponent: 0)
        var finishRow   = self.pvFinish.selectedRow(inComponent: 0)
        
        if self.isToday(self.selectedDate) {
            startRow    += self.getNowIndex()
            finishRow   += self.getNowIndex()
        }
        
        let startTime   = DateHelper.string2Date(dateStr: self.selectableTimes[startRow], format: "HH:mm")
        let finishTime  = DateHelper.string2Date(dateStr: self.selectableTimes[finishRow], format: "HH:mm")
        
        let startTime24  = DateHelper.getTimes24(date: startTime)
        let finishTime24 = DateHelper.getTimes24(date: finishTime)
        
        self.lbTitleTime.text = DateHelper.date2String(date: Date(), toFormat: Word.getTimeFormat(timeFrom: startTime24, timeTo: finishTime24))
        
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
    
    fileprivate func getHexColor(_ hexColor:Int)->UIColor {
        let red     = (hexColor >> 16) & 0xff
        let green   = (hexColor >> 8) & 0xff
        let blue    = hexColor & 0xff
        
        assert(red   >= 0 && red   <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue  >= 0 && blue  <= 255, "Invalid blue component")
        
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    open func timeAdjustByTimeInterval(hour:Int,min:Int)->(Int,Int){
        if min % PSDatePicker.timeInterval == 0 {
            return (hour,min)
        } else if min > (60 - PSDatePicker.timeInterval) {
            return (hour+1,0)
        } else {
            return (hour,min + PSDatePicker.timeInterval - (min % PSDatePicker.timeInterval))
        }
    }
    
    
    /// タイムリストから現在と一番近いIndexwo返す
    ///
    /// - Returns: TimePickerのIndex
    fileprivate func getNowIndex()->Int{
        let hour    = DateHelper.getHour24(date: Date())
        let min     = DateHelper.getMinute(date: Date())
        
        //開始時間がNilではない場合
        if let startT = PSDatePicker.startTime {
            //選択時間が開始時間より先であれば、一番最初のObjを選択
            if hour < DateHelper.getHour24(date: startT) {
                return 0
            } else {
                return ((hour*(60/PSDatePicker.timeInterval)) + (min/PSDatePicker.timeInterval) + 1) - (DateHelper.getHour24(date: startT)*(60/PSDatePicker.timeInterval))
            }
        } else {
            return 0
        }
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

/* UIPickerViewDelegate */
extension PSDatePicker:UIPickerViewDelegate, UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numOfTimeContents()
    }
    
    public func numberOfComponents(in pv:UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.getStartTime(row, pickerView)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.pvStart {
            //終了時間の調節
            if row + 4 >= self.selectableTimes.count{
                self.pvFinish.selectRow(self.selectableTimes.count, inComponent: 0, animated: true)
            } else {
                self.pvFinish.selectRow(row+4, inComponent: 0, animated: true)
            }
        }
        
        self.timeSelected()
        
    }
    
    
    /// 時間リストの選択肢を日付が本日の場合、現在以後の時間数だけ表示す
    ///
    /// - Returns: 現在以後の時間数
    private func numOfTimeContents()->Int{
        if self.isToday(self.selectedDate) {
            return self.selectableTimes.count - self.getNowIndex()
        } else {
            return self.selectableTimes.count
        }
    }
    
    
    /// 基準日が今日かどうかを判断す
    ///
    /// - Returns: 基準日が本日かどうか
    fileprivate func isToday(_ standardDate:Date)->Bool{
        return (DateHelper.getYear(date:standardDate)   == DateHelper.getYear(date:Date()))
            && (DateHelper.getMonth(date:standardDate)  == DateHelper.getMonth(date:Date()))
            && (DateHelper.getDay(date:standardDate)    == DateHelper.getDay(date:Date()))
    }
    
    private func getStartTime(_ row:Int, _ pickerView: UIPickerView)->String{
        if self.isToday(self.selectedDate) {
            return self.selectableTimes[row + self.getNowIndex()]
        } else {
            return self.selectableTimes[row]
        }
    }
    

}
