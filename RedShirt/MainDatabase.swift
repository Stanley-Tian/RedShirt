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

    public let db: Connection?

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
}
