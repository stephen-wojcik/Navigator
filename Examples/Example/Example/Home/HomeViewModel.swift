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
    
    init(
        onNextPageTapped: @escaping @MainActor () -> Void,
        onSettingsTapped: @escaping @MainActor () -> Void
    ) {
        self.onNextPageTapped = onNextPageTapped
        self.onSettingsTapped = onSettingsTapped
        print("> HomeViewModel.init")
    }
    
    deinit {
        print("< HomeViewModel.deinit")
    }
    
    @MainActor func didTapNextPage() {
        onNextPageTapped()
    }
    
    @MainActor func didTapSettings() {
        onSettingsTapped()
    }
}
