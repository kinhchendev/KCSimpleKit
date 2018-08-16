//
//  Extension+Image.swift
//  KCSimpleKit
//
//  Created by Tran Vinh Kinh on 8/13/18.
//  Copyright © 2018 Tran Vinh Kinh. All rights reserved.
//

import Foundation

public extension UIImageView {
    public func imageFromServerURL(urlString: String) {
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

public extension UIImage {
    public static func imageFromBase64String(str : String) -> UIImage? {
        let imageData = Data(base64Encoded: str, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData) ?? nil
    }
    
    public static func image(fromURL url : String?, completion : @escaping ((UIImage?) -> (Void))) {
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
