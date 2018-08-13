//
//  Extension+Data.swift
//  KCSimpleKit
//
//  Created by Tran Vinh Kinh on 8/13/18.
//  Copyright © 2018 Tran Vinh Kinh. All rights reserved.
//

import Foundation

public extension Data {
    // Convert data to attribute string
    public var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    // Convert data to string only
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
