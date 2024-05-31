//
//  ExampleApp.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI
import Navigator

@main
struct ExampleApp: App {
    
    let homeView = HomeViewFactory().make()
    
    var body: some Scene {
        WindowGroup {
            homeView
        }
    }
}
