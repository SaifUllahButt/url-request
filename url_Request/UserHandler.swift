
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
    
//    class func getPlaces(request: URLRequest, success: @escaping(PlacesRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
//        NetworkHandler.customPostRequest(urlRequest: request, success: { (successResponse) in
//            let dictionary = successResponse as! [String: Any]
//            let obj = PlacesRoot(fromDictionary: dictionary)
//            success(obj)
//        }) { (error) in
//            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
//        }
//    }
    
    class func getProfile(param: [String:Any], success: @escaping(Root)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: uurl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = Root(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    class func getAllApps(param: [String:Any], success: @escaping(AllAppsRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: allAppUrl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = AllAppsRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func getDetail(param: [String:Any], success: @escaping(DetailAppRoot)->Void, failure: @escaping(NetworkError)->Void) {
        NetworkHandler.postRequest(url: detailAppUrl, parameters: param) { (successResponse) in
            let dictionary = successResponse as! [String:Any]
            let obj = DetailAppRoot(fromDictionary: dictionary)
            success(obj)
        } failure: { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

}
