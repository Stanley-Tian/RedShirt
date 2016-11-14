//
//  Evaluation.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/6.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import Foundation
import Alamofire
import SQLite

class Evaluation{
    var id:String
    var stars:Int
    var reward:Double
    var employeeId:String
    var createdAt:Date
    
    init(withStars stars:Int, andReward reward:Double, andEmployeeId employeeId:String) {
        self.id = UUID().uuidString
        self.stars = stars
        self.reward = reward
        self.employeeId = employeeId
        self.createdAt = Date()
    }
}

class EvaluationTable:MainDatabase{
    static let instance = EvaluationTable()
    
    // Tables
    private let tableEvaluation = Table("evaluation")
    // columns
    private var id = Expression<String>("id")
    private let stars = Expression<Int>("stars")
    private let reward = Expression<Double>("reward")
    private let employeeId = Expression<String>("employeeId")
    private let createdAt = Expression<NSDate>("createdAt")
    
    // 建表
    override func createTable() {
        do {
            try super.db!.run(tableEvaluation.create(ifNotExists: true){ table in
                table.column(id, primaryKey: true)
                table.column(stars)
                table.column(reward)
                table.column(employeeId)
                table.column(createdAt)
            })
            print("创建table成功")
        } catch {
            print("创建table失败")
        }
    }
    
    func updateTable(){
        do{
            //try super.db!.run(tableEmployee.addColumn(rating))
            //try super.db!.run(tableEmployee.addColumn(image))
            //try super.db!.run(tableEmployee.addColumn(createdAt))
        } catch {
            print("增加列数据失败")
        }
    }
    
    public func addAnEvaluaiton(employeeId:String, stars:Int, reward:Double) -> Int64?{
        do {
            let insert = tableEvaluation.insert(
                self.id <- UUID().uuidString,
                self.stars <- stars,
                self.reward <- reward,
                self.employeeId <- employeeId,
                self.createdAt <- NSDate()
            )
            let rowid = try db!.run(insert)
            

            
            
            return rowid
        } catch {
            print("增加新评价失败！")
            return nil
        }
    }
    
    public func addAnEvaluation(evaluation:Evaluation) -> Bool {
        do {
            let insert = tableEvaluation.insert(
                self.id <- UUID().uuidString,
                self.stars <- evaluation.stars,
                self.reward <- evaluation.reward,
                self.employeeId <- evaluation.employeeId,
                self.createdAt <- NSDate()
            )
            if try db!.run(insert) > 0 {
                
                Alamofire.request("https://httpbin.org/get").responseJSON { response in
                    print(response.request!)  // original URL request
                    print(response.response!) // HTTP URL response
                    print(response.data!)     // server data
                    print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
                return true
            } else {
                return false
            }
            
            
        } catch {
            print("增加新评价失败！")
            return false
        }
    }
}


