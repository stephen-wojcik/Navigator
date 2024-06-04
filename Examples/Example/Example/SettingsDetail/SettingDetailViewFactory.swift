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
        return SettingDetailView(
            viewModel: SettingDetailViewModel(
                setting: setting, 
                onDoneTapped: {
                    navigator.denavigate()
                }
            )
        )
    }
}
