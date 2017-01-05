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

private enum monthEn {
   
}

var language:Country = .jp

class Word {
    
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
    
    static var priorWeek:String {
        get {
            switch language {
            case .en: return "Prior Week"
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
            case .ko: return "決定"
            case .jp: return "확인"
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
}
