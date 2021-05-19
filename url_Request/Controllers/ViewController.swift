//
//  ViewController.swift
//  url_Request
//
//  Created by Zaryab on 8/13/20.
//  Copyright © 2020 M Zaryab. All rights reserved.
//

import UIKit
struct jsonstruct: Decodable{
    
    let name: String
    let region: String
    
}

class ViewController: UIViewController {
    
    private var arr = [jsonstruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func urlRequest() {
        let session = URLSession.shared
        let url = URL(string: "https://restcountries.eu/rest/v2/all")!
      
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                self.arr = try JSONDecoder().decode([jsonstruct].self, from: data!)
                for mai in self.arr{
                    print(mai.name,":", mai.region)
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    @IBAction func getRequest(_ sender: UIButton) {
        urlRequest()
    }
}


