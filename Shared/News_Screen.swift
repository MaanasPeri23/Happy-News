//
//  ContentView.swift
//  Shared
//
//  Created by Maanas Peri on 8/1/22.
//


//Most Up To Date Version

import Foundation
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct NewsHome: View {
    @ObservedObject var obj = headLineCalls()
    var body: some View {
        
        NavigationView{
            List(obj.articles){ index in
                
                VStack {
                    
                    VStack{
                        if index.image != "" {
                            WebImage(url: URL(string: index.image), options: .highPriority, context: nil)
                                .resizable()
                                .frame(width: 330, height: 200, alignment: .center)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(12)
                                .shadow(color: .gray, radius: 10, x: 0, y: 15)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(index.title)
                            .font(Font.headline.weight(.bold))
                            .lineLimit(2)
                        
                        Text(index.description)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                    .padding()
                    
                }.overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Color.gray, lineWidth: 0.0)
                )
                .onTapGesture {
                    print("tapped")
                    obj.openNews(url: index.url)
                }
                
            }.onAppear{
                obj.getNews()
            }
            .navigationBarTitle("Happy News")
            .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsHome()
    }
}
