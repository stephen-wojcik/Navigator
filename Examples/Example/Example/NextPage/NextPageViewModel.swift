//
//  NextPageViewModel.swift
//  Example
//
//  Created by Stephen Wojcik on 31/05/2024.
//

import SwiftUI

class NextPageViewModel: ObservableObject {
    
    @Published private(set) var counterValue: Int = 0
    
    var onNextPageTapped: @MainActor () -> Void = {}
    var onSettingsTapped: @MainActor () -> Void = {}
    var onExitTapped: @MainActor () -> Void = {}
    
    init(
        onNextPageTapped: @MainActor @escaping () -> Void,
        onSettingsTapped: @MainActor @escaping () -> Void,
        onExitTapped: @MainActor @escaping () -> Void
    ) {
        self.onNextPageTapped = onNextPageTapped
        self.onSettingsTapped = onSettingsTapped
        self.onExitTapped = onExitTapped
        print("> NextPageViewModel.init")
    }
    
    deinit {
        print("< NextPageViewModel.deinit")
    }
    
    @MainActor func didTapNextPage() {
        onNextPageTapped()
    }
    
    @MainActor func didTapSettings() {
        onSettingsTapped()
    }
    
    @MainActor func didTapExit() {
        onExitTapped()
    }
    
    @MainActor func didTapIncrement() {
        counterValue += 1
    }
}
