//
//  NASA_API.swift
//  Project_Gumba
//
//  Created by Maanas Peri on 8/4/21.
//

import Foundation
import SwiftyJSON
import SDWebImageSwiftUI
import SwiftUI

struct NASA_Image: Codable{
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
}

class NASA_APICalls{
    
//    @Published var img: NASA_Image
//
//    init(){
//        self.img = NASA_Image(date: "", explanation: "", hdurl: "", media_type: "", service_version: "", title: "", url: "")
//    }
    @Published var dictionary = [
        "date": "",
        "explanation": "",
        "hdurl": "",
        "media_type": "",
        "service_version": "",
        "title": "",
        "url": ""
    ]
    
    func imageOfTheDay(){
        let api_key = "h1CaejUiKHqQ22lhhIwXyaXA3yCVKB0NioX9Vkms"
        let endpoint = "https://api.nasa.gov/planetary/apod?api_key=\(api_key)"
        
        guard let url = URL(string: endpoint) else {
            print("Trouble parsing url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let response = try! JSONDecoder().decode(NASA_Image.self, from: data!)
            
            //if error comes up may or may not need DispatchQueue
            let date = response.date
            let explanation = response.explanation
            let hdurl = response.hdurl
            let media_type = response.media_type
            let service_version = response.service_version
            let title = response.title
            let urlImage = response.url
            //print(response)
            
            self.dictionary = [
                "date": date,
                "explanation": explanation,
                "hdurl": hdurl,
                "media_type": media_type,
                "service_version": service_version,
                "title": title,
                "url": urlImage
            ]
            
        }.resume()
    }
}
