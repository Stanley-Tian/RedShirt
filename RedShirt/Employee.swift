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
class Employee{
    let id: String
    var name: String
    var brief: String
    var portrait: UIImage?
    var image: UIImage?
    var createdAt: Date?
    var rating: Double?
    
    init(id:String, name:String, brief:String, portrait:UIImage?, image:UIImage?, createdAt:Date?, rating:Double?) {
        self.id = id
        self.name = name
        self.brief = brief
        self.portrait = portrait
        self.image = image
        self.createdAt = createdAt
        self.rating = rating
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
                table.column(portrait)
                table.column(image)
                table.column(createdAt)
                table.column(rating)
            })
            print("创建table成功")
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
    // MARK:CREATE
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
    
    // MARK:READ
    func getEmployees() -> [Employee] {
        var employees = [Employee]()
        
        do {
            for employee in try db!.prepare(self.tableEmployee){
                employees.append(Employee(id: employee[id],
                                          name: employee[name],
                                          brief: employee[brief],
                                          portrait: employee.get(portrait),
                                          image: employee.get(image),
                                          createdAt: (employee.get(createdAt) as? Date),
                                          rating: employee[rating]))
            }
        }catch{
            print("获取员工数据失败")
        }
        return employees
    }
    // MARK:UPDATE
    func updateAnEmployee(byId employeeId:String, newName:String, newBrief:String, newPortrait:UIImage, newImage:UIImage) -> Bool{
        let employeeToUpdate = tableEmployee.filter(id == employeeId)

        do {
            let update = employeeToUpdate.update([
                name <- newName,
                brief <- newBrief,
                portrait <- newPortrait,
                image <- newImage,
                ])
            if try db!.run(update) > 0 {
                return true
            }else{
                return false
            }
            
        } catch {
            print("更新员工数据失败")
            return false
        }
    }
    // MARK:DELETE
    func deleteAnEmployee(byId employeeId:String) -> Bool {
        do {
            let employeeToDelete = tableEmployee.filter(id == employeeId)
            if try db!.run(employeeToDelete.delete()) > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print("删除员工失败！")
            return false
        }
    }
}
