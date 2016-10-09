//
//  mainDatabase.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/9.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import SQLite

class MainDatabase {
    // 单例模式
    // static let instance = self()
    public let db: Connection?
    /*
    // Tables
    private let tableEmployee = Table("employee")
    // columns
    private var id = Expression<String>("id")
    private let name = Expression<String>("name")
    private let brief = Expression<String>("brief")
    */
    public init(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            db = try Connection("\(path)/mainDatabase.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    func createTable() {
        
    }
    /*
    // 建表
    func createTable() {
        do {
            try db!.run(tableEmployee.create(ifNotExists: true){ table in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(brief)
            })
        } catch {
            print("创建table失败")
        }
    }
    // - MARK:CRUD -
    // CRUD
    func addAnEmployee(name:String, brief:String) -> Int64?{
        do {
            let insert = tableEmployee.insert(self.name <- name, self.brief <- brief, self.id <- UUID().uuidString)
            let rowid = try db!.run(insert)
            
            return rowid
        } catch {
            print("Insert failed")
            return nil
        }
    }
 */
}
