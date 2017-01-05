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

var language:Country = .jp

class Word {
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
    
    static func getLocale(country:Country)->String{
        switch country {
        case .en : return "en_US"
        case .ko : return "ko_KR"
        case .jp : return "ja_JP"
        }
    }
}
