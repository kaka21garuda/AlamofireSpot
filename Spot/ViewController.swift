//
//  ViewController.swift
//  Spot
//
//  Created by Buka Cakrawala on 10/10/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {
    var searchURL = "https://api.spotify.com/v1/search?q=Justin+Bieber&type=track&offset=20"
    typealias standardJSON = [String: AnyObject]
    //
    var namesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        alamofire(url: searchURL)
        
    }
    
    func alamofire(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
            
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! standardJSON
            if let tracks = readableJSON["tracks"] as? standardJSON {
                if let items = tracks["items"] as? standardJSON {
                    for i in 0..<items.count {
                        let item = items[i]
                        let name = item["name"]
                        namesArray.append(name)
                        
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
  
}

