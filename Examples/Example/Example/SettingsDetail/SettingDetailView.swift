//
//  SomeSettingDetailView.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

struct SettingDetailView: View {
    
    @StateObject var viewModel: SettingDetailViewModel
    
    init(viewModel: @escaping @autoclosure () -> SettingDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        Button {
            viewModel.didPressDone()
        } label: {
            Text("Done")
        }
        .navigationTitle(viewModel.setting)
    }
}
