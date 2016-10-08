//
//  Evaluation.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/6.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import RealmSwift
//v0
class EvaluationModel:Object{
    dynamic var stars:      Int     = 0
    dynamic var reward:     Int     = 0
    dynamic var employee:      EmployeeModel?
    dynamic var id:         String  = ""
    dynamic var createdAt:  NSDate?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(stars:Int, reward:Int, employee:EmployeeModel)
    {
        self.init()
        self.stars = stars
        self.reward = reward
        self.employee = employee
        self.id = UUID().uuidString
        self.createdAt = NSDate()
    }
    func save(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
}
