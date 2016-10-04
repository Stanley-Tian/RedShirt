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
    
    @IBOutlet weak var latest30DaysRewardLabel: UILabel!
    
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
