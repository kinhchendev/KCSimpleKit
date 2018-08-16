//
//  Extension.swift
//  KCSimpleKit
//
//  Created by Tran Vinh Kinh on 8/13/18.
//  Copyright © 2018 Tran Vinh Kinh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Path
public extension String {
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    public var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    public var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    public func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    public func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
}

// MARK: - Bounding
public extension String {
    // Get bounding rect
    public func boundingRect(WithSize size:CGSize?, option:NSStringDrawingOptions?, attributes:NSDictionary?) -> CGSize? {
        let nsStr = NSString(string: self)
        let returnSize = nsStr.boundingRect(with: size!, options: option!, attributes: attributes as? [NSAttributedStringKey : Any], context: nil).size
        return returnSize
    }
}

// MARK: - Attribute
public extension String {
    // Create attribute string with replacing attribute for string
    public func stringFromReplaceAttribute(attribute : [NSAttributedStringKey : Any],
                                    forText text : String) -> NSAttributedString? {
        let range = (self as NSString).range(of: text)
        if range.location != NSNotFound {
            let attrString = NSMutableAttributedString(string: self)
            attrString.addAttributes(attribute, range: range)
            
            return attrString
        }
        
        return nil
    }
}

// MARK: - Encode Decode
public extension String {
    // URL encode string
    public func urlEncodedString() -> String {
        let allowCharacterSet = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]\" ").inverted
        let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowCharacterSet) ?? self
        return encodedString
    }
    
    // Base64 encode
    public func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    // Base64 decode
    public func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // Convert html string to attribute string
    public var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    // Convert html string to string only
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

// MARK: Matching
public extension String {
    // Check regex matching
    func isMatch(regex: String, options: NSRegularExpression.Options) -> Bool
    {
        do {
            let exp = try NSRegularExpression(pattern: regex, options: options)
            let matchCount = exp.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.count))
            return matchCount > 0
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    // Get matches
    func getMatches(regex: String, options: NSRegularExpression.Options) -> [NSTextCheckingResult]
    {
        do {
            let exp = try NSRegularExpression(pattern: regex, options: options)
            let matches = exp.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            return matches as [NSTextCheckingResult]
        } catch let error {
            print(error.localizedDescription)
        }
        return []
    }
}
    
// MARK: Other utils
public extension String {
    // Extract list of url in string
    public func extractURLs() -> [URL] {
        var urls : [URL] = []
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            detector.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count), using: { (result, _, _) in
                if let match = result, let url = match.url {
                    urls.append(url)
                }
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return urls
    }
    
    // Quick check valid email
    public func isValidEmail() -> Bool {
        if self=="" {
            return false
        }
        
        //        let stricterFilter = true // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
        let stricterFilterString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{1,20}"
        //        let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = stricterFilterString
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailTest.evaluate(with: self)
        
        return isValid
    }
}
