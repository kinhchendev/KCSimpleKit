//
//  Extension+Image.swift
//  KCSimpleKit
//
//  Created by Tran Vinh Kinh on 8/13/18.
//  Copyright © 2018 Tran Vinh Kinh. All rights reserved.
//

import Foundation

@objc public extension UIImageView {
    @objc public func imageFromServerURL(urlString: String) {
        let nsStr : NSString = urlString as NSString
        let escapeString = nsStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: escapeString!) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if let e = error {
                    print(e)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                })
                
            }).resume()
        }
    }
}

@objc public extension UIImage {
    @objc public static func imageFromBase64String(str : String) -> UIImage? {
        let imageData = Data(base64Encoded: str, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData) ?? nil
    }
    
    @objc public static func image(fromURL url : String?, completion : @escaping ((UIImage?) -> (Void))) {
        guard let u = url, let downloadURL = URL(string: u) else {
            completion(nil)
            return
        }
        
        let requestUrl = URLRequest(url: downloadURL)
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            DispatchQueue.main.async {
                if let d = data, let img = UIImage(data: d) {
                    completion(img)
                    return
                }
                completion(nil)
            }
        }.resume()
    }
}

@objc public extension UIImage {
    @objc func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}
