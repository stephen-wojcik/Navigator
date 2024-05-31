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
    
    init(setting: String) {
        self.setting = setting
    }
    
    @MainActor func didPressDone() {
        onDoneTapped()
    }
}
