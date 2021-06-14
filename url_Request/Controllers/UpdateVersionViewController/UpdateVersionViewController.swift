//
//  UpdateVersionViewController.swift
//  url_Request
//
//  Created by M Zaryab on 25/05/2021.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class UpdateVersionViewController: UIViewController {
    // MARK:- IBoutlet
    @IBOutlet weak var addCmntsOutlet: UIButton!
    @IBOutlet weak var versionOulet: UITextField!
    @IBOutlet weak var buildOutlet: UITextField!
    @IBOutlet weak var updateOutlet: UIButton!
    @IBOutlet weak var testFlightBtnOutlet: UIButton!
    @IBOutlet weak var commentsOutlet: UITextField!
    @IBOutlet weak var productionBtnOutlet: UIButton!
    @IBOutlet weak var iosBtn: UIButton!
    @IBOutlet weak var androidBtn: UIButton!
    @IBOutlet weak var webBtn: UIButton!
    //MARK:-Properties
    var appId = ""
    var environment = "production"
    var platform = ""
    var commentArr = [String]()
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iosBtn.isSelected = true
        platform = "ios"
        styleFieldAndButtons()
        productionBtnOutlet.isSelected = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));        view.addGestureRecognizer(tap)
        
        print(appId)
        print(environment)
        print(platform)
    }
    // MARK:- Methods
     func styleFieldAndButtons(){
        addCmntsOutlet.layer.cornerRadius = 3
        addCmntsOutlet.clipsToBounds = true
        versionOulet.roundCorners(radius: versionOulet.frame.size.height/2.5, bordorColor: UIColor(red: 102/255, green: 39/255, blue: 26/225, alpha: 1), borderWidth: 1)
        buildOutlet.roundCorners(radius: buildOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 102/255, green: 39/255, blue: 26/225, alpha: 1), borderWidth: 1)
        commentsOutlet.roundCorners(radius: commentsOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 102/255, green: 39/255, blue: 26/225, alpha: 1), borderWidth: 1)
        updateOutlet.roundCorners(radius: updateOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 102/255, green: 39/255, blue: 26/225, alpha: 1), borderWidth: 1)
     }
    // MARK:- Keyboard return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }

    func updateVersion(param: [String:Any]) {
        UserHandler.updateVersion(param: param) { [self] (successResponse) in
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
    //MARK:-IBActions
    
    
    @IBAction func produnctionBtnOutlet(_ sender: Any) {
    }
    @IBAction func testBtnOutlet(_ sender: Any) {
    }
    @IBAction func addComentBtn(_ sender: Any) {
        self.commentArr.append(commentsOutlet.text!)
        commentsOutlet.text = nil
    }
    @IBAction func checkButtons(_ sender: UIButton) {
        if sender.tag == 1{
            iosBtn.isSelected = true
            androidBtn.isSelected = false
            webBtn.isSelected = false
            self.platform = "ios"
            print(platform)
        }
        else if sender.tag == 2  {
            androidBtn.isSelected = true
            iosBtn.isSelected = false
            webBtn.isSelected = false
            self.platform = "android"
            print(platform)
        }
        else if sender.tag == 3  {
            webBtn.isSelected = true
            iosBtn.isSelected = false
            androidBtn.isSelected = false
            self.platform = "web"
            print(platform)
        }
    }
    
    @IBAction func environmentCheckBtns(_ sender: UIButton) {
        if sender.tag == 1{
            self.environment = "production"
            productionBtnOutlet.isSelected = true
            testFlightBtnOutlet.isSelected = false
            
        }
        else if sender.tag == 2{
            self.environment = "testflight"
            testFlightBtnOutlet.isSelected = true
            productionBtnOutlet.isSelected = false
        }
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
        print("update ")
        print(platform)
        if versionOulet.text == "" || buildOutlet.text == "" || commentsOutlet.text == ""{
            let alert = Constants.showAlert(message: "Please Fill all fields")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.commentArr.append(commentsOutlet.text!)
            let params : [String : AnyObject] = ["platform": platform as AnyObject, "app_id": appId as AnyObject, "version_no": versionOulet.text as AnyObject, "environment": environment as AnyObject, "build_no": buildOutlet.text as AnyObject, "comments": commentArr as AnyObject  ] // swiftlint:disable:this line_length
        let data : [String : AnyObject] = ["data": params as AnyObject]
        print(data)
        updateVersion(param: data)
        }
    }
    
}
