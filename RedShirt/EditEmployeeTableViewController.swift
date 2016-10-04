//
//  EditEmployeeTableViewController.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/4.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit
import RealmSwift
class EditEmployeeTableViewController: UITableViewController {

    var employees = try! Realm().objects(EmployeeModel.self).sorted(byProperty: "name", ascending: true)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        employees = try! Realm().objects(EmployeeModel.self).sorted(byProperty: "name", ascending: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table view data source
extension EditEmployeeTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employees.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditEmployeeTableViewCell
        
        cell.portraitImageView?.image = UIImage(data: employees[indexPath.row].portrait as Data)
        cell.nameLabel?.text = employees[indexPath.row].name
        
        var stars = ""

        while stars.characters.count < employees[indexPath.row].rating {
            stars += "★"
        }
        
        while stars.characters.count < 5 {
            stars += "☆"
        }
        
        cell.ratingLabel?.text = stars
     
     // Configure the cell...
     
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
}
// MARK: - Navigation
extension EditEmployeeTableViewController{
    
    /*
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func unwindToCancel(segue:UIStoryboardSegue){  }
    @IBAction func unwindToSave(segue:UIStoryboardSegue){
        //let addEmployeeController = segue.source as! AddEmployeeTableViewController
        //let e = addEmployeeController.employee
        //print(e)
        employees = try! Realm().objects(EmployeeModel.self).sorted(byProperty: "name", ascending: false)
        tableView!.reloadData()
    }
}