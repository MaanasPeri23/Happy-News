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

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(25)
            .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
    }
}

struct FunView: View {
    
    @ObservedObject var obj = DogAPICalls()
    let rgbColor = Color(red: 0.0, green: 0.6, blue: 0.1)
    let rgbColor2 = Color(red: 0.0, green: 0.1, blue: 0.1)
    
    var body: some View{
        
        ScrollView{
            
            //See if we can do an array of the Published vars and cycle through the for loop
            //make it a dictionary one with the mamaluteTemp temp for image String and one with the function in an array
            //https://stackoverflow.com/questions/24418951/array-of-functions-in-swift
            //Mamalute
            VStack{
                Text("Mamalute Of The Day")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(height: 20)
                
                if obj.mamaluteTemp != "" {
                    WebImage(url: URL(string: obj.mamaluteTemp), options: .highPriority, context: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .frame(width: 300, height: 200, alignment: .center)
                        .shadow(color: .gray, radius: 20, x: 0, y: 15)
                    
                }
                
                Button(action:{
                    self.obj.getMamalute()
                }){
                    HStack{
                        Image(systemName: "plus")
                        Text("New Mamalute")
                    }
                }
                .buttonStyle(GradientButtonStyle())
            }
            
            Spacer().frame(height: 20)
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            //Golden
            VStack{
                
                Text("Golden Retriever Of The Day")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(height: 20)
                
                if obj.goldenTemp != "" {
                    WebImage(url: URL(string: obj.goldenTemp), options: .highPriority, context: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .frame(width: 300, height: 200, alignment: .center)
                        .shadow(color: .gray, radius: 20, x: 0, y: 15)
                    
                }
                
                Button(action:{
                    self.obj.getGoldenRetriever()
                }){
                    HStack{
                        Image(systemName: "plus")
                        Text("New Golden")
                    }
                }
                .buttonStyle(GradientButtonStyle())
            }
            
            Spacer().frame(height: 20)
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            //Samoyed
            VStack{
                
                Text("Samoyed Of The Day")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(height: 20)
                
                if obj.samoyedTemp != "" {
                    WebImage(url: URL(string: obj.samoyedTemp), options: .highPriority, context: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .frame(width: 300, height: 200, alignment: .center)
                        .shadow(color: .gray, radius: 20, x: 0, y: 15)
                    
                }
                
                Button(action:{
                    self.obj.getSamoyed()
                }){
                    HStack{
                        Image(systemName: "plus")
                        Text("New Samoyed")
                    }
                }
                .buttonStyle(GradientButtonStyle())
            }
            
            Spacer().frame(height: 20)
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            //Chow Chow
            
            Group{
            VStack{
                
                Text("Chow Chow Of The Day")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(height: 20)
                
                if obj.chowTemp != "" {
                    WebImage(url: URL(string: obj.chowTemp), options: .highPriority, context: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .frame(width: 300, height: 200, alignment: .center)
                        .shadow(color: .gray, radius: 20, x: 0, y: 15)
                    
                }
                
                Button(action:{
                    self.obj.getChowChow()
                }){
                    HStack{
                        Image(systemName: "plus")
                        Text("New Chow Chow")
                    }
                }
                .buttonStyle(GradientButtonStyle())
            }
            
            Spacer().frame(height: 20)
                
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                //Husky
                VStack{
                    
                    Text("Husky Of The Day")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Spacer().frame(height: 20)
                    
                    if obj.huskyTemp != "" {
                        WebImage(url: URL(string: obj.huskyTemp), options: .highPriority, context: nil)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .frame(width: 300, height: 200, alignment: .center)
                            .shadow(color: .gray, radius: 20, x: 0, y: 15)
                        
                    }
                    
                    Button(action:{
                        self.obj.getHusky()
                    }){
                        HStack{
                            Image(systemName: "plus")
                            Text("New Husky")
                        }
                    }
                    .buttonStyle(GradientButtonStyle())
                }
                
                Spacer().frame(height: 20)
                
                
            
            }
            
            
            
            
            //Rando Doggo
            VStack{
                Text("Doggo Of the Day ")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(height: 10)
                
                if obj.randoImg != "" {
                    WebImage(url: URL(string: obj.randoImg), options: .highPriority, context: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .frame(width: 300, height: 200, alignment: .center)
                        .shadow(color: .gray, radius: 10, x: 0, y: 15)
                }
            }
            
            let name = self.obj.dictionary["name"]
            let bred_for = self.obj.dictionary["bred_for"]
            let breed_group = self.obj.dictionary["breed_group"]
            let temperament = self.obj.dictionary["temperament"]
            
            Group{
                
                VStack(alignment: .leading){
                    
                    Spacer().frame(height: 20)
                    
                    //these texts aren't showing up
                    Text(String("Breed: \(name ?? "")" ))
                        .font(.subheadline)
                    Text(String("Bred For: \(bred_for ?? "")" ))
                        .font(.subheadline)
                    Text(String("Breed Group: \(breed_group ?? "")"))
                        .font(.subheadline)
                    Text(String("Temperament: \(temperament ?? "")"))
                        .font(.subheadline)
                }.padding(.leading)
                
                Spacer().frame(height: 20)
                
                Button(action:{
                    self.obj.getRandoDoggo()
                }){
                    HStack{
                        Image(systemName: "plus")
                        Text("New Rando Doggo")
                    }
                }
                .buttonStyle(GradientButtonStyle())
            }
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
        .onAppear{
            // NASA_APICalls().imageOfTheDay()
            self.obj.getMamalute()
            self.obj.getGoldenRetriever()
            //            self.obj.getRandoDoggo()
            //            let bred_for = self.obj.dictionary["bred_for"]
            //            let breed_group = self.obj.dictionary["breed_group"]
            //            let life_span = self.obj.dictionary["life_span"]
            //            let temperament = self.obj.dictionary["temperament"]
        }
    }
}


struct FunView_Previews: PreviewProvider {
    static var previews: some View {
        FunView()
    }
}
