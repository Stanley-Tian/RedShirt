//
//  Employee.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import RealmSwift

class EmployeeModel:Object{
    dynamic var name:String = ""
    dynamic var brief:String = ""
    dynamic var rating:Double = 0.0
    dynamic var portrait:NSData = NSData()
    
}
