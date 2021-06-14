//
//  NetworkHandler.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import Alamofire
import UIKit


class NetworkHandler {
    class func postRequest(url: String, parameters: Parameters?, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
        if Network.isAvailable {
            var headers: HTTPHeaders
                headers = [
                    "Accept": "application/json"
                ]
            debugPrint(headers)
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
            manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON{(response) -> Void in
                print(response)
                guard let statusCode = response.response?.statusCode else {
                    var networkError = NetworkError()
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    failure(networkError)
                    return
                }
                if statusCode == 422 {
                    var networkError = NetworkError()
                    
                    let response = response.result.value!
                    let dictionary = response as! [String: AnyObject] // swiftlint:disable:this force_cast
                    
                    guard let message = dictionary["error"] as! String?// swiftlint:disable:this force_cast
                    else {
                        networkError.status = statusCode
                        networkError.message = "Validation Error"
                        failure(networkError)
                        return
                    }
                    networkError.status = statusCode
                    networkError.message = message
                    failure(networkError)
                } else {
                    switch (response.result) {
                    case .success:
                        let response = response.result.value!
                        success(response)
                        break
                    case .failure(let error):
                        var networkError = NetworkError()
                        if error._code == NSURLErrorTimedOut {
                            networkError.status = Constants.NetworkError.timout
                            networkError.message = Constants.NetworkError.timoutError
                            failure(networkError)
                        } else {
                            networkError.status = Constants.NetworkError.generic
                            networkError.message = Constants.NetworkError.genericError
                            failure(networkError)
                        }
                        break
                    }
                }
            }
        } else {
            let networkError = NetworkError(status: Constants.NetworkError.internet, message: Constants.NetworkError.internetError)
            failure(networkError)
        }
    }
    
    
    
    class func customPostRequest(urlRequest: URLRequest, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
            if Network.isAvailable {
                Alamofire.request(urlRequest).responseJSON{ response in
                    print(response)
                    guard let statusCode = response.response?.statusCode else {
                        var networkError = NetworkError()
                        networkError.status = Constants.NetworkError.timout
                        networkError.message = Constants.NetworkError.timoutError
                        failure(networkError)
                        return
                    }
                    if statusCode == 422 {
                        var networkError = NetworkError()
                        
                        let response = response.result.value!
                        let dictionary = response as! [String: AnyObject] // swiftlint:disable:this force_cast
                        
                        guard let message = dictionary["error"] as! String? // swiftlint:disable:this force_cast
                        else {
                            networkError.status = statusCode
                            networkError.message = "Validation Error"
                            
                            failure(networkError)
                            
                            return
                        }
                        networkError.status = statusCode
                        networkError.message = message
                        
                        failure(networkError)
                        
                        
                    } else {
                        switch (response.result) {
                        case .success:
                            let response = response.result.value!
                            success(response)
                            break
                        case .failure(let error):
                            var networkError = NetworkError()
                            
                            if error._code == NSURLErrorTimedOut {
                                networkError.status = Constants.NetworkError.timout
                                networkError.message = Constants.NetworkError.timoutError
                                
                                failure(networkError)
                            } else {
                                networkError.status = Constants.NetworkError.generic
                                networkError.message = Constants.NetworkError.genericError
                                failure(networkError)
                            }
                            break
                        }
                    }
                }
            } else {
                let networkError = NetworkError(status: Constants.NetworkError.internet, message: Constants.NetworkError.internetError)
                failure(networkError)
            }
        }
    
    class func getRequest(url: String, parameters: Parameters?, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        var headers: HTTPHeaders
            headers = [
                "Accept": "application/json"
            ]
        debugPrint(headers)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = Constants.NetworkError.timeOutInterval
        manager.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            switch response.result{
            //Case 1
            case .success:
                let response = response.result.value!
                success(response)
                break
            case .failure (let error):
                var networkError = NetworkError()
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    failure(networkError)
                } else {
                    networkError.status = Constants.NetworkError.generic
                    networkError.message = Constants.NetworkError.genericError
                    failure(networkError)
                }
                break
            }
        }
    }
    
    //MARK: Upload Multipart File
    
    class func upload(url: String, fileUrl: URL, fileName: String, params: Parameters?, uploadProgress: @escaping (Int) -> Void, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) { // swiftlint:disable:this line_length
        var headers: HTTPHeaders
            headers = [
                "Accept": "application/json"
            ]
        debugPrint(headers)
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(fileUrl, withName: fileName)
            if let parameters = params {
                for (key, value) in parameters {
                    multipartFormData.append(("\(value)").data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    let progress = Int(progress.fractionCompleted * 100)
                    uploadProgress(progress)
                })
                upload.responseJSON { response in
                    debugPrint(response)
                    if let returnValue = response.result.value {
                        success(returnValue)
                    } else {
                        var networkError = NetworkError()
                        networkError.status = Constants.NetworkError.generic
                        networkError.message = Constants.NetworkError.genericError
                        failure(networkError)
                    }
                }
            case .failure(let error):
                var networkError = NetworkError()
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constants.NetworkError.timout
                    networkError.message = Constants.NetworkError.timoutError
                    failure(networkError)
                } else {
                    networkError.status = Constants.NetworkError.generic
                    networkError.message = Constants.NetworkError.genericError
                    failure(networkError)
                }
            }
        })
    }
}

struct NetworkError {
    var status: Int = Constants.NetworkError.generic
    var message: String = Constants.NetworkError.genericError
}

struct NetworkSuccess {
    var status: Int = Constants.NetworkSuccess.statusOK
//    var message: String = Constants.NetworkSuccess
}
