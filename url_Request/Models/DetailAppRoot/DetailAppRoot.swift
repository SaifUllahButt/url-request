
//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport
// swiftlint: disable all
import Foundation

struct DetailAppRoot{

    var data : [DetailAppData]!
    var message : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        data = [DetailAppData]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = DetailAppData(fromDictionary: dic)
                data.append(value)
            }
        }
        message = dictionary["message"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        if message != nil{
            dictionary["message"] = message
        }
        return dictionary
    }

}

// swiftlint : enable all
