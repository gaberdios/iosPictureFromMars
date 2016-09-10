//
//  ViewController.swift
//  weather
//
//  Created by G on 10/09/16.
//  Copyright © 2016 gaberdios. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class ViewController: UIViewController {
    @IBOutlet var marsPhotoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateString = getDateString()
        Alamofire.request(.GET, "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos", parameters: ["api_key": "DEMO_KEY", "earth_date": dateString])
            .responseJSON { response in
                if let result = response.result.value {
                    let json = JSON(result)
                    if let imageURL = json["photos"][0]["img_src"].string {
                        // Replace "http" with "https" in the image URL.
                        let httpsURL = imageURL.stringByReplacingOccurrencesOfString("http", withString: "https")
                        let URL = NSURL(string: httpsURL)!
                        
                        // Set the ImageView with an image from a URL
                        self.marsPhotoImageView.af_setImageWithURL(URL)
                    }
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDateString() -> String {
        let calendar = NSCalendar.currentCalendar()
        let yesterday = calendar.dateByAddingUnit(.Day, value: -5, toDate: NSDate(), options: [])
        let components = calendar.components([.Day , .Month , .Year], fromDate: yesterday!)
        
        return "\(components.year)-\(components.month)-\(components.day)"
    }


}

