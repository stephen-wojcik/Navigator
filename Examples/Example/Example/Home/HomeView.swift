//
//  HomeView.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    init(viewModel: @escaping @autoclosure () -> HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        List {
            Button {
                viewModel.didTapNextPage()
            } label: {
                Text("Push Next Page")
            }
            
            Button {
                viewModel.didTapSettings()
            } label: {
                Text("Present Settings")
            }
        }
        .navigationTitle("Home")
    }
}
