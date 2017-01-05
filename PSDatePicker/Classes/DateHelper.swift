//
//  DateHelper.swift
//  Pods
//
//  Created by PeaceKim on 2017/01/05.
//  Copyright © 2017年 peacekim. All rights reserved.
//

import UIKit

class DateHelper {
    static var dateLocale:Country = .jp
    
    static func dateFormatChanger(datetime:String, fromDateType:String, toDateType:String) -> String {
        var formatter   = DateHelper.getDefaultDateFormat(fromDateType)
        if let date = formatter.date(from: datetime) {
            formatter   = DateHelper.getDefaultDateFormat(toDateType)
            return formatter.string(from: date)
        }
        return datetime
    }
    
    static func getDefaultDateFormat(_ format:String)->DateFormatter{
        let formatter        = DateFormatter()
        
        // 端末の設定による出力形式の差を解消
        formatter.calendar   = Calendar.init(identifier: Calendar.Identifier.gregorian)
        formatter.locale     = Locale(identifier: Word.getLocale(country: dateLocale))
        formatter.timeZone   = TimeZone.current
        formatter.dateFormat = format
        
        return formatter
    }
    
    /// 日付型を文字列に変換する
    ///
    /// - Parameters:
    ///   - date: デート
    ///   - toFormat: フォーマット
    /// - Returns: String
    static func date2String(date:Date!, toFormat:String!) -> String{
        let formatter   = DateHelper.getDefaultDateFormat(toFormat)
        return formatter.string(from: date)
    }
    
    /// 文字列を日付型に変換する
    ///
    /// - Parameter datetime: 文字列
    /// - Returns: デート
    static func string2Date(string datetime:String) -> Date {
        return DateHelper.string2Date(dateStr:datetime,format:"yyyy-MM-dd")
    }
    
    
    /// 文字列をフォーマットに合わせてデート形式に変換する
    ///
    /// - Parameters:
    ///   - dateStr: デート文字列
    ///   - format: フォーマット
    /// - Returns: デート
    static func string2Date(dateStr:String, format:String) -> Date {
        return DateHelper.getDefaultDateFormat(format).date(from: dateStr)!
    }
    
    /// 現在時間を文字列で返却する
    ///
    /// - Parameter format: フォーマット
    /// - Returns: 現在時刻
    static func getNowStr(format:String)->String{
        return DateHelper.date2String(date: Date(), toFormat: format)
    }
    
    static func getYear(date:Date)->Int{
        return Int(DateHelper.date2String(date: date, toFormat: "yyyy"))!
    }
    
    static func getMonth(date:Date)->Int{
        return Int(DateHelper.date2String(date: date, toFormat: "MM"))!
    }
    
    static func getDay(date:Date)->Int{
        return Int(DateHelper.date2String(date: date, toFormat: "dd"))!
    }
    
    static func getHour(date:Date)->Int{
        return Int(DateHelper.date2String(date: date, toFormat: "hh"))!
    }
    
    static func getMinute(date:Date)->Int{
        return Int(DateHelper.date2String(date: date, toFormat: "mm"))!
    }
    
    static func getDates(date:Date)->(Int,Int,Int){
        return (DateHelper.getYear(date: date),DateHelper.getMonth(date: date), DateHelper.getDay(date: date))
    }
    
    static func getTimes(date:Date)->(Int,Int){
        return (DateHelper.getHour(date: date),DateHelper.getMinute(date: date))
    }
    
    static func getWeekDay(date:Date)->Int{
        return DateHelper.getDefaultDateFormat("yyyyMMdd").calendar.component(.weekday, from: date) % 7
    }
    
    static func getWeekOfYear(date:Date)->Int{
        return DateHelper.getDefaultDateFormat("yyyyMMdd").calendar.component(.weekOfYear, from: date)
    }
    
    static func getAddingDays(date:Date, numOfDays:Int)->Date{
        return DateHelper.getDefaultDateFormat("yyyyMMdd").calendar.date(byAdding: .day, value: numOfDays, to: date)!
    }
    
    struct Formatter {
        static let timeStampFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyyMMdd-HHmmss-SSS"
            return formatter
        }()
    }
    open static var TimeStamp: String {
        return Formatter.timeStampFormat.string(from: Date())
    }
    
    
}
