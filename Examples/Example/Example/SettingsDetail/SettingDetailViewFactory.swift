//
//  SomeSettingDetailViewFactory.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI
import Navigator

class SettingDetailViewFactory {
    func make(navigator: Navigator, setting: String) -> some View {
        let viewModel = SettingDetailViewModel(setting: setting)
        
        viewModel.onDoneTapped = {
            navigator.denavigate()
        }
        
        return SettingDetailView(viewModel: viewModel)
    }
}
