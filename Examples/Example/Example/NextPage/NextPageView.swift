//
//  SomeNextPageView.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

struct NextPageView: View {
    
    @ObservedObject var viewModel: NextPageViewModel
    
    var body: some View {
        List {
            Button {
                viewModel.didTapNextPage()
            } label: {
                Text("Push Another Page")
            }
            
            Button {
                viewModel.didTapSettings()
            } label: {
                Text("Present Settings")
            }
            
            Button {
                viewModel.didTapExit()
            } label: {
                Text("Pop to Root")
            }
        }
        .navigationTitle("Next Page")
    }
}
