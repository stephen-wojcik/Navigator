//
//  SettingDetailViewModel.swift
//  Example
//
//  Created by Stephen Wojcik on 31/05/2024.
//

import SwiftUI

class SettingDetailViewModel: ObservableObject {
    
    let setting: String
    var onDoneTapped: @MainActor () -> Void = {}
    
    init(
        setting: String,
        onDoneTapped: @escaping @MainActor () -> Void
    ) {
        self.setting = setting
        self.onDoneTapped = onDoneTapped
        print("> SettingDetailViewModel.init")
    }
    
    deinit {
        print("< SettingDetailViewModel.deinit")
    }
    
    @MainActor func didPressDone() {
        onDoneTapped()
    }
}
