//
//  SettingsView.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    init(viewModel: @escaping @autoclosure () -> SettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        List(viewModel.settings, id: \.self) { setting in
            Button {
                viewModel.didTapSetting(setting)
            } label: {
                Text(setting)
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button {
                    viewModel.didTapClose()
                } label: {
                    Text("Close")
                }
            }
        }
    }
}
