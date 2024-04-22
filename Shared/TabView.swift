//
//  TabView.swift
//  Gumba_Project
//
//  Created by Maanas Peri on 8/16/22.
//

import Foundation
import SwiftUI

struct MenuView: View {
    var body: some View {
        
        TabView {
            NewsHome()
                .tabItem{
                    Label("News", systemImage: "house")
                }
            FunView()
                .tabItem{
                    Label("Doggos", systemImage: "heart")
                }
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
