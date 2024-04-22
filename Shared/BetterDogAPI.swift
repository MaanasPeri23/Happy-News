//
//  BetterDogAPI.swift
//  Gumba_Project
//
//  Created by Maanas Peri on 8/22/22.
//

import Foundation
import SwiftyJSON
import SDWebImageSwiftUI
import SwiftUI

//struct SimpleDog {
//    let message: String
//    let status: String
//}

struct Dog: Codable {
    let breeds: [Breed]
    let id: String
    let url: String
    let width, height: Int
}

// MARK: - Breed
struct Breed: Codable {
    let weight, height: Eight
    let id: Int
    let name, bredFor, breedGroup, lifeSpan: String
    let temperament, referenceImageID: String

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case referenceImageID = "reference_image_id"
    }
}

struct Eight: Codable {
    let imperial, metric: String
}


class DogAPICalls: ObservableObject {
    
    @Published var mamaluteTemp = ""
    @Published var goldenTemp = ""
    @Published var samoyedTemp = ""
    @Published var chowTemp = ""
    @Published var huskyTemp = ""
    
    @Published var dictionary = [
        "name": "",
        "bred_for": "",
        "breed_group": "",
        "life_span": "",
        "temperament": "",
        "reference_image_id": ""
    ]
    
    @Published var randoImg = ""
    
    
    func getMamalute(){
        return getFavoriteDoggo(breed: "malamute")
//        return self.arrayOfImages["mamalute"]!
    }
    
    func getChowChow(){
        return getFavoriteDoggo(breed: "chow")
//        return self.arrayOfImages["chow"]!
    }
    
    func getHusky(){
        return getFavoriteDoggo(breed: "husky")
//        return self.arrayOfImages["husky"]!
    }
    
    func getSamoyed(){
        return getFavoriteDoggo(breed: "samoyed")
//        return self.arrayOfImages["samoyed"]!
    }
    
    func getGoldenRetriever(){
        return getFavoriteDoggo(breed: "retriever/golden")
    }
    
    //okieee i love alaskan malamutes, husky, chow chow, samoyed, rotweilers, pitbulls, and golden retrievers
    
    func getFavoriteDoggo(breed: String){
        
        guard let url = URL(string: "https://dog.ceo/api/breed/\(breed)/images/random") else {
            print("Trouble parsing url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            if let data = data {
                let response = try! JSON(data: data)
//                let randoIndex = Int.random(in: 0...(response.count - 1))
                let img = response["message"]
                
//                print(img)
                
                DispatchQueue.main.async {
                    if(breed == "malamute"){
                        self.mamaluteTemp = img.string ?? ""
                    }else if(breed == "chow"){
                        self.chowTemp = img.string ?? ""
                    }else if(breed == "husky"){
                        self.huskyTemp = img.string ?? ""
                    }else if(breed == "samoyed"){
                        self.samoyedTemp = img.string ?? ""
                    }else if(breed == "retriever/golden"){
                        self.goldenTemp = img.string ?? ""
                    }
                }
                
//                return img.string
            }
        }.resume()
    }
    
    func getRandoDoggo(){
        let headers = ["x-api-key": ProcessInfo.processInfo.environment["Dog_API_Key"]]

        let sampleTemperamentResponses = ["I see you reading this. I'm Batman.",
                                          "Pretend this is a insighftul doggo characteristic",
                                          "German Shephard >>>> this breed",
                                          "Asdfg"
        ]

        guard let url = URL(string: "https://api.thedogapi.com/v1/images/search") else {
            print("Trouble parsing url")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = (headers as! [String: String])

        URLSession.shared.dataTask(with: request){ data, response, error in

            //give it a second long break
            do{
                let dog_data: [Dog] = try JSONDecoder().decode([Dog].self, from: data!)

                DispatchQueue.main.async {
                    self.randoImg = dog_data[0].url
                    for index in dog_data[0].breeds{
//                        if dog_data[0].breeds.count != 0
                        self.dictionary["name"] = index.name
                        self.dictionary["bred_for"] = index.bredFor
                        self.dictionary["breed_group"] = index.breedGroup
                        self.dictionary["temperament"] = index.temperament
                    }
                }
//                print(self.dictionary)
            }catch{
                self.dictionary["name"] = "Idk we'll find out soon"
                self.dictionary["bred_for"] = "Entertainment. Idfk I SAID THAT WE WILL IDENTIFY HIM LATER"
                self.dictionary["breed_group"] = "Doesn't matter he is happy doggo stop asking questions"
                self.dictionary["temperament"] = sampleTemperamentResponses.randomElement()
                print((error.localizedDescription))
            }

            //dont know why this gives this error:Thread 2: Fatal error: Index out of range
//            print(dog_data[0].breeds[0].bredFor)
        }.resume()
    }
}
