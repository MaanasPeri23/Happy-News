//
//  APICall.swift
//  Project_Gumba
//
//  Created by Maanas Peri on 8/1/21.
//

//Resource: https://learnappmaking.com/escaping-closures-swift/

import Foundation
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import NaturalLanguage

struct Article: Identifiable {
    var id: String
    var title: String
    var description: String
    var image: String
    var url: String
    //content attribute?
    //make each article a butotn, when clicked on, it displays the same attributes here for that article["something"] to specify it
}

//matches with the array value that's going to also be declared as an observable object
class headLineCalls: ObservableObject{
    
    @Published var articles = [Article]()
    @Published var temp = [Article]()
    @Published var usedNames = [String]()

    
    func getNews(){
        let api_key = "ca6af828213d4f7db9370b3374209c3e"
        //topic related to apple
        //figure out what topics am i going to need
        let topic_endpoint = "https://newsapi.org/v2/everything?q=tech&pageSize=100&language=en&apiKey=\(api_key)"
        //let topic_endpoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(api_key)"
        
        guard let url = URL(string: topic_endpoint) else {
            print("Error creating url object")
            return
        }
        let request = URLRequest(url: url)
                    
        URLSession.shared.dataTask(with: request){ data, _, error in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            if let data = data {
                
                let response = try! JSON(data: data)
                
                for index in response["articles"]{
                    //dictionary array - which is why its index.(0 or 1)
                    let id = index.1["publishedAt"].stringValue
                    let title = index.1["title"].stringValue
                    let description = index.1["description"].stringValue
                    let image = index.1["urlToImage"].stringValue
                    let url = index.1["url"].stringValue
                    
                    
                    //dispatchqueue adds it to main thread to be executed
                    DispatchQueue.main.async {
                        //print(response)
                        //appends it into newsData variable
                        if self.getSentimentFromBuildInAPI(text: title) == 1{
                            self.temp.append(Article(id: id, title: title, description: description, image: image, url: url))
                            self.removeDuplications()
                        }
                        //https://dev.to/nemecek_f/how-to-quickly-remove-duplicates-from-array-keep-order-1p8l
                    }
                }
            }
        }.resume()
    }
    
    func removeDuplications(){
        for index in self.temp{
            if(!self.usedNames.contains(index.title)){
                self.articles.append(Article(id: index.id, title: index.title, description: index.description, image: index.image, url: index.url))
                self.usedNames.append(index.title)
            }
        }
    }
    
    func openNews(url: String) -> Void {
        //print(url)
        if let link = URL(string: url){
            UIApplication.shared.open(link)
        }
    }
    
    func getSentimentFromBuildInAPI(text: String) -> Int {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)

        let sentimentScore = Double(sentiment?.rawValue ?? "")

        var finalScore = 0

        if let score = sentimentScore {
            if score < 0 {
                finalScore = 0 // Negative
            } else if score > 0 {
                finalScore = 1 // Positive
            } else {
                finalScore = -1 // Neutral
            }
        }

        return finalScore
    }
    
//    func topic_call(topic: String){
//        let api_key = "ca6af828213d4f7db9370b3374209c3e"
//        //topic related to apple
//        let topic_endpoint = "https://newsapi.org/v2/top-headlines?q=\(topic)&apiKey=\(api_key)"
//
//        guard let url = URL(string: topic_endpoint) else {
//            print("Error creating url object")
//            return
//        }
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request){ data, _, error in
//
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//
//            if let data = data {
//
//                let response = try! JSON(data: data)
//
//                for index in response["articles"]{
//                    let id = index.1["publishedAt"].stringValue
//                    let title = index.1["title"].stringValue
//                    let description = index.1["description"].stringValue
//                    let image = index.1["urlToImage"].stringValue
//                    let url = index.1["url"].stringValue
//
//                    //dispatchqueue adds it to main thread to be executed
//                    DispatchQueue.main.async {
//                        //print(response)
//                        //appends it into newsData variable
//                        self.topicNewsData.append(NewsDataType(id: id, title: title, description: description, image: image, url: url))
//                    }
//                }
//            }
//        }.resume()
//    }
}
