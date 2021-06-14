//
//  ViewController.swift
//  url_Request
//
//  Created by Zaryab on 8/13/20.
//  Copyright © 2020 M Zaryab. All rights reserved.
//
// swiftlint:disable all
import UIKit
import Alamofire
struct jsonstruct: Decodable{ // swiftlint:disable:this type_name
    let name: String
    let region: String
}

class ViewController: UIViewController {
    // MARK:- Properties
//    private var arr = [jsonstruct]()
    private var arr = [DetailAppData]()
    var appId = "parsl"
    var environment = "production"
    @IBOutlet weak var button: UIButton!
    var platform = "ios"
    var appVeriosn = " "
    var buildNo = " "
    let urll = URL(string: "https://restcountries.eu/rest/v2/all")!
    // MARK:- life Cycle
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
    func urlRequest(param: [String:Any]) {
        var headers: HTTPHeaders
            headers = [
                "Accept": "application/json"
            ]

        Alamofire.request(detailAppUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON{(response) -> Void in
//            print(response)
            switch (response.result) {
            case .success:
                let response = response.result.value!
                let dictionary = response as! [String:Any]
                let obj = DetailAppRoot(fromDictionary: dictionary)
                self.button.setTitle(obj.message, for: .normal)
                if obj.message == "Success"{
                    print(obj.message!)
                    self.arr = obj.data
                    for i in self.arr{
                        print(i.environment!)
                    }
//                    let alert = Constants.showAlert(message: obj.message)
//                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = Constants.showAlert(message: obj.message)
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
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
////                print(self.arr)
//                for mai in self.arr{
//                    print(mai.name,":", mai.region)
//                }
//
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
    }
//    func checkVersion(param: [String: Any]) {
//        UserHandler.checkVersion(param: param) { [self] (successResponse) in
//            if (successResponse.status as AnyObject) as? NSString == "1"{
//                let alert = Constants.showAlert(message: successResponse.message)
//                self.present(alert, animated: true, completion: nil)
//            }
//            else {
//                let alert = Constants.showAlert(message: successResponse.message)
//                self.present(alert, animated: true, completion: nil)
//            }
//        } failure: { (error) in
//            let alert = Constants.showAlert(message: error.message)
//            self.present(alert, animated: true, completion: nil)
//        }
//
//    }
    

    
    @IBAction func getRequest(_ sender: UIButton) {
        let params : [String : AnyObject] = ["app_id": appId as AnyObject]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        urlRequest(param: data)
//        let params: [String: AnyObject] = ["platform": platform as AnyObject, "app_id": appId as AnyObject, "version_no": appVeriosn as AnyObject, "environment": environment as AnyObject, "build_no": buildNo as AnyObject ] // swiftlint:disable:this line_length
//        let data : [String : AnyObject] = ["data": params as AnyObject]
//        print(data)
//        checkVersion(param: data)
    }
}


// SwiftLint: enable all
