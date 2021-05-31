//
//  VersionCheckVC.swift
//  TaskA
//
//  Created by SaifUllah Butt on 24/05/2021.
//

import UIKit

class VersionCheckVC: UIViewController {
    
    
    @IBOutlet weak var platformField: UITextField!
    @IBOutlet weak var appIdField: UITextField!
    @IBOutlet weak var versionNoField: UITextField!
    @IBOutlet weak var buildNoField: UITextField!
    
    
    @IBOutlet weak var productionBtn: UIButton!
    @IBOutlet weak var testBtn: UIButton!
    
    var productionBtnFlag = false
    var testBtnFlag = false
    var environment = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleField()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));        view.addGestureRecognizer(tap)
    }
    
    //MARK:-Methods
    func styleField(){
        platformField.roundCorners(radius:5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        appIdField.roundCorners(radius:5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        versionNoField.roundCorners(radius:5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        buildNoField.roundCorners(radius:5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
    }
    //MARK:- Keyboard return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
       
       @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }
    //MARK:-Check Version function
    func checkVersion(param: [String:Any]) {
        UserHandler.checkVersion(param: param) { [self] (successResponse) in
            if (successResponse.status as AnyObject) as? NSString == "1"{
                let alert = Constants.showAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                let alert = Constants.showAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        } failure: { (error) in
            let alert = Constants.showAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //MARK:- IBActions
    @IBAction func productionBtn(_ sender: UIButton) {
        
        if productionBtnFlag == false{
            sender.setBackgroundImage(UIImage(named: "radioBtnSelected"), for: UIControl.State.normal)
            testBtn.setBackgroundImage(UIImage(named: "radioBtnDefault"), for: UIControl.State.normal)
        productionBtnFlag = true
            self.environment = "production"
        testBtnFlag = false
            
        }
    }
    
    @IBAction func testBtn(_ sender: UIButton) {
        if testBtnFlag == false{
            sender.setBackgroundImage(UIImage(named: "radioBtnSelected"), for: UIControl.State.normal)
            productionBtn.setBackgroundImage(UIImage(named: "radioBtnDefault"), for: UIControl.State.normal)
        productionBtnFlag = false
        testBtnFlag = true
            self.environment = "testflight"
        }
    }
    
    
    @IBAction func printBtn(_ sender: UIButton) {
        
        if platformField.text == "" || appIdField.text == "" || versionNoField.text == "" || buildNoField.text == "" {
            
            let alert = Constants.showAlert(message: "Please Fill all fields")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let params : [String : AnyObject] = ["platform": platformField.text as AnyObject, "app_id": appIdField.text as AnyObject, "version_no": versionNoField.text as AnyObject, "environment": environment as AnyObject, "build_no": buildNoField.text as AnyObject ]
            let data : [String : AnyObject] = ["data": params as AnyObject]
            print(data)
            checkVersion(param: data)
    }
    }
    

}
