//
//  EditEmployeeTableViewController.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/4.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit
class EditEmployeeTableViewController: UITableViewController {
    
    var employees:[Employee]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        employees = EmployeeTable.instance.getEmployees()
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
        
        cell.portraitImageView?.image = employees[indexPath.row].portrait
        cell.nameLabel?.text = employees[indexPath.row].name
        
        var stars = ""
        
        while stars.characters.count < Int(employees[indexPath.row].rating ?? 0) {
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
// MARK: - tableview Delegate
extension EditEmployeeTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "编辑", handler: {
            (action,indexPath) -> Void in
            self.performSegue(withIdentifier: "ToEditSegue", sender: self.tableView.cellForRow(at: indexPath))
        })
        
        let deleteAction = UITableViewRowAction(style: .default, title: "删除", handler: {(action,indexPath) -> Void in
            _ = EmployeeTable.instance.deleteAnEmployee(byId: self.employees[indexPath.row].id)
            self.employees.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        })
        
        editAction.backgroundColor = UIColor.blue
        
        return [deleteAction, editAction]
    }
}

// MARK: - Navigation
extension EditEmployeeTableViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToEditSegue"{
            //let destinationController = segue.destination
            let destinationNavigationController = segue.destination as! UINavigationController
            let destinationController = destinationNavigationController.topViewController as! AddEmployeeTableViewController

            let cellSender = sender as! EditEmployeeTableViewCell
            destinationController.employee = employees[(tableView.indexPath(for: cellSender)?.row)!]
            
            destinationController.sourceSegue = "ToEditSegue"
        }
        if segue.identifier == "ToAddSegue"{
            let destinationNavigationController = segue.destination as! UINavigationController
            let destinationController = destinationNavigationController.topViewController as! AddEmployeeTableViewController
            
            destinationController.sourceSegue = "ToAddSegue"
        }
        
    }
    
    @IBAction func unwindToCancel(segue:UIStoryboardSegue){  }
    @IBAction func unwindToSave(segue:UIStoryboardSegue){
        //let addEmployeeController = segue.source as! AddEmployeeTableViewController
        //let e = addEmployeeController.employee
        //print(e)
        employees = EmployeeTable.instance.getEmployees()

        tableView!.reloadData()
    }
}
