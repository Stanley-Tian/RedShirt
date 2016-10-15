//
//  AddEmployeeTableViewController.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/2.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit
import SQLite

class AddEmployeeTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var briefTextView: UITextView!
    @IBOutlet weak var largeImageImageView: UIImageView!
    @IBOutlet weak var saveBarButtomItem: UIBarButtonItem!
    var employeeLargeImage:UIImage!
    var employee: Employee!
    var sourceSegue: String?
    //var employee2:Employee!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        for _ in 1...5{
            print("************************")
        }
        //print( Realm.Configuration.defaultConfiguration.fileURL ?? "can't find the realm url")
        if let sourceSegue = self.sourceSegue {
            if sourceSegue == "ToEditSegue"{
                title = "修改员工资料"
                portraitImageView.image = employee.portrait
                nameTextField.text = employee.name
                briefTextView.text = employee.brief
                largeImageImageView.image = employee.image
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0,1:
            let optionMenu = UIAlertController(title: nil, message: "请设置头像", preferredStyle: .actionSheet)
            let takePictureButton = UIAlertAction(title: "打开相机", style: .default, handler: {(action:UIAlertAction!) -> Void in
                if UIImagePickerController.isSourceTypeAvailable(.camera){ //先判断权限是否够用
                    let imagePicker = AddPhotoImagePickerController() // 生成一个新的UIImagePickerController
                    imagePicker.delegate = self                           // 设置代理
                    imagePicker.allowsEditing = (indexPath.row == 0 ? true:false)                // 禁用编辑，若为true则用户可以缩放图片后再用
                    imagePicker.sourceType = .camera       //设置image的类型。若要调用相机则为.camera
                    imagePicker.invoker = String(indexPath.row)
                    self.present(imagePicker, animated: true, completion: nil) // 调用
                }
            })
            let getPictureFromLibraryButton = UIAlertAction(title: "打开图库", style: .default, handler: {
                (action:UIAlertAction!) -> Void in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){ //先判断权限是否够用
                    let imagePicker = AddPhotoImagePickerController() // 生成一个新的UIImagePickerController
                    imagePicker.delegate = self                           // 设置代理
                    imagePicker.allowsEditing = (indexPath.row == 0 ? true:false)                             // 禁用编辑，若为true则用户可以缩放图片后再用
                    imagePicker.sourceType = .photoLibrary       //设置image的类型。若要调用相机则为.camera
                    imagePicker.invoker = String(indexPath.row)
                    self.present(imagePicker, animated: true, completion: nil) // 调用
                }
            })
            let cancelButton = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            optionMenu.addAction(takePictureButton)
            optionMenu.addAction(getPictureFromLibraryButton)
            optionMenu.addAction(cancelButton)
            
            // support iPad
            optionMenu.popoverPresentationController?.sourceView = self.view
            optionMenu.popoverPresentationController?.sourceRect = (tableView.cellForRow(at: indexPath)?.frame)!
            
            self.present(optionMenu, animated: true, completion: nil)
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagePicker = picker as! AddPhotoImagePickerController
        if imagePicker.invoker == "0" {
            portraitImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage //downcasting到UIImage类型
            portraitImageView.contentMode = .scaleAspectFit                //设置填充样式
            portraitImageView.clipsToBounds = true                               //设置剪裁
            Tools.setSameConstraintToSuperViewForAllSides(itemView: portraitImageView,constant: 10)
        }
        if imagePicker.invoker == "1" {
            largeImageImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage //downcasting到UIImage类型
            largeImageImageView.contentMode = .scaleAspectFit                //设置填充样式
            largeImageImageView.clipsToBounds = true                               //设置剪裁
            Tools.setSameConstraintToSuperViewForAllSides(itemView: largeImageImageView,constant: 10)
        }
        dismiss(animated: true, completion: nil)//隐藏照片拾取界面
        
    }
    // try to save with realm
    
    func addAnEmployee(WithName name:String?, AndPortrait portrait:UIImage?, AndLargeImage image:UIImage?, AndBrief brief:String?){
         if EmployeeTable.instance.addAnEmployee(name: name!, brief: brief!, portrait: portrait!, image: image!) != nil{
            print("增加一名新员工成功！")
        }
        
    }
    func updateAnEmployee(WithName name:String?, AndPortrait portrait:UIImage?, AndLargeImage image:UIImage?, AndBrief brief:String?){
        if EmployeeTable.instance.updateAnEmployee(byId: employee.id, newName: name!, newBrief: brief!, newPortrait: portrait!, newImage: image!) {
            print("修改一名员工成功!")
        }

    }

    func performValidation() -> Bool{
        if nameTextField.text! == "" {
            return false
        }else{
            return true
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let btn = sender as! UIBarButtonItem
        
        if btn.tag == 10 {
            //do cancel
            return true
        }else if btn.tag == 11{
            if performValidation(){
                let portrait = portraitImageView.image
                let name = nameTextField.text
                let brief = briefTextView.text
                let image = largeImageImageView.image
                if sourceSegue == "ToAddSegue"{
                    addAnEmployee(WithName: name, AndPortrait: portrait, AndLargeImage: image, AndBrief: brief)}
                if sourceSegue == "ToEditSegue"{
                    updateAnEmployee(WithName: name, AndPortrait: portrait, AndLargeImage: image, AndBrief: brief)
                }
                return true}
            else{
                return false
            }
        }else{
            return true
        }
        
        
        
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
