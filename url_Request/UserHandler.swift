
//  kalam
//
//  Created by mac on 22/10/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

typealias Parameters = [String:Any]

class UserHandler {
    
    static let shared = UserHandler()
    
    private init() {}
    
    //MARK:- get all apps.
    class func getAllApps(param: [String:Any], success: @escaping(AllAppsRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: allAppUrl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = AllAppsRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- get detail of an app
    class func getDetail(param: [String:Any], success: @escaping(DetailAppRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: detailAppUrl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = DetailAppRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- check app version
    class func checkVersion(param: [String:Any], success: @escaping(CheckVersionRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: checkAppVersion, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = CheckVersionRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- update app version
    class func updateVersion(param: [String:Any], success: @escaping(UpdateVersionRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: updateVersionUrl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = UpdateVersionRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- add app
    class func addApp(param: [String:Any], success: @escaping(AddAppRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: addAppUrl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = AddAppRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

}
