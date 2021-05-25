//
//  Constants.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//



import UIKit


let suggesteeUrl = "https://talaa.net/API/suggested.php"
let uurl = "https://parsl.io/get/app/details"
let allAppUrl = "https://parsl.io/get/all/apps"
let detailAppUrl = "https://parsl.io/get/app/details"
let checkAppVersion = "https://parsl.io/check/version"
let updateVersionUrl = "https://parsl.io/update/version"

class Constants {
    
    static let imageUrl = "https://talaa.net/Images/"
    static let icon = "https://talaa.net/Icon/"
    struct URL {
        static let baseUrl = "http://157.245.218.165:5009/api/user/"
        
        static let signUp = "signup"
        static let signIn = "signin"
        static let socialSignIn = "social_signin"
        static let resetPassword = "forgot_password"
    }
    
    struct UserDefaultKeys {
        static let user = "user"
        static let isLogin = "isLogin"
    }
    
    struct AppColor {
        static let yellow = "#FFE294"
    }
    
    
    struct keys {
        static let twitterKey = "AOMC2GPl5reLWMtBuKxkgcD8F"
        static let twitterSecret = "Ptf3dIara1QONi06ODE8zHErUID5BGdY3x0Oge1a2WRdMTFpSN"
        static let token = "AAAAAAAAAAAAAAAAAAAAAPwlJQEAAAAA2KVpAxV0DfgT3x%2Fbke%2BW8HMljGQ%3DrnQxsUP4YJJTsYH0hgY9SurkEvA4xlUajWULrnNO8IbtwlH3og"
        static  let twitterUrlScheme = "twittersdk"
    }
    
    struct alertmessages {
        static let failure = "Network Error"
        static let success = "Success!"
    }
    
    struct NetworkSuccess {
        static let statusOK = 200
    }
    
    struct activitySize {
        static let size = CGSize(width: 40, height: 40)
    }
    
    enum loaderMessages : String {
        case loadingMessage = ""
    }
    
    static func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    struct DateFormat {
        static let fullDate = "MMM dd, yyyy hh:mm a"
        static let time = "hh:mm a"
        static let partialDate = "dd/MM/yyyy hh:mm a"
        static let dateFormat = "MMM dd, hh:mma"
        static let groupCreationDate = "dd-MM-yyyy"
    }
    
    struct NetworkError {
        static let timeOutInterval: TimeInterval = 100
        
        static let error = "Error"
        static let internetNotAvailable = "Network Error"
        static let pleaseTryAgain = "Network Error"
        
        static let generic = 4000
        static let genericError = "Network Error"
        
        static let serverErrorCode = 5000
        static let serverNotAvailable = "Network Error"
        static let serverError = "Network Error"
        
        static let timout = 4001
        static let timoutError = "Network Error"
        
        static let login = 4003
        static let loginMessage = "Unable To Login"
        static let loginError = "Please Try Again."
        
        static let internet = 4004
        static let internetError = "Network Error"
    }
}
