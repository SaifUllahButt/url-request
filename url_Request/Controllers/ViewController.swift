//
//  ViewController.swift
//  url_Request
//
//  Created by Zaryab on 8/13/20.
//  Copyright © 2020 M Zaryab. All rights reserved.
//

import UIKit
struct jsonstruct: Decodable{
    
    let name: String
    let region: String
    
}

class ViewController: UIViewController {
    //MARK:-Properties
    private var arr = [jsonstruct]()
    var appId = "parsl"
    var environment = "production"
    var platform = "ios"
    var appVeriosn = " "
    var buildNo = " "
   
    
    //MARK:- life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear...")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("view will layout subview")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("view did layout subview")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
//        let nsAppVersion: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
//        appVeriosn = nsAppVersion as! String
//        print("app version is \(appVeriosn)")
//        let nsBuildNo: AnyObject? = Bundle.main.infoDictionary!["CFBundleVersion"] as AnyObject
//        buildNo = nsBuildNo as! String
//        print("build no is \(buildNo)")
        
    }
   
//
//    func urlRequest() {
//        let session = URLSession.shared
//        let url = URL(string: "https://restcountries.eu/rest/v2/all")!
//
//        let task = session.dataTask(with: url) { data, response, error in
//            if error != nil || data == nil {
//                print("Client error!")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                print("Server error!")
//                return
//            }
//            guard let mime = response.mimeType, mime == "application/json" else {
//                print("Wrong MIME type!")
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(json)
//                self.arr = try JSONDecoder().decode([jsonstruct].self, from: data!)
//                for mai in self.arr{
//                    print(mai.name,":", mai.region)
//                }
//
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
    
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


    @IBAction func getRequest(_ sender: UIButton) {
//        urlRequest()
        
        let params : [String : AnyObject] = ["platform": platform as AnyObject, "app_id": appId as AnyObject, "version_no": appVeriosn as AnyObject, "environment": environment as AnyObject, "build_no": buildNo as AnyObject ]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        print(data)
//        checkVersion(param: data)
    }
}


