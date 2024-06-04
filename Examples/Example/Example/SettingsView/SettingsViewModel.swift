//
//  SettingsViewModel.swift
//  Example
//
//  Created by Stephen Wojcik on 31/05/2024.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published private(set) var settings: [String] = ["Pushed", "Presented"]
    
    var onPushSettingTapped: @MainActor (_ setting: String) -> Void = { _ in }
    var onPresentSettingTapped: @MainActor (_ setting: String) -> Void = { _ in }
    var onCloseTapped: @MainActor () -> Void = {}
    
    init(
        onPushSettingTapped: @escaping @MainActor (_: String) -> Void,
        onPresentSettingTapped: @escaping @MainActor (_: String) -> Void,
        onCloseTapped: @escaping @MainActor () -> Void
    ) {
        self.onPushSettingTapped = onPushSettingTapped
        self.onPresentSettingTapped = onPresentSettingTapped
        self.onCloseTapped = onCloseTapped
        print("> SettingsViewModel.init")
    }
    
    deinit {
        print("< SettingsViewModel.deinit")
    }
    
    @MainActor func didTapSetting(_ setting: String) {
        if setting == "Pushed" {
            onPushSettingTapped(setting)
        } else if setting == "Presented" {
            onPresentSettingTapped(setting)
        }
    }
    
    @MainActor func didTapClose() {
        onCloseTapped()
    }
}
