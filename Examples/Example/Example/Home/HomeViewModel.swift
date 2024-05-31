//
//  HomeViewModel.swift
//  Example
//
//  Created by Stephen Wojcik on 31/05/2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    var onNextPageTapped: @MainActor () -> Void = {}
    var onSettingsTapped: @MainActor () -> Void = {}
    
    @MainActor func didTapNextPage() {
        onNextPageTapped()
    }
    
    @MainActor func didTapSettings() {
        onSettingsTapped()
    }
}
