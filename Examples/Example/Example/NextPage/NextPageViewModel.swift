//
//  NextPageViewModel.swift
//  Example
//
//  Created by Stephen Wojcik on 31/05/2024.
//

import SwiftUI

class NextPageViewModel: ObservableObject {
    
    var onNextPageTapped: @MainActor () -> Void = {}
    var onSettingsTapped: @MainActor () -> Void = {}
    var onExitTapped: @MainActor () -> Void = {}
    
    @MainActor func didTapNextPage() {
        onNextPageTapped()
    }
    
    @MainActor func didTapSettings() {
        onSettingsTapped()
    }
    
    @MainActor func didTapExit() {
        onExitTapped()
    }
}
