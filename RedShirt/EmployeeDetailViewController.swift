//
//  EmployeeDetailViewController.swift
//  RedShirt
//
//  Created by 史丹利复合田 on 2016/10/4.
//  Copyright © 2016年 史丹利复合田. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    
    @IBOutlet weak var employeeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var latest30DaysRewardLabel: UILabel!
    
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    
    
    @IBAction func starButtonClick(_ sender: UIButton) {

        let starsCount = sender.tag
        paintStarButtons(starsCount)
    }
    
    func clearStarButtons(){
        star1Button.setTitle("☆", for: .normal)
        star2Button.setTitle("☆", for: .normal)
        star3Button.setTitle("☆", for: .normal)
        star4Button.setTitle("☆", for: .normal)
        star5Button.setTitle("☆", for: .normal)
    }
    func paintStarButtons(_ starsCount:Int){
        clearStarButtons()
        if starsCount >= 1 {
            star1Button.setTitle("★", for: .normal)
        }
        if starsCount >= 2 {
            star2Button.setTitle("★", for: .normal)
        }
        if starsCount >= 3 {
            star3Button.setTitle("★", for: .normal)
        }
        if starsCount >= 4 {
            star4Button.setTitle("★", for: .normal)
        }
        if starsCount >= 5 {
            star5Button.setTitle("★", for: .normal)
        }
        
    }
    var employee: EmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = employee?.name
        
        employeeImageView.image = UIImage(data:employee?.image as! Data )
        
        ratingLabel.text = Tools.createRatingStars(rating: employee!.rating)
        
        briefLabel.text = employee?.brief
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Navigation
extension EmployeeDetailViewController{
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        if identifier == "cancelUnwindSegue" {
            return true
        }
        if identifier == "saveUnwindSegue"{
            return true
        }
        
        return true
    }
}
