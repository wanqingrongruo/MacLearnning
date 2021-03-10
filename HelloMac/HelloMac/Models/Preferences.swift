//
//  Preferences.swift
//  Created on 2021/3/10
//  Description <#文件描述#>

import Foundation

struct Prefrences {
    private let selectedTimeKey = "Prefrences.selectedTime"
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: selectedTimeKey)
            return savedTime > 0 ? savedTime : defaultTimeForEgg
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: selectedTimeKey)
        }
    }
}
