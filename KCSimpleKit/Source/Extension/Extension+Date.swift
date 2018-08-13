//
//  Extension+Date.swift
//  KCSimpleKit
//
//  Created by Tran Vinh Kinh on 8/13/18.
//  Copyright © 2018 Tran Vinh Kinh. All rights reserved.
//

import Foundation

public extension Date {
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    public func string(withDateFormat format : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
