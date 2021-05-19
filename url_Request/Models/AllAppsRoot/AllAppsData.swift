
//
//    Data.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AllAppsData{

    var appBundleId : String!
    var appId : String!
    var appName : String!
    var platform : [String]!
    var timestamp : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        appBundleId = dictionary["app_bundle_id"] as? String
        appId = dictionary["app_id"] as? String
        appName = dictionary["app_name"] as? String
        platform = dictionary["platform"] as? [String]
        timestamp = dictionary["timestamp"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if appBundleId != nil{
            dictionary["app_bundle_id"] = appBundleId
        }
        if appId != nil{
            dictionary["app_id"] = appId
        }
        if appName != nil{
            dictionary["app_name"] = appName
        }
        if platform != nil{
            dictionary["platform"] = platform
        }
        if timestamp != nil{
            dictionary["timestamp"] = timestamp
        }
        return dictionary
    }

}
