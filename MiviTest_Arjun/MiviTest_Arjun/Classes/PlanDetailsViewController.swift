//
//  PlanDetailsViewController.swift
//  MiviTest_Arjun
//
//  Created by Arjun Singh Baghel on 07/05/18.
//  Copyright © 2018 Arjun Singh Baghel. All rights reserved.
//

import UIKit

class PlanDetailsViewController: UIViewController {

    var planDetailsDataArray = NSArray()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planPriceLabel: UILabel!
    @IBOutlet weak var remainingDataBanlaneLabel: UILabel!
    @IBOutlet weak var autoRenewalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPlanDetailsUI()
        setUserPlanDtails()
        
        
    }
    
    // MARK:: SetUI
    func setPlanDetailsUI() {
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowOffset = .zero
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 10.0
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    // MARK:: SetUSetPalnDetais
    func setUserPlanDtails() {
        
        var planDetailsData = planDetailsDataArray[2]
        var planDetailsAttributes = (planDetailsData as AnyObject).value(forKey: "attributes")
        
        let planName  =  (planDetailsAttributes as AnyObject).value(forKey: "name") as! String
        planNameLabel.text = "Plan Name : " + planName
        
         let planPrice  =  (planDetailsAttributes as AnyObject).value(forKey: "price") as! NSNumber
        planPriceLabel.text = "Plan Name : Rs.\(planPrice.stringValue)"
        
        planDetailsData = planDetailsDataArray[1]
        planDetailsAttributes = (planDetailsData as AnyObject).value(forKey: "attributes")
        
        let dataBalance  =  (planDetailsAttributes as AnyObject).value(forKey: "included-data-balance") as! NSNumber
        remainingDataBanlaneLabel.text = "Remaining Data : " + dataBalance.stringValue
        
        let autoRenew  =  (planDetailsAttributes as AnyObject).value(forKey: "auto-renewal") as! NSNumber
        if autoRenew == 1 {
            autoRenewalLabel.text = "Auto Renew : Yes"
        }
    }

}
