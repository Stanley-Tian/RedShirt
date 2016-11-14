//
//  EmployeeDetailViewController.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/4.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit
//import RealmSwift

class EmployeeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var employeeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var latest30DaysRewardLabel: UILabel!
    
    @IBOutlet weak var commentGreatButton: UIButton!
    @IBOutlet weak var commentGoodButton: UIButton!
    @IBOutlet weak var commentNotTooBadButton: UIButton!
    
    @IBOutlet weak var rewardLevel1Button: UIButton!
    @IBOutlet weak var rewardLevel2Button: UIButton!
    @IBOutlet weak var rewardLevel3Button: UIButton!
    
    @IBOutlet weak var rewardUserDefineTextField: UITextField!
    
    var employee: Employee?
    var evaluation: Evaluation?
    var comment:String = ""
    //var sourceSegue = ""
    @IBAction func starButtonClick(_ sender: UIButton) {
        
        let starsCount = sender.tag
        evaluation?.stars = starsCount
        resetCommentButtonColor(color: .green)
        switch sender.tag {
        case 5:
            commentGreatButton.backgroundColor = .blue
            comment = (commentGreatButton.titleLabel?.text!)!
        case 3:
            commentGoodButton.backgroundColor = .blue
            comment = (commentGoodButton.titleLabel?.text!)!
        case 1:
            commentNotTooBadButton.backgroundColor = .blue
            comment = (commentNotTooBadButton.titleLabel?.text!)!
        default:
            break
        }
    }
    func resetRewardButtonColor(color:UIColor){
        rewardLevel1Button.backgroundColor = color
        rewardLevel2Button.backgroundColor = color
        rewardLevel3Button.backgroundColor = color
    }
    func resetCommentButtonColor(color:UIColor){
        commentGreatButton.backgroundColor = color
        commentGoodButton.backgroundColor = color
        commentNotTooBadButton.backgroundColor = color
    }
    @IBAction func rewardButtonClick(_ sender: UIButton) {
        resetRewardButtonColor(color: .green)
        
        let rewardTag = sender.tag
        switch rewardTag {
        case 111:
            evaluation?.reward = 2
            rewardLevel1Button.backgroundColor = .blue
        case 112:
            evaluation?.reward = 5
            rewardLevel2Button.backgroundColor = .blue
        case 113:
            evaluation?.reward = 10
            rewardLevel3Button.backgroundColor = .blue
        default:
            break
        }
    }
    @IBAction func rewardUserDefineTextFieldEditEnd(_ sender: UITextField) {
        resetRewardButtonColor(color: .green)
        
        print(rewardUserDefineTextField.text!)
        if rewardUserDefineTextField.text != nil {
            evaluation!.reward = Double(rewardUserDefineTextField.text!) ?? 0
        } else {
            //evaluation
        }
        print("自定义打赏：",evaluation!.reward)
    }
    // MARK:点击提交按钮
    @IBAction func submitButtonClick(_ sender: UIButton) {
        
        if validtaion() {
            var alert_message = "感谢您参与评价！\n您的评价为：\(comment)"
            if evaluation!.reward > 0 {
                alert_message += "\n您的赏金为：\(evaluation!.reward)"
            }
            let alertController = UIAlertController(title: nil, message: alert_message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "确认", style: .default, handler: { alert in
                _ = EvaluationTable.instance.addAnEvaluation(evaluation: self.evaluation!)

                self.performSegue(withIdentifier: "saveUnwindSegue", sender: nil)
            })
            let modifyAction = UIAlertAction(title: "返回修改", style: .default, handler: {alert in alertController.dismiss(animated: true, completion: nil)})
            alertController.addAction(modifyAction)
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion:nil)
        } else {
            let alertController = UIAlertController(title: nil , message: "请评价！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .cancel, handler: {
                alert in alertController.dismiss(animated: true, completion: nil)//dismiss
            })
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = employee?.name
        
        employeeImageView.image = employee?.image
        
        ratingLabel.text = Tools.createRatingStars(rating: employee!.rating!)
        
        briefLabel.text = employee?.brief
        
        evaluation = Evaluation(withStars: 0, andReward: 0, andEmployeeId: (employee?.id)!)
        
    }
    
    func validtaion() -> Bool
    {
        if evaluation?.stars == 0 {
            return false
        }
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
}
// MARK: - Navigation
extension EmployeeDetailViewController{
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        print((sender! as AnyObject).tag)
        if identifier == "cancelUnwindSegue" {
            return true
        }
//        if identifier == "saveUnwindSegue"{
//            if validtaion(){
//                EvaluationTable.instance.addAnEvaluation(evaluation: evaluation!)
//                return true
//            }else{
//                let alertController = UIAlertController(title: "", message: "请评价星级", preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertController.addAction(alertAction)
//                present(alertController, animated: true, completion: nil)
//                return false
//            }
//        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
