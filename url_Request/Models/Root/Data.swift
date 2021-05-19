
//    Data.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Data{

    var appId : String!
    var buildNo : String!
    var environment : String!
    var latest : Int!
    var platform : String!
    var versionNo : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        appId = dictionary["app_id"] as? String
        buildNo = dictionary["build_no"] as? String
        environment = dictionary["environment"] as? String
        latest = dictionary["latest"] as? Int
        platform = dictionary["platform"] as? String
        versionNo = dictionary["version_no"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if appId != nil{
            dictionary["app_id"] = appId
        }
        if buildNo != nil{
            dictionary["build_no"] = buildNo
        }
        if environment != nil{
            dictionary["environment"] = environment
        }
        if latest != nil{
            dictionary["latest"] = latest
        }
        if platform != nil{
            dictionary["platform"] = platform
        }
        if versionNo != nil{
            dictionary["version_no"] = versionNo
        }
        return dictionary
    }

}
