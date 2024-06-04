//
//  SomeNextPageView.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

struct NextPageView: View {
    
    @StateObject var viewModel: NextPageViewModel
    
    init(viewModel: @autoclosure @escaping () -> NextPageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        List {
            Button {
                viewModel.didTapIncrement()
            } label: {
                Text("Counter value: \(viewModel.counterValue)")
            }
            
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
