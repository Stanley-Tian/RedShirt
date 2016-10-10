//
//  Employee.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import RealmSwift
import SQLite

//v0
class EmployeeModel:Object{
    dynamic var name:       String  = ""
    dynamic var brief:      String  = ""
    dynamic var rating:     Double  = 0.0
    dynamic var portrait:   NSData  = NSData()
    dynamic var image:      NSData  = NSData()
    dynamic var id:         String  = ""
    dynamic var createdAt:  NSDate  = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
class EmployeeTable: MainDatabase {
    static let instance = EmployeeTable()

    // Tables
    private let tableEmployee = Table("employee")
    // columns
    private var id = Expression<String>("id")
    private let name = Expression<String>("name")
    private let brief = Expression<String>("brief")
    private let portrait = Expression<UIImage?>("portrait")
    private let image = Expression<UIImage?>("image")
    private let createdAt = Expression<NSDate?>("createdAt")
    private let rating = Expression<Double?>("rating")

    // 建表
     override func createTable() {
        do {
            try super.db!.run(tableEmployee.create(ifNotExists: true){ table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(brief)
            })
        } catch {
            print("创建table失败")
        }
    }
    
    func updateTable(){
        do{
            //try super.db!.run(tableEmployee.addColumn(rating))
            try super.db!.run(tableEmployee.addColumn(image))
            try super.db!.run(tableEmployee.addColumn(createdAt))
        } catch {
            print("增加列数据失败")
        }
    }
    // - MARK:CRUD -
    // CRUD
    func addAnEmployee(name:String, brief:String, portrait:UIImage, image:UIImage) -> Int64?{
        do {
            let insert = tableEmployee.insert(self.id <- UUID().uuidString,
                                              self.name <- name,
                                              self.brief <- brief,
                                              self.portrait <- portrait,
                                              self.image <- image,
                                              self.rating <- 5.0,
                                              self.createdAt <- NSDate())
            let rowid = try db!.run(insert)
            
            return rowid
        } catch {
            print("Insert failed")
            return nil
        }
    }
}
