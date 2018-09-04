//
//  Macro.swift
//  KCSimpleKit
//
//  Created by Tran Vinh Kinh on 8/8/18.
//  Copyright © 2018 Tran Vinh Kinh. All rights reserved.
//

import Foundation
import UIKit

@objc public class Macro: NSObject {
// MARK: Timer
    public static func invalidateTimer(timer : inout Timer?) -> Void {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
// MARK: Color
    @objc public static func rgb(r : Int, g : Int, b : Int, alpha : CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    @objc public static func colorFromHex(hexValue hex : Int) -> UIColor {
        return UIColor(red: CGFloat((hex >> 16) & 0xFF) / 255.0,
                       green: CGFloat((hex >> 8) & 0xFF) / 255.0,
                       blue: CGFloat(hex & 0xFF) / 255.0,
                       alpha: 1.0)
    }
    
    @objc public static func colorFromHex(hexValue hex : Int, WithAlpha alpha : CGFloat) -> UIColor {
        return UIColor(red: CGFloat((hex >> 16) & 0xFF) / 255.0,
                       green: CGFloat((hex >> 8) & 0xFF) / 255.0,
                       blue: CGFloat(hex & 0xFF) / 255.0,
                       alpha: alpha)
    }
    
// MARK: Window
    @objc public static let mainWindow : UIWindow? = UIApplication.shared.windows.first
    
// MARK: Device
    @objc public static let deviceIsIphone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
    @objc public static let deviceIsIpad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
    
// MARK: Resolution
    @objc public static let isRetina = (UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) && UIScreen.main.scale == 2)
    
    public static func imageExtensionForRetina() -> String {
        if Macro.isRetina {
            return "@2x"
        }
        return ""
    }
    
    @objc public static let isIphone_4_protrait : Bool = Double(fabs(UIScreen.main.bounds.size.height - 480)) < Double.ulpOfOne
    @objc public static let isIphone_4_landscape : Bool = Double(fabs(UIScreen.main.bounds.size.width - 480)) < Double.ulpOfOne
    @objc public static let isIphone_5_protrait : Bool = Double(fabs(UIScreen.main.bounds.size.height - 568)) < Double.ulpOfOne
    @objc public static let isIphone_5_landscape : Bool = Double(fabs(UIScreen.main.bounds.size.width - 568)) < Double.ulpOfOne
    @objc public static let isIphone_6_protrait : Bool = Double(fabs(UIScreen.main.bounds.size.height - 667)) < Double.ulpOfOne
    @objc public static let isIphone_6_landscape : Bool = Double(fabs(UIScreen.main.bounds.size.width - 667)) < Double.ulpOfOne
    @objc public static let isIphone_6plus_protrait : Bool = Double(fabs(UIScreen.main.bounds.size.height - 736)) < Double.ulpOfOne
    @objc public static let isIphone_6plus_landscape : Bool = Double(fabs(UIScreen.main.bounds.size.width - 736)) < Double.ulpOfOne
    @objc public static let isIphone_X_protrait : Bool = Double(fabs(UIScreen.main.bounds.size.height - 812)) < Double.ulpOfOne
    @objc public static let isIphone_X_landscape : Bool = Double(fabs(UIScreen.main.bounds.size.width - 812)) < Double.ulpOfOne
    
    @objc public static func DDV(ipadValue : CGFloat, iphoneValue : CGFloat) -> CGFloat {
        if Macro.deviceIsIpad {
            return ipadValue
        }
        return iphoneValue
    }
    
    @objc public static func DDDV(ipadValue : CGFloat,
                            iphone_X_value : CGFloat,
                            iphone_6plus_value : CGFloat,
                            iphone_6_value : CGFloat,
                            iphone_3_5_Value : CGFloat,
                            iphone_4_Value : CGFloat) -> CGFloat {
        if Macro.deviceIsIphone {
            if isIphone_X_protrait || isIphone_X_landscape {
                return iphone_X_value
            }
            else if isIphone_6plus_protrait || isIphone_6plus_landscape {
                return iphone_6plus_value
            } else if isIphone_6_protrait || isIphone_6_landscape {
                return iphone_6_value
            } else if isIphone_5_protrait || isIphone_5_landscape {
                return iphone_3_5_Value
            } else {
                return iphone_4_Value
            }
        }
        
        return ipadValue
    }
    
// MARK: System version
    @objc public static func osVersionEqualTo(version v : String) -> Bool {
        let osversion = UIDevice.current.systemVersion
        
        return osversion.compare(v, options: String.CompareOptions.numeric, range: nil, locale: nil) == ComparisonResult.orderedSame
    }
    
    @objc public static func osVersionGreaterThan(version v : String) -> Bool {
        let osversion = UIDevice.current.systemVersion
        
        return osversion.compare(v, options: String.CompareOptions.numeric, range: nil, locale: nil) == ComparisonResult.orderedDescending
    }
    
    @objc public static func osVersionGreaterThanOrEqualTo(version v : String) -> Bool {
        let osversion = UIDevice.current.systemVersion
        
        return osversion.compare(v, options: String.CompareOptions.numeric, range: nil, locale: nil) != ComparisonResult.orderedAscending
    }
    
    @objc public static func osVersionLessThan(version v : String) -> Bool {
        let osversion = UIDevice.current.systemVersion
        
        return osversion.compare(v, options: String.CompareOptions.numeric, range: nil, locale: nil) == ComparisonResult.orderedAscending
    }
    
    @objc public static func osVersionLessThanOrEqualTo(version v : String) -> Bool {
        let osversion = UIDevice.current.systemVersion
        
        return osversion.compare(v, options: String.CompareOptions.numeric, range: nil, locale: nil) != ComparisonResult.orderedDescending
    }
    
// MARK: User Default
    @objc public static func saveToUserDefault(obj : AnyObject, key : String) -> Void {
        let ud : UserDefaults = UserDefaults.standard
        ud.set(obj, forKey: key)
        ud.synchronize()
    }
    
    @objc public static func getFromUserDefault(key : String) -> AnyObject? {
        let ud : UserDefaults = UserDefaults.standard
        return ud.object(forKey: key) as AnyObject?
    }
    
    @objc public static func removeFromUserDefault(key : String) -> Void {
        let ud : UserDefaults = UserDefaults.standard
        ud.removeObject(forKey: key)
        ud.synchronize()
    }
    
// MARK: Dispatch utils
    @objc public static func dispatch(afterSecond time : TimeInterval, execute : @escaping ()->(Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
            execute()
        })
    }
    
    @objc public static func dispatchOnBackgroundThreadAfter(afterSecond time : TimeInterval, execute : @escaping ()->(Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
            DispatchQueue.global(qos: .background).async {
                print("This is run on the background queue")
                execute()
            }
        })
    }
}
