//
//  Tools.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import UIKit
import SQLite

//工具类
class Tools{
    // 设置UIView的四周Constraint至同一值
    class func setSameConstraintToSuperViewForAllSides(itemView:UIView, constant:Int = 0, multiplier:Int = 1)
    {
        let leadingConstraint = NSLayoutConstraint(
            item: itemView, attribute: .leading,
            relatedBy: .equal,
            toItem: itemView.superview, attribute: .leading,
            multiplier: CGFloat(multiplier), constant: CGFloat(constant))
        let trailingConstraint = NSLayoutConstraint(
            item: itemView, attribute: .trailing,
            relatedBy: .equal,
            toItem: itemView.superview, attribute: .trailing,
            multiplier: CGFloat(multiplier), constant: CGFloat(-constant))
        let topConstraint = NSLayoutConstraint(
            item: itemView, attribute: .top,
            relatedBy: .equal,
            toItem: itemView.superview, attribute: .top,
            multiplier: CGFloat(multiplier), constant: CGFloat(constant))
        let bottomConstraint = NSLayoutConstraint(
            item: itemView, attribute: .bottom,
            relatedBy: .equal,
            toItem: itemView.superview, attribute: .bottom,
            multiplier: CGFloat(multiplier), constant: CGFloat(-constant))
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        topConstraint.isActive = true
        bottomConstraint.isActive = true
    }
    
    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    class func createRatingStars(rating:Double) -> String{
        var stars = ""
        while stars.characters.count < lroundf(Float(rating)) {
            stars += "★"
        }
        while stars.characters.count < 5 {
            stars += "☆"
        }
        return stars
    }
    
    class func getApp() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
}
// MARK: - Extensions for SQLite
extension NSDate: Value {
    public class var declaredDatatype: String {
        return String.declaredDatatype
    }
    public class func fromDatatypeValue(_ stringValue: String) -> NSDate {
        return SQLDateFormatter.date(from: stringValue)! as NSDate
    }
    public var datatypeValue: String {
        return SQLDateFormatter.string(from: self as Date)
    }
}

let SQLDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
    return formatter
}()
