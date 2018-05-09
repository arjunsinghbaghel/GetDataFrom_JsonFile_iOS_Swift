//
//  LoginViewController.swift
//  MiviTest_Arjun
//
//  Created by Arjun Singh Baghel on 07/05/18.
//  Copyright © 2018 Arjun Singh Baghel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginElementsContainerView: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var dataArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginUI()
        getJsonData()
    }

    // MARK: Get Data from Json file
    func getJsonData() {
        if let path = Bundle.main.path(forResource: "collection", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,  let includedDic = jsonResult["included"] as? [Any] {
                    
                    dataArray = includedDic as NSArray
                }
            } catch {
                showAlerMessage(message: "Json file not found.")
            }
        }
    }

    // MARK: Login Button Action
    @IBAction func loginButtonAction(_ sender: Any) {
        if (loginTextField.text?.isEmpty)! {
            showAlerMessage(message: "Please enter MSN Number.")
        }
        
        let getAttributes = dataArray[0]
        let attributes = (getAttributes as AnyObject).value(forKey: "attributes")
        let msnStr  =  (attributes as AnyObject).value(forKey: "msn") as! String
        if msnStr == loginTextField.text {
            performSegue(withIdentifier: "PlanDetailsSegue", sender: self)
        }else{
            showAlerMessage(message: "MSN number not present. Please enter correct MSN number.")
        }
        
    }
   // MARK: SetUI
    func setLoginUI()  {
        loginElementsContainerView.layer.shadowColor = UIColor.darkGray.cgColor
        loginElementsContainerView.layer.shadowOpacity = 1.0
        loginElementsContainerView.layer.shadowOffset = .zero
        loginElementsContainerView.layer.masksToBounds = false
        loginElementsContainerView.layer.cornerRadius = 10.0
        
        
        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowOffset = .zero
        loginButton.layer.masksToBounds = false
        loginButton.layer.cornerRadius = 5.0
    }
    
    // MARK: ShowAlertMessage
    func showAlerMessage(message:NSString )   {
        
        let alert = UIAlertController(title: "Message", message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mPlanDetailsViewController = segue.destination as! PlanDetailsViewController
        mPlanDetailsViewController.planDetailsDataArray = dataArray
    }
 

}
