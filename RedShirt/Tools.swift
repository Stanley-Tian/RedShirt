//
//  Tools.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//工具类
class Tools{
    class func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
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
}
