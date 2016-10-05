//
//  AppDelegate.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Config for Realm, do this for real publish
        /*
         
        let config = Realm.Configuration(
            schemaVersion: 2,// current Version
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: EmployeeModel.className()) { oldObject, newObject in
                        // update value type
                        newObject!["rating"] = oldObject!["rating"] as! Double
                        // add a new var
                        newObject!["image"] = NSData()
                    }
                }
                if (oldSchemaVersion < 2) {
                    migration.enumerateObjects(ofType: EmployeeModel.className()) { oldObject, newObject in
                        // update value type
                        // add a new var
                        newObject!["id"] = UUID().uuidString
                        newObject!["createdAt"] = Date()

                    }
                }
        })


        Realm.Configuration.defaultConfiguration = config
        print("Migrated objects in the default Realm: \(try! Realm().objects(EmployeeModel.self))")
 */
                print("Migrated objects in the default Realm: \(try! Realm().objects(EmployeeModel.self))")
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //self.saveContext()
    }
    
}

