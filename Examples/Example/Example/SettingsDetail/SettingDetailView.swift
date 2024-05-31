//
//  SomeSettingDetailView.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

struct SettingDetailView: View {
    
    @ObservedObject var viewModel: SettingDetailViewModel
    
    var body: some View {
        Button {
            viewModel.didPressDone()
        } label: {
            Text("Done")
        }
        .navigationTitle(viewModel.setting)
    }
}
