//
//  WoofyApp.swift
//  Woofy
//
//  Created by Olga Królikowska on 20/06/2023.
//

import SwiftUI

@main
struct WoofyApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Trocchi-Regular" , size: 34)!]
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
