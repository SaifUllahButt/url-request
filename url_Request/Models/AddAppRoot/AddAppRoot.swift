//
//  File.swift
//  url_Request
//
//  Created by M Zaryab on 26/05/2021.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import Foundation

struct AddAppRoot{

    var message : String!


    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        return dictionary
    }

}
