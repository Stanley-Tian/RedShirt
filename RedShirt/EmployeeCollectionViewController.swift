//
//  EmployeeCollectionViewController.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class EmployeeCollectionViewController: UICollectionViewController {
    
    let employees = [
    Employee(name: "李桂花", portrait: "1"),
    Employee(name: "张铁柱", portrait: "2"),
    Employee(name: "齐德彪", portrait: "3"),
    Employee(name: "李德生", portrait: "4"),
    Employee(name: "孙忠家", portrait: "5"),
    Employee(name: "王丕申", portrait: "6"),
    Employee(name: "柯文渡", portrait: "7"),
    Employee(name: "李桂花", portrait: "1"),
    Employee(name: "张铁柱", portrait: "2"),
    Employee(name: "齐德彪", portrait: "3"),
    Employee(name: "李德生", portrait: "4"),
    Employee(name: "孙忠家", portrait: "5"),
    Employee(name: "王丕申", portrait: "6"),
    Employee(name: "柯文渡", portrait: "7"),
    ]
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){  }
    @IBAction func unwindToSave(segue:UIStoryboardSegue){
        let addEmployeeController = segue.source as! AddEmployeeTableViewController
        let e = addEmployeeController.employee
        print(e)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 设置item之间和line之间的间距
        let spacing = CGFloat(20)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing/2
        
        let columnNum = 3
        // 设置每一个item的宽度
        let itemWidth = (Int(collectionView!.bounds.width) - (columnNum + 1)*Int(spacing))/columnNum
        layout.itemSize = CGSize(width: itemWidth, height: Int(Double(itemWidth)*1.4))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return employees.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmployeeCollectionViewCell
        cell.nameLabel.text = employees[indexPath.row].name
        cell.portraitImageView.image = UIImage(named: employees[indexPath.row].portrait)
        // Configure the cell

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
