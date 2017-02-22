//
//  MultiLanguageSupport.swift
//  Pods
//
//  Created by PeaceKim on 2017/01/05.
//  Copyright © 2017年 peacekim. All rights reserved.
//

import Foundation

public enum Country {
    case en
    case ko
    case jp
}

enum Month :Int {
    case jan = 1
    case feb
    case mar
    case apr
    case may
    case jun
    case jul
    case aug
    case sep
    case oct
    case nov
    case dec
    
    func toString()->String {
        switch language {
        case .en:
            return getEnglishString()
        case .ko:
            return getKoreanString()
        case .jp:
            return getJapaneseString()
        }
    }
    
    func getEnglishString()->String{
        switch self {
        case .jan: return "Jan"
        case .feb: return "Feb"
        case .mar: return "Mar"
        case .apr: return "Apr"
        case .may: return "May"
        case .jun: return "Jun"
        case .jul: return "Jul"
        case .aug: return "Aug"
        case .sep: return "Sep"
        case .oct: return "Oct"
        case .nov: return "Nov"
        case .dec: return "Dec"
        }
    }
    func getKoreanString()->String {
        switch self {
        case .jan: return "1월"
        case .feb: return "2월"
        case .mar: return "3월"
        case .apr: return "4월"
        case .may: return "5월"
        case .jun: return "6월"
        case .jul: return "7월"
        case .aug: return "8월"
        case .sep: return "9월"
        case .oct: return "10월"
        case .nov: return "11월"
        case .dec: return "12월"
        }
    }
    func getJapaneseString()->String {
        switch self {
        case .jan: return "1月"
        case .feb: return "2月"
        case .mar: return "3月"
        case .apr: return "4月"
        case .may: return "5月"
        case .jun: return "6月"
        case .jul: return "7月"
        case .aug: return "8月"
        case .sep: return "9月"
        case .oct: return "10月"
        case .nov: return "11月"
        case .dec: return "12月"
        }
    }
}

public enum Week :Int {
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 0
    case sun = 1

    static let allValues = [sat, sun, mon, tue, wed, thu, fri]
    
    func toString()->String {
        switch language {
        case .en:
            return getEnglishString()
        case .ko:
            return getKoreanString()
        case .jp:
            return getJapaneseString()
        }
    }
    
    func getEnglishString()->String{
        switch self {
        case .mon: return "Mon"
        case .tue: return "Tue"
        case .wed: return "Wed"
        case .thu: return "Thu"
        case .fri: return "Fri"
        case .sat: return "Sat"
        case .sun: return "Sun"
        }
    }
    func getKoreanString()->String {
        switch self {
        case .mon: return "월"
        case .tue: return "화"
        case .wed: return "수"
        case .thu: return "목"
        case .fri: return "금"
        case .sat: return "토"
        case .sun: return "일"
        }
    }
    func getJapaneseString()->String {
        switch self {
        case .mon: return "月"
        case .tue: return "火"
        case .wed: return "水"
        case .thu: return "木"
        case .fri: return "金"
        case .sat: return "土"
        case .sun: return "日"
        }
    }
}

var language:Country = .jp

class Word {
    static var start:String {
        get {
            switch language {
            case .en: return "Start"
            case .ko: return "시작"
            case .jp: return "開始"
            }
        }
        set {}
    }
    static var finish:String {
        get {
            switch language {
            case .en: return "Finish"
            case .ko: return "종료"
            case .jp: return "終了"
            }
        }
        set {}
    }
    
    static var nextWeek:String {
        get {
            switch language {
            case .en: return "Next Week"
            case .ko: return "다음주"
            case .jp: return "来週"
            }
        }
        set {}
    }
    
    static var lastWeek:String {
        get {
            switch language {
            case .en: return "Last Week"
            case .ko: return "이전주"
            case .jp: return "先週"
            }
        }
        set {}
    }
    
    
    static var confirm:String {
        get {
            switch language {
            case .en: return "Confirm"
            case .ko: return "확인"
            case .jp: return "決定"
            }
        }
        set {}
    }
    
    static var ok:String {
        get {
            switch language {
            case .en: return "OK"
            case .ko: return "OK"
            case .jp: return "OK"
            }
        }
        set{}
    }
    
    static var cancel:String {
        get {
            switch language {
            case .en: return "Cancel"
            case .ko: return "취소"
            case .jp: return "キャンセル"
            }
        }
        set{}
    }
    
    static func getMonth(index:Int)->String{
        switch language {
        case .en : return "en_US"
        case .ko : return "ko_KR"
        case .jp : return "ja_JP"
        }
    }
    
    static func getLocale(country:Country)->String{
        switch country {
        case .en : return "en_US"
        case .ko : return "ko_KR"
        case .jp : return "ja_JP"
        }
    }
    
    
    static func getDateFormat()->String{
        switch language {
        case .en : return "MM dd, E"
        case .ko : return "MM월 dd일 E"
        case .jp : return "MM月 dd日 E"
        }
    }
    
    static func getTimeFormat(timeFrom:(hour:Int,min:Int), timeTo:(hour:Int,min:Int))->String{
        
        switch language {
        case .en : return String(format:"%02d:%02d ~ %02d:%02d"    ,timeFrom.hour,timeFrom.min,timeTo.hour,timeTo.min)
        case .ko : return String(format:"%d시 %02d분부터 %d시 %02d분"    ,timeFrom.hour,timeFrom.min,timeTo.hour,timeTo.min)
        case .jp : return String(format:"%d時 %02d分から %d時 %02d分"    ,timeFrom.hour,timeFrom.min,timeTo.hour,timeTo.min)
        }
    }
}
