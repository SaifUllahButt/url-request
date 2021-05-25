//
//  UpdateVersionRoot.swift
//  url_Request
//
//  Created by M Zaryab on 25/05/2021.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import Foundation


import Foundation

struct UpdateVersionRoot{

    var message : String!
    var status : Bool!


   
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String
        status = dictionary["status"] as? Bool
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

}
